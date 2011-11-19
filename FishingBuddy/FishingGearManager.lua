-- Interface with the Blizz Equipment Manager

local FL = LibStub("LibFishing-1.0");

local lastOutfit;

local gearframe = CreateFrame("Frame");
gearframe:Hide();
gearframe:SetScript("OnUpdate", function(self)
	if ( self.state == 0 ) then
		if ( FL:IsFishingPole() ) then
			local icon, idxm1 = GetEquipmentSetInfoByName(self.name);
			if ( not icon ) then
				-- find the fishing icon
				local iconIndex = 1;
				for index=1,GetNumMacroIcons() do
					if ( FBConstants.FISHINGTEXTURE == GetMacroItemIconInfo(index) ) then
						iconIndex = index;
					end
				end
				-- save the set
				SaveEquipmentSet(self.name, iconIndex);
			end
			self.state = 1;
		end
	elseif ( self.state == 1 ) then
		-- reset slot ignore flags
		EquipmentManagerClearIgnoredSlotsForSave();
		EquipmentManager_EquipSet("FB_TEMP_OUTFIT");
		self.state = 2;
	elseif ( self.state == 2 ) then
		if ( not FL:IsFishingPole() ) then
			local icon , idxm1 = GetEquipmentSetInfoByName("FB_TEMP_OUTFIT");
			if ( icon ) then
				DeleteEquipmentSet("FB_TEMP_OUTFIT");
			end
			self.state = 3;
		end
	elseif ( self.state == 3 ) then
		local icon, idxm1 = GetEquipmentSetInfoByName("FB_TEMP_OUTFIT");
		if ( not icon ) then
			self.state = 4;
		end
	else
		self:Hide();
	end
end)

local function PrepGearFrame(name)
	gearframe.name = name;
	gearframe.state = 0;
	gearframe:Show();
end

local function GearManagerInitialize()
	local known, name = FL:GetFishingSkillInfo();
	if ( known ) then
		local icon, idxm1 = GetEquipmentSetInfoByName(FBConstants.NAME);
		if ( not icon ) then
			-- Let's build a fishing outfit
			-- but we actually have to equip the items for this to work
			-- let's save what we have on now...
			SaveEquipmentSet("FB_TEMP_OUTFIT", 1);
			for slot=1,19 do
				EquipmentManagerIgnoreSlotForSave(slot);
			end
			
			local outfit = FL:GetFishingOutfitItems(false) or {};
			for invslot,info in pairs(outfit) do
				EquipItemByName(info.link, invslot);
				EquipmentManagerUnignoreSlotForSave(invslot);
			end  -- for bags
			-- let's save this puppy
			PrepGearFrame(FBConstants.NAME);
		end
	end
end

local function GuessCurrentOutfit()
	local ret = {};
	local location_array = {};
	local numsets = GetNumEquipmentSets();
	for set = 1, numsets do
		ret[set] = 0;
		local eq_set_name, _, _ = GetEquipmentSetInfo(set);
		GetEquipmentSetLocations(eq_set_name, location_array);
		for s,location in pairs(location_array) do
			local onplayer, _, bags, _, _ = EquipmentManager_UnpackLocation(location);
			if onplayer and not bags then
				ret[set] = ret[set] + 1;
			end	
		end
	end
	local best_set = 1;
	local best_value = 0;
	for i = 1, numsets do
		if (best_value < ret[i]) then
			best_value = ret[i];
			best_set = i;
		end
	end
	local best_name, _, _ = GetEquipmentSetInfo(best_set);
	return best_name;
end

local function GetCurrentOutfit()
	local setname = PaperDollEquipmentManagerPane.selectedSetName;
	if ( setname ) then
		return setname;
	end
	if ( GetNumEquipmentSets() == 0 ) then
        return nil; -- there are no gear sets, give up
    end
	-- no gear set active, take best fit
	return GuessCurrentOutfit();
end

local function GearManagerSwitch(outfitName)
	if ( FL:IsFishingPole() ) then
		local name = FishingBuddy_Info["LastGearSet"];
		if ( not name ) then
			name, _, _ = GetEquipmentSetInfo(1);
		end
		EquipmentManager_EquipSet(name);
		FishingBuddy_Info["LastGearSet"] = nil;
	else
		local icon, idxm1 = GetEquipmentSetInfoByName(FBConstants.NAME);
		if ( icon ) then
			FishingBuddy_Info["LastGearSet"] = GetCurrentOutfit();
			EquipmentManager_EquipSet(FBConstants.NAME);
			return true;
		end
	end
	-- return nil;
end

local function OutfitPoints(outfit)
	local sp = 0;
	local bp = 0;
	if ( outfit )then
		local isp = FishingBuddy.OutfitManager.ItemStylePoints;
		local ibp = function(link) return FL:FishingBonusPoints(link); end;
		local items = GetEquipmentSetLocations(outfit);
		for slot,loc in pairs(items) do
			local player, bank, bags, slot, bag = EquipmentManager_UnpackLocation(loc);
			local link;
			if ( not bags ) then -- and (player or bank) 
				link = GetInventoryItemLink("player", slot);
			else -- bags
				link = GetContainerItemLink(bag, slot);
			end
			if ( link ) then
				_, link, _ = FL:SplitLink(link);
				sp = sp + isp(link);
				bp = bp + ibp(link);
			end
		end
	end
	return bp, sp;
end

local Saved_GearSetButton_OnEnter = GearSetButton_OnEnter;
local function Patch_GearSetButton_OnEnter(self)
	Saved_GearSetButton_OnEnter(self);
	local _, name = FL:GetFishingSkillInfo();
	if ( self.name and self.name == name ) then
		local bp, sp = OutfitPoints(name)
		if ( bp >= 0 ) then
			bp = "+"..bp;
		else
			bp = 0 - bp;
			bp = "-"..bp;
		end
		bp = name.." "..bp;
		local pstring;
		if ( points == 1 ) then
			pstring = FBConstants.POINT;
		else
			pstring = FBConstants.POINTS;
		end
		GameTooltip:AddDoubleLine(SKILL..": "..bp, "Draznar: "..sp, 1, 1, 1, 1, 1, 1);
		GameTooltip:Show();
	end
end
-- point to our new function so we get our own tooltip
GearSetButton_OnEnter = Patch_GearSetButton_OnEnter;

FishingBuddy.OutfitManager.RegisterManager(EQUIPMENT_MANAGER,
															 GearManagerInitialize,
															 function(useme) end,
															 GearManagerSwitch);
