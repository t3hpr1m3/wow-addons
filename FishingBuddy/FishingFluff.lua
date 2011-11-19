-- Random fun things to do while fishing
--
-- Turn on the fish finder
-- Change your title to "Salty"
-- Bring out a "fishing buddy"

local FL = LibStub("LibFishing-1.0");

local SALTY_TITLE = 51;
local PETSETTING = "FishingPetBuddies";
local ALLZOMGPETS = "GreatAndSmall";

-- Pet menu constants
local PET_NONE = -1;
local PET_FISHING = -2;
local PET_ALL = -3;
local FLUFF_DISPLAYED_PETS = 15;
local FLUFF_LINE_HEIGHT = 16;

-- the spell ids for the fishing pets
-- are these as unique as the critter ids? Should be...
local FISHINGPETS = {};
FISHINGPETS[33050] = -1; -- Magical Crawdad
FISHINGPETS[46425] = -1; -- Snarly
FISHINGPETS[46426] = -1; -- Chuck
FISHINGPETS[43697] = -1; -- Toothy
FISHINGPETS[43698] = -1; -- Muckbreath
FISHINGPETS[59250] = -1; -- Giant Sewer Rat
FISHINGPETS[62561] = -1; -- Strand Crawler
-- since we can't just do #FISHINGPETS
local NUM_FISHINGPETS = 7;

-- Debugging
FishingBuddy.FISHINGPETS = FISHINGPETS;

-- wrap settings
local FBGetSetting = FishingBuddy.GetSetting;
local FBGetSettingBool = FishingBuddy.GetSettingBool;

local function GetSettingBool(setting)
	if (FBGetSettingBool("FishingFluff")) then
		return FBGetSettingBool(setting);
	end
	-- return nil;
end

local function GetSetting(setting)
	if (FBGetSettingBool("FishingFluff")) then
		return FBGetSetting(setting);
	end
	-- return nil;
end

local ourpets = {};
local petmap = {};
local chosenpets = {};
local chosenmap = {};
local numchosen = 0;

local function AddChosenPet(spellid)
	chosenpets[spellid] = 1;
	numchosen = numchosen + 1;
	chosenmap[numchosen] = spellid;
end

local function FindCurrentPet()
	local n = GetNumCompanions("CRITTER");
	local settingpets = GetSetting(PETSETTING);
	local nowpet = 0;
	ourpets = {};
	petmap = {};
	chosenpets = {};
	numchosen = 0;
	local allpets = false;
	if ( type(settingpets) ~= "table" ) then
		settingpets = tonumber(settingpets);
	end
	if ( settingpets == PET_ALL ) then
		allpets = true;
	elseif ( type(settingpets) == "table" ) then
		for _,sid in pairs(settingpets) do
			AddChosenPet(sid);
		end
	end
	for id=1,n do
		local cID, cName, cSpellID, icon, here = GetCompanionInfo("CRITTER", id);
		if ( here ) then
			nowpet = cSpellID;
		end
		if ( FISHINGPETS[cSpellID] ) then
			FISHINGPETS[cSpellID] = id;
			if ( settingpets == PET_FISHING) then
				AddChosenPet(cSpellID);
			end
		end
		local wantit = (chosenpets[cSpellID] == 1) or allpets;
		if (allpets) then
			AddChosenPet(cSpellID);
		end
		tinsert(ourpets, { spell=cSpellID, icon=icon, name=cName, id=id, checked=wantit });
		petmap[cSpellID] = id;
	end
	return nowpet;
end

local FluffEvents = {};

local unTrack = nil;
local resetPVP = nil;
local resetPet = nil;

FluffEvents[FBConstants.FISHING_ENABLED_EVT] = function()
	if ( FishingBuddy.GetSettingBool("FishingFluff")) then
		if ( GetSettingBool("FindFish") ) then
			local findid = FL:GetFindFishID();
			if ( findid ) then
				local _, _, active, _ = GetTrackingInfo(findid);
				if (not active) then
					unTrack = true;
					SetTracking(findid, true);
				end
			end
		end
		if ( GetSettingBool("TurnOffPVP") ) then
			if (1 == GetPVPDesired() ) then
				resetPVP = true;
				SetPVP(0);
			end
		end
		if ( not (IsFlying() or IsMounted()) ) then
			local nowpet = FindCurrentPet();
			local pet = nowpet;
			if ( numchosen > 0 ) then
				local idx = random(1, numchosen);
				pet = chosenmap[idx];
			end
			if ( pet ~= nowpet and petmap[pet] ) then
				resetPet = nowpet;
				CallCompanion("CRITTER", petmap[pet]);
			end
		end
	end
end

local function Untrack(yes)
	if ( yes ) then
		local findid = FL:GetFindFishID();
		if ( findid ) then
			SetTracking(findid, false);
		end
	end
end

FluffEvents[FBConstants.FISHING_DISABLED_EVT] = function(started, logout)
	if ( resetPVP ) then
		SetPVP(1);
		resetPVP = nil;
	end
	if ( logout ) then
		FishingBuddy_Player["Untrack"] = unTrack;
	else
		Untrack(unTrack);
		unTrack = nil;
		if ( resetPet ) then
			if ( not (IsFlying() or IsMounted()) ) then
				if ( resetPet and petmap[resetPet] ) then
					CallCompanion("CRITTER", petmap[resetPet]);
				else
					DismissCompanion("CRITTER");
				end
			end
			resetPet = nil;
		end
	end
	unTrack = nil;
	resetPet = nil;
end

FluffEvents[FBConstants.LOGIN_EVT] = function()
	if ( FishingBuddy_Player["Untrack"] ) then
		FishingBuddy_Player["Untrack"] = nil;
		Untrack(1);
	end
end

function FishingPetsMenuScrollFrame_Update()
	local buttons = FishingPetsMenuScrollFrame.buttons;
	local menuchoices = FishingPetFrame.pets;
	local numButtons = #buttons;
	local scrollOffset = HybridScrollFrame_GetOffset(FishingPetsMenuScrollFrame); 
	local choice;
	for i = 1, numButtons do
		local idx = i + scrollOffset;
		choice = menuchoices[idx];
		if ( choice ) then
			buttons[i].text:SetText(choice.name);
			buttons[i].id = choice.id;
			buttons[i].meta = choice.meta;
			buttons[i].spell = choice.spell;
			if ( choice.checked ) then
				buttons[i].check:Show();
			else
				buttons[i].check:Hide();
			end
			buttons[i].idx = idx;
		end
	end
end

local function UpdateMenuText(petsetting)
	petsetting = petsetting or FishingBuddy.GetSetting(PETSETTING);
	if ( type(petsetting) ~= "table" ) then
		if ( petsetting == PET_NONE ) then
			FishingPetFrameText:SetText(NONE);
		elseif ( petsetting == PET_ALL ) then
			FishingPetFrameText:SetText(ALL);
		elseif ( petsetting == PET_FISHING ) then
			FishingPetFrameText:SetText(PROFESSIONS_FISHING);
		end
	else
		FishingPetFrameText:SetText(PET_PAPERDOLL);
	end
	
end

function FishingPets_UpdateMenu()
	HybridScrollFrame_CreateButtons(FishingPetsMenuScrollFrame, "FishingPetButtonTemplate");

	local buttons = FishingPetsMenuScrollFrame.buttons;
	local fontstringText = buttons[1].text;
	local fontstringWidth;			
	local maxWidth = 0;
	
	local petsetting = GetSetting(PETSETTING);
	if ( type(petsetting) ~= "table" ) then
		petsetting = tonumber(petsetting);
	end
	local petnames = {};
	petnames[1] = { };
	-- Let's make "none" an easy choice
	petnames[1].name = NONE;
	petnames[1].id = PET_NONE;
	petnames[1].checked = (petsetting == PET_NONE);
	petnames[1].meta = true;
	petnames[2] = { };
	petnames[2].name = PROFESSIONS_FISHING;
	petnames[2].id = PET_FISHING;
	petnames[2].checked = (petsetting == PET_FISHING);
	petnames[2].meta = true;
	petnames[3] = { };
	petnames[3].name = ALL;
	petnames[3].id = PET_ALL;
	petnames[3].checked = (petsetting == PET_ALL);
	petnames[3].meta = true;

	local menuidx = 4;
	for _,info in pairs(ourpets) do
		petnames[menuidx] = petnames[menuidx] or { };
		petnames[menuidx].name = info.name;
		petnames[menuidx].spell = info.spell;
		petnames[menuidx].id = info.id;
		petnames[menuidx].checked = info.checked;
		fontstringText:SetText(info.name);
		fontstringWidth = fontstringText:GetWidth();
		if ( fontstringWidth > maxWidth ) then
			maxWidth = fontstringWidth;
		end
		menuidx = menuidx + 1;
	end
	FishingPetFrame.pets = petnames; 
	UpdateMenuText(petsetting);
	maxWidth = maxWidth + 10;				
	for i = 1, #buttons do
		buttons[i]:SetWidth(maxWidth);
	end
	FishingPetsMenuScrollFrame:SetWidth(maxWidth + 34);
	FishingPetsMenuScrollFrameScrollChild:SetWidth(maxWidth + 34);
	local lc = #ourpets + 3;
	if ( lc <= FLUFF_DISPLAYED_PETS ) then 
		FishingPetsMenu:SetHeight(lc * FLUFF_LINE_HEIGHT + 26);
		-- adding 1 due to possible rounding errors in HybridScrollFrame
		FishingPetsMenuScrollFrame:SetHeight(lc * FLUFF_LINE_HEIGHT + 1);
	else				
		FishingPetsMenu:SetHeight(FLUFF_LINE_HEIGHT * FLUFF_DISPLAYED_PETS + 26);
		-- adding 1 due to possible rounding errors in HybridScrollFrame
		FishingPetsMenuScrollFrame:SetHeight(FLUFF_LINE_HEIGHT * FLUFF_DISPLAYED_PETS + 1);
	end
	HybridScrollFrame_Update(FishingPetsMenuScrollFrame, lc * FLUFF_LINE_HEIGHT, FishingPetsMenuScrollFrame:GetHeight());		
	FishingPetsMenuScrollFrame_Update();
	FishingPetFrameHolder:Show();
end

function FishingPetsButton_OnClick(self)
	PlaySound("igMainMenuOptionCheckBoxOff");
	if ( self.meta ) then
		FishingBuddy.SetSetting(PETSETTING, self.id);	
		FindCurrentPet();
		FishingPets_UpdateMenu();
	else
		local petnames = FishingPetFrame.pets;
		-- toggle
		if (chosenpets[self.spell] == 1) then
			chosenpets[self.spell] = 0;
			petnames[self.idx].checked = false;
		else
			chosenpets[self.spell] = 1;
			petnames[self.idx].checked = true;
		end
		local newpets = {};
		for sid,val in pairs(chosenpets) do
			if (val and val == 1) then
				tinsert(newpets, sid);
			end
		end
		local petsetting;
		if ( #newpets ) then
			if ( #newpets == #ourpets ) then
				petsetting = PET_ALL;
			else
				local count = 0;
				for petid,spellid in pairs(FISHINGPETS) do
					if ( chosenpets[petid] and chosenpets[petid] == 1 ) then
						count = count + 1;
					end
				end
				if ( count == #newpets and count == NUM_FISHINGPETS ) then
					petsetting = PET_FISHING;
				else
					petsetting = newpets;
				end
			end
		else
			petsetting = PET_NONE;
		end
		FishingBuddy.SetSetting(PETSETTING, petsetting);
		FindCurrentPet();
		UpdateMenuText(petsetting);
		for idx=1,3 do
			petnames[idx].checked = (petnames[idx].id == petsetting);
		end
		FishingPetsMenuScrollFrame_Update();
	end
end

function FishingPetsMenu_Toggle()
	if ( FishingPetsMenu:IsShown() ) then
		PlaySound("igMainMenuOptionCheckBoxOff");
		FishingPetsMenu:Hide(); 
	else		
		PlaySound("igMainMenuOptionCheckBoxOn");
		FishingPetsMenu:Show();
		FishingPetsMenuScrollFrame_Update();	
	end
end

local FluffOptions = {
	["FishingFluff"] = {
		["text"] = FBConstants.CONFIG_FISHINGFLUFF_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FISHINGFLUFF_INFO,
		["v"] = 1,
		["default"] = 1 },
	["FindFish"] = {
		["text"] = FBConstants.CONFIG_FINDFISH_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FINDFISH_INFO,
		["v"] = 1,
		["deps"] = { ["FishingFluff"] = "d" },
		["default"] = 1 },
	["FishingPetBuddies"] = {
		["tooltip"] = FBConstants.CONFIG_FISHINGBUDDY_INFO,
		["setup"] =
			function()
				FindCurrentPet();
				FishingPets_UpdateMenu();
				FishingPetsMenu:Hide();
			end,
		["visible"] =
			function()
				if (GetNumCompanions("CRITTER") > 0) then return 1; end;
			end,
		["button"] = "FishingPetFrameHolder",
		["margin"] = { 8, -8 },
		["deps"] = { ["FishingFluff"] = "h" },
		["default"] = PET_FISHING },
	["DrinkHeavily"] = {
		["text"] = FBConstants.CONFIG_DRINKHEAVILY_ONOFF,
		["tooltip"] = FBConstants.CONFIG_DRINKHEAVILY_INFO,
		["v"] = 1,
		["m"] = 1,
		["deps"] = { ["FishingFluff"] = "d" },
		["default"] = 1 },
};

local InvisibleOptions = {
	-- options not directly manipulatable from the UI
	[PETSETTING] = {
		["default"] = nil },
	[ALLZOMGPETS] = {
		["default"] = 0 },
};

FluffEvents["VARIABLES_LOADED"] = function(started)
	local pet = FishingBuddy.GetSetting(PETSETTING);
	FishingBuddy.OptionsFrame.HandleOptions(GENERAL, nil, FluffOptions);
	FishingBuddy.OptionsFrame.HandleOptions(nil, nil, InvisibleOptions);
	
	local f = CreateFrame("FRAME", "FishingPetFrameHolder");
	local frame = CreateFrame("FRAME", "FishingPetFrame", f, "FishingPetFrameTemplate");
	local drop = CreateFrame("FRAME", "FishingPetsMenu", f, "FishingPetPickerFrameTemplate");
	
	frame:SetPoint("TOPLEFT", f, "TOPLEFT", 2, 2);
	
	FishingPetFrameButton:SetScript("OnClick", FishingPetsMenu_Toggle);
	
	FindCurrentPet();
	
	local menuwidth = 0;
	for _,text in pairs( { NONE, ALL, PET_FISHING, PET_PAPERDOLL } ) do
		FishingPetFrameText:SetText(text);
		if (FishingPetFrameText:GetWidth() > menuwidth) then
			menuwidth = FishingPetFrameText:GetWidth();
		end
	end
	
	FishingPets_UpdateMenu();
	FishingPetsMenu:SetWidth(FishingPetsMenuScrollFrame:GetWidth());
	FishingPetsMenuScrollFrame:SetHeight(FLUFF_DISPLAYED_PETS * FLUFF_LINE_HEIGHT);
	HybridScrollFrame_OnLoad(FishingPetsMenuScrollFrame);
	FishingPetsMenuScrollFrame.update = FishingPetsMenuScrollFrame_Update;	
	HybridScrollFrame_CreateButtons(FishingPetsMenuScrollFrame, "FishingPetButtonTemplate");
	
	FishingPetFrameLabel:SetText(PET_TYPE_PET..": ");
	
	UIDropDownMenu_SetWidth(FishingPetFrame, menuwidth + 32);
	FishingPetFrame:SetHeight(32);
	
	FishingPetFrameHolder:SetHeight(FishingPetFrame:GetHeight() + 4);
	FishingPetFrameHolder:SetWidth(FishingPetFrame:GetWidth() + 4);
	
	FishingPetsMenu:SetWidth(210);
	FishingPetsMenu:SetPoint("TOPRIGHT", FishingPetFrameButton, "BOTTOMRIGHT");
	FishingPetsMenu:SetFrameLevel(FishingOptionsFrame:GetFrameLevel()+2);

end


FishingBuddy.API.RegisterHandlers(FluffEvents);

if ( FishingBuddy.Debugging ) then
	FishingBuddy.Commands["pets"] = {};
	FishingBuddy.Commands["pets"].func =
		function(what)
			local Debug = FishingBuddy.Debug;
			Debug("chosenpets");
			for spellid,_ in pairs(chosenpets) do
				Debug("%d %d", spellid, chosenpets[spellid]);
			end
			return true;
		end;
end
