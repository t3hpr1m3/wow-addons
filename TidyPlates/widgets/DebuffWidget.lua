
--[[
To Do List: 

Spell Priority 
		for spellid, priority in pairs(AuraPriorities) do
			for index = 1, 8 do
				if priority > (AuraSlotPriority[index] or 0 ) then
					tinsert(AuraSlotPriority, index, priority)
					tinsert(AuraSlotspellid, index, spellid)
					break
				end
			end
		end
		
		TidyPlates:RequestDelegateUpdate()		-- Delegate Update

--]]

TidyPlatesWidgets.DebuffWidgetBuild = 2

local PlayerGUID = UnitGUID("player")
local PolledHideIn = TidyPlatesWidgets.PolledHideIn
local FilterFunction = function() return 1 end
local AuraMonitor = CreateFrame("Frame")
local WatcherIsEnabled = false
local WidgetList, WidgetGUID = {}, {}
local UpdateWidget
local TargetOfGroupMembers = {}

local function SetFilter(func)
	if func and type(func) == "function" then
		FilterFunction = func
	end
end

local function GetAuraWidgetByGUID(guid)
	if guid then return WidgetGUID[guid] end
end

local function IsAuraShown(widget, aura)
		if widget and widget.IsShown then 
			for i = 1, 6 do
				if widget.AuraIconFrames[i] and widget.AuraIconFrames[i]:IsShown() then return true end
			end
		end
end

-- Raid Icon BIT Reference 4.1
local RaidIconBit

if (tonumber((select(2, GetBuildInfo()))) >= 14299) then
	-- 4.2
	RaidIconBit = {
		["STAR"] = 0x00000001,
		["CIRCLE"] = 0x00000002,
		["DIAMOND"] = 0x00000004,
		["TRIANGLE"] = 0x00000008,
		["MOON"] = 0x00000010,
		["SQUARE"] = 0x00000020,
		["CROSS"] = 0x00000040,
		["SKULL"] = 0x00000080,
	}
else
	 -- 4.1
	 RaidIconBit = {
		["STAR"] = 0x00100000,
		["CIRCLE"] = 0x00200000,
		["DIAMOND"] = 0x00400000,
		["TRIANGLE"] = 0x00800000,
		["MOON"] = 0x01000000,
		["SQUARE"] = 0x02000000,
		["CROSS"] = 0x04000000,
		["SKULL"] = 0x08000000,
	}
end

local RaidIconIndex = {
	"STAR",
	"CIRCLE",
	"DIAMOND",
	"TRIANGLE",
	"MOON",
	"SQUARE",
	"CROSS",
	"SKULL",
}

local ByRaidIcon = {}			-- Raid Icon to GUID 		-- ex.  ByRaidIcon["SKULL"] = GUID
local ByName = {}				-- Name to GUID (PVP)


-----------------------------------------------------
-- Default Filter
-----------------------------------------------------
local function DefaultFilterFunction(debuff) 
	if (debuff.duration < 600) then
		return true
	end
end

-----------------------------------------------------
-- Update Via Search
-----------------------------------------------------

local function FindWidgetByGUID(guid)
	return WidgetGUID[guid]
end

local function FindWidgetByName(SearchFor)
	local widget
	--local SearchFor = strsplit("-", NameString)
	for widget in pairs(WidgetList) do
		if widget.unit.name == SearchFor then 
			return widget 
		end
	end
end

local function FindWidgetByIcon(raidicon)
	local widget
	for widget in pairs(WidgetList) do
		if widget.unit.isMarked and widget.unit.raidIcon == raidicon then return widget end
	end
end

local function CallForWidgetUpdate(guid, raidicon, name)
	local widget

	if guid then widget = FindWidgetByGUID(guid) end
	if (not widget) and name then widget = FindWidgetByName(name) end
	if (not widget) and raidicon then widget = FindWidgetByIcon(raidicon) end

	if widget then UpdateWidget(widget) end
end


-----------------------------------------------------
-- Aura Durations
-----------------------------------------------------
TidyPlatesData.CachedAuraDurations = {}

-- /run for i, v in pairs(TidyPlatesData.CachedAuraDurations) do print(i,v) end
local function GetSpellDuration(spellid)
	if spellid then return TidyPlatesData.CachedAuraDurations[spellid] end
end

local function SetSpellDuration(spellid, duration)
	if spellid then TidyPlatesData.CachedAuraDurations[spellid] = duration end
end

-----------------------------------------------------
-- Aura Instances
-----------------------------------------------------

-- New Style
local AuraInstances = {}
-- AuraInstances[guid][aurainstance] = {}


local function WipeAuraList(guid)
	if guid and AuraInstances[guid] then
		wipe(AuraInstances[guid])
	end
end

local function GetAuraList(guid)
	if guid then
		return AuraInstances[guid]
	end
end

local function GetAuraInstance(guid, instanceid)
	if guid and instanceid then
		local spellid, expiration, stacks, caster, duration, texture
		spellid = AuraInstances[guid][instanceid].SpellID
		expiration = AuraInstances[guid][instanceid].Expiration
		stacks = AuraInstances[guid][instanceid].Stacks
		caster = AuraInstances[guid][instanceid].Caster
		duration = AuraInstances[guid][instanceid].Duration
		texture = AuraInstances[guid][instanceid].Texture
		return spellid, expiration, stacks, caster, duration, texture
	end
end

local function RemoveAuraInstance(guid, spellid, caster)
	if guid and spellid and AuraInstances[guid] then
		local instanceid = spellid..(tostring(caster or "UNKNOWN_CASTER"))
		local aurainstance = AuraInstances[guid][instanceid]
		if aurainstance then
			wipe(aurainstance)
			AuraInstances[guid][instanceid] = nil
		end
	end
end

local function SetAuraInstance(guid, spellid, expiration, stacks, caster, duration, texture)
	if guid and spellid and caster and texture then
		local instanceid = spellid..(tostring(caster or "UNKNOWN_CASTER"))
		AuraInstances[guid] = AuraInstances[guid] or {}
		AuraInstances[guid][instanceid] = AuraInstances[guid][instanceid] or {}
		AuraInstances[guid][instanceid].SpellID = spellid
		AuraInstances[guid][instanceid].Expiration = expiration
		AuraInstances[guid][instanceid].Stacks = stacks
		AuraInstances[guid][instanceid].Caster = caster
		AuraInstances[guid][instanceid].Duration = duration
		AuraInstances[guid][instanceid].Texture = texture
	end
end

local function CleanAuraLists()	
	local currentTime = GetTime()
	for guid, instances in pairs(AuraInstances) do
		for instanceid, instancedata in pairs(instances) do
			if instancedata.Expiration and instancedata.Expiration < currentTime then
				wipe(AuraInstances[guid][instanceid])
				AuraInstances[guid][instanceid] = nil
			end
		end
		CallForWidgetUpdate(guid, nil, nil)
	end
end

-----------------------------------------------------
-- Aura Updating Via UnitID
-----------------------------------------------------

local function UpdateAurasByUnitID(unitid)
		-- Limit to enemies, for now
		if UnitIsFriend("player", unitid) then return end																				-- FILTER: ENEMY UNIT
		
		-- Check the UnitIDs Debuffs
		local index
		local guid = UnitGUID(unitid)
		-- Reset Auras for a guid
		WipeAuraList(guid)
		-- Add auras
		for index = 1, 40 do
			local name , _, texture, count, debuffType, duration, expirationTime, unitCaster, _, _, spellid = UnitDebuff(unitid, index)		-- FILTER: DEBUFF
			if not name then break end
			-- Cache duration for future use
			SetSpellDuration(spellid, duration)
			-- Add aura to unit
			SetAuraInstance(guid, spellid, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture)

		end	

		local raidicon, name
		if UnitPlayerControlled(unitid) then name = UnitName(unitid) end
		raidicon = RaidIconIndex[GetRaidTargetIndex(unitid) or ""]
		if raidicon then ByRaidIcon[raidicon] = guid end
		
		CallForWidgetUpdate(guid, raidicon, name)
 end
 
 local function UpdateAuraByLookup(guid)
 	if guid == UnitGUID("target") then
		UpdateAurasByUnitID("target")
		-- return true
	elseif guid == UnitGUID("mouseover") then
		UpdateAurasByUnitID("mouseover")
		-- return true
	elseif TargetOfGroupMembers[guid] then
		local unit = TargetOfGroupMembers[guid]
		if unit then
			local unittarget = UnitGUID(unit.."target")
			if guid == unittarget then
				UpdateAurasByUnitID(unittarget)
				-- return true
			end
		end		
	end
	return false
 end
 
-----------------------------------------------------
-- Aura Updating Via Combat Log
-- local sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, spellName, spellSchool, auraType, stackCount = ...
-----------------------------------------------------

local function CombatLog_ApplyAura(...)
	local timestamp, sourceGUID, destGUID, destName, spellid = ...
	local duration = GetSpellDuration(spellid)
	local texture = GetSpellTexture(spellid)

	SetAuraInstance(destGUID, spellid, GetTime() + (duration or 0), 1, sourceGUID, duration, texture)
end

local function CombatLog_RemoveAura(...) 
	local timestamp, sourceGUID, destGUID, destName, spellid = ...

	RemoveAuraInstance(destGUID, spellid, sourceGUID)
end

local function CombatLog_UpdateAuraStacks(...) 
	local timestamp, sourceGUID, destGUID, destName, spellid, stackCount = ...
	local duration = GetSpellDuration(spellid)
	local texture = GetSpellTexture(spellid)
	SetAuraInstance(destGUID, spellid, GetTime() + (duration or 0), stackCount, sourceGUID, duration, texture)
end

-----------------------------------------------------
-- General Events
-----------------------------------------------------

local function EventUnitTarget()
	wipe(TargetOfGroupMembers)
	
	for name, unitid in pairs(TidyPlatesUtility.GroupMembers.UnitId) do
		local targetOf = unitid..("target" or "")
		if UnitExists(targetOf) then
			TargetOfGroupMembers[UnitGUID(targetOf)] = targetOf
		end
	end
end

local function EventPlayerTarget()	
	if UnitExists("target") then
		UpdateAurasByUnitID("target")
	end
end

local function EventUnitAura(unitid)
	if unitid == "target" then
		UpdateAurasByUnitID("target")
		-- call update - To do:
	elseif unitid == "focus" then
		UpdateAurasByUnitID("focus")
		-- call update 
	end
end

-----------------------------------------------------
-- Function Reference Lists
-----------------------------------------------------
local CombatLogEvents = {
	-- Refresh Expire Time
	["SPELL_AURA_APPLIED"] = CombatLog_ApplyAura,
	["SPELL_AURA_REFRESH"] = CombatLog_ApplyAura,
	-- Add a stack
	["SPELL_AURA_APPLIED_DOSE"] = CombatLog_UpdateAuraStacks,
	-- Remove a stack
	["SPELL_AURA_REMOVED_DOSE"] = CombatLog_UpdateAuraStacks,
	-- Expires Aura
	["SPELL_AURA_BROKEN"] = CombatLog_RemoveAura,
	["SPELL_AURA_BROKEN_SPELL"] = CombatLog_RemoveAura,
	["SPELL_AURA_REMOVED"] = CombatLog_RemoveAura,
}

local GeneralEvents = {
	["UNIT_TARGET"] = EventUnitTarget,
	["UNIT_AURA"] = EventUnitAura,
	["PLAYER_ENTERING_WORLD"] = CleanAuraLists,
	["PLAYER_REGEN_ENABLED"] = CleanAuraLists,
}



local GetCombatEventResults
if (tonumber((select(2, GetBuildInfo()))) >= 14299) then
	function GetCombatEventResults(...)
		local timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlag, spellid  = ...		-- WoW 4.2
		local auraType, stackCount = select(15, ...)
		return timestamp, combatevent, sourceGUID, destGUID, destName, destFlags, destRaidFlag, auraType, spellid, stackCount
	end
else
	function GetCombatEventResults(...)
		local timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid = ...		-- WoW 4.1
		local auraType, stackCount = select(13, ...)
		return timestamp, combatevent, sourceGUID, destGUID, destName, destFlags, destFlags, auraType, spellid, stackCount
	end
end

local function CombatEventHandler(frame, event, ...)	
	-- General Events, Passthrough
	if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then 
		if GeneralEvents[event] then GeneralEvents[event](...) end 
		return
	end
	
	-- Combat Log Unfiltered
	local timestamp, combatevent, sourceGUID, destGUID, destName, destFlags, destRaidFlag, auraType, spellid, stackCount = GetCombatEventResults(...)
	
	-- Evaluate only for enemy units, for now
	if (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0) then							-- FILTER: ENEMY UNIT

		local CombatLogUpdateFunction = CombatLogEvents[combatevent]
		-- Evaluate only for certain combat log events
		if CombatLogUpdateFunction then 
			-- Evaluate only for debuffs
			if auraType == "DEBUFF" then 															-- FILTER: DEBUFF
			
				
				-- Update Auras via API/UnitID Search
				if not UpdateAuraByLookup(destGUID) then
					-- Update Auras via Combat Log		
					CombatLogUpdateFunction(timestamp, sourceGUID, destGUID, destName, spellid, stackCount)
				end
				-- To Do: Need to write something to detect when a change was made to the destID
				-- Return values on functions?
				
				local name, raidicon
				-- Cache Unit Name for alternative lookup strategy
				if bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 then 
					local rawName = strsplit("-", destName)			-- Strip server name from players
					ByName[rawName] = destGUID
					name = rawName
				end
				-- Cache Raid Icon Data for alternative lookup strategy
				for iconname, bitmask in pairs(RaidIconBit) do
					if bit.band(destRaidFlag, bitmask) > 0  then
						ByRaidIcon[iconname] = destGUID
						raidicon = iconname
						break
					end
				end
				
				CallForWidgetUpdate(destGUID, raidicon, name)
			end
		end
	end
end

-------------------------------------------------------------
-- Widget Object Functions
-------------------------------------------------------------
local function DefaultFilterFunction(debuff, unit) 
	if (debuff.duration < auraDurationFilter) then
		return true
	end
end

local function UpdateWidgetTime(frame, expiration)
	local timeleft = ceil(expiration-GetTime())
	if timeleft > 60 then 
		frame.TimeLeft:SetText(ceil(timeleft/60).."m")
	else
		frame.TimeLeft:SetText(ceil(timeleft))
	end
end


local function UpdateIcon(frame, texture, expiration, stacks, highlight)
	if frame and texture and expiration then
		-- Icon
		frame.Icon:SetTexture(texture)
		
		-- Stacks
		if stacks > 1 then frame.Stacks:SetText(stacks)
		else frame.Stacks:SetText("") end
		
		-- Expiration
		UpdateWidgetTime(frame, expiration)
		frame:Show()
		PolledHideIn(frame, expiration)
		
		--[[
		-- Border Type
		if highlight then frame.Border:SetTexture(AuraHighlightArt)
		else frame.Border:SetTexture(AuraBorderArt) end
		--]]
	else 
		PolledHideIn(frame, 0)
	end
end

local AuraSlotspellid = {} 	-- auraSlot[slot] = spellid
local AuraSlotPriority = {} 	-- auraSlot[slot] = priority
local CurrentDebuff = {}

local function UpdateIconGrid(frame, guid)

		local AuraIconFrames = frame.AuraIconFrames
		local AurasOnUnit = GetAuraList(guid)
		local AuraSlotIndex = 1
		local instanceid
		

		-- Set Auras to Available Slots
		if AurasOnUnit then
			frame:Show()
			for instanceid in pairs(AurasOnUnit) do
				local spellid, expiration, stacks, caster, duration, texture = GetAuraInstance(guid, instanceid)
				if tonumber(spellid) then
					-- Gather Debuff Information
					wipe(CurrentDebuff)
					CurrentDebuff.name = GetSpellInfo(tonumber(spellid))
					CurrentDebuff.spellid = spellid
					CurrentDebuff.stacks = stacks
					CurrentDebuff.duration = duration
					CurrentDebuff.caster = caster
					
					-- Filter Function
					local showDebuff, showHighlight = frame.Filter(CurrentDebuff)
					
					if showDebuff and expiration > GetTime() then
						UpdateIcon(AuraIconFrames[AuraSlotIndex], texture, expiration, stacks, showHighlight) 
						AuraSlotIndex = AuraSlotIndex + 1	
						-- ADD: Set Debuff Information to Icon
						
						if AuraSlotIndex > 8 then break end
					end
				end
			end
		end
		
		-- Clear Extra Slots
		for AuraSlotIndex = AuraSlotIndex, 8 do UpdateIcon(AuraIconFrames[AuraSlotIndex]) end
end

function UpdateWidget(frame)
		-- Check for ID
		local unit = frame.unit
		local guid = unit.guid
		
		if not guid then
			-- Attempt to ID widget via Name or Raid Icon
			if unit.type == "PLAYER" then guid = ByName[unit.name]
			elseif unit.isMarked then guid = ByRaidIcon[unit.raidIcon] end
			
			if guid then 
				unit.guid = guid	-- Feed data back into unit table		-- Testing
			else
				frame:Hide()
				return
			end
		end
		
		UpdateIconGrid(frame, guid)
		TidyPlates:RequestDelegateUpdate()		-- Delegate Update, For Debuff Widget-Controlled Scale and Opacity Functions
end

local function UpdateWidgetTarget(frame)
	UpdateIconGrid(frame, UnitGUID("target"))
end


-- Context Update (mouseover, target change)
local function UpdateWidgetContext(frame, unit)
	local guid = unit.guid
	frame.unit = unit
	frame.guidcache = guid
	
	WidgetList[frame] = true
	if guid then WidgetGUID[guid] = frame end
	
	if unit.isTarget then UpdateAurasByUnitID("target")
	elseif unit.isMouseover then UpdateAurasByUnitID("mouseover") end
	
	local raidicon, name
	if unit.isMarked then
		raidicon = unit.raidIcon
		if guid and raidicon then ByRaidIcon[raidicon] = guid end
	end
	if unit.type == "PLAYER" and unit.reaction == "HOSTILE" then name = unit.name end
	
	CallForWidgetUpdate(guid, raidicon, name)
end

local function ClearWidgetContext(frame)
	if frame.guidcache then 
		WidgetGUID[frame.guidcache] = nil 
		frame.unit = nil
	end
	WidgetList[frame] = nil
	
end

-------------------------------------------------------------
-- Widget Frames
-------------------------------------------------------------
local AuraBorderArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\AuraFrame"				-- FINISH ART
local AuraGlowArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\AuraGlow"	
local AuraHighlightArt = "Interface\\AddOns\\TidyPlates\\widgets\\Aura\\CCBorder"			-- AuraBorderArt, AuraHighlightArt
local AuraTestArt = ""
local AuraFont = "Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf"

local function Enable()
	AuraMonitor:SetScript("OnEvent", CombatEventHandler)
	AuraMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	for event in pairs(GeneralEvents) do
		AuraMonitor:RegisterEvent(event)
	end
	--[[
	AuraMonitor:RegisterEvent("UNIT_TARGET")
	AuraMonitor:RegisterEvent("UNIT_AURA")
	AuraMonitor:RegisterEvent("PLAYER_REGEN_ENABLED")
	AuraMonitor:RegisterEvent("PLAYER_REGEN_ENABLED")
	--]]

	TidyPlatesUtility:EnableGroupWatcher()
	WatcherIsEnabled = true
	
	if not TidyPlatesData.CachedAuraDurations then
		TidyPlatesData.CachedAuraDurations = {}
	end
	
end

local function Disable() 
	AuraMonitor:SetScript("OnEvent", nil)
	AuraMonitor:UnregisterAllEvents()
	TidyPlatesUtility:DisableGroupWatcher()
	WatcherIsEnabled = false
end

-- Create an Aura Icon
local function CreateAuraIconFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(26); frame:SetHeight(14)
	-- Icon
	frame.Icon = frame:CreateTexture(nil, "BACKGROUND")
	frame.Icon:SetAllPoints(frame)
	--frame.Icon:SetTexCoord(.07, 1-.07, .23, 1-.23)  -- obj:SetTexCoord(left,right,top,bottom)
	frame.Icon:SetTexCoord(.07, 1-.07, .23, 1-.23)  -- obj:SetTexCoord(left,right,top,bottom)
	-- Border
	frame.Border = frame:CreateTexture(nil, "ARTWORK")
	frame.Border:SetWidth(32); frame.Border:SetHeight(32)
	frame.Border:SetPoint("CENTER", 1, -2)
	frame.Border:SetTexture(AuraBorderArt)
	-- Glow
	--frame.Glow = frame:CreateTexture(nil, "ARTWORK")
	--frame.Glow:SetAllPoints(frame.Border)
	--frame.Glow:SetTexture(AuraGlowArt)
	--  Time Text
	frame.TimeLeft = frame:CreateFontString(nil, "OVERLAY")
	frame.TimeLeft:SetFont(AuraFont ,9, "OUTLINE")
	frame.TimeLeft:SetShadowOffset(1, -1)
	frame.TimeLeft:SetShadowColor(0,0,0,1)
	frame.TimeLeft:SetPoint("RIGHT", 0, 8)
	frame.TimeLeft:SetWidth(26)
	frame.TimeLeft:SetHeight(16)
	frame.TimeLeft:SetJustifyH("RIGHT")
	--  Stacks
	frame.Stacks = frame:CreateFontString(nil, "OVERLAY")
	frame.Stacks:SetFont(AuraFont,10, "OUTLINE")
	frame.Stacks:SetShadowOffset(1, -1)
	frame.Stacks:SetShadowColor(0,0,0,1)
	frame.Stacks:SetPoint("RIGHT", 0, -6)
	frame.Stacks:SetWidth(26)
	frame.Stacks:SetHeight(16)
	frame.Stacks:SetJustifyH("RIGHT")
	-- Information about the currently displayed aura
	frame.AuraInfo = {	
		Name = "",
		Icon = "",
		Stacks = 0,
		Expiration = 0,
		Type = "",
	}		
	--frame.Poll = UpdateWidgetTime
	frame.Poll = parent.PollFunction
	frame:Hide()
	return frame
end

-- Create the Main Widget Body and Icon Array
local function CreateAuraWidget(parent)
	--if not WatcherIsEnabled then Enable() end
	-- Create Base frame
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(128); frame:SetHeight(32); frame:Show()
	-- Create Icon Array
	frame.PollFunction = UpdateWidgetTime
	frame.AuraIconFrames = {}
	local AuraIconFrames = frame.AuraIconFrames
	for index = 1, 8 do AuraIconFrames[index] = CreateAuraIconFrame(frame);  end
	-- Set Anchors	
	AuraIconFrames[1]:SetPoint("LEFT", frame)
	for index = 2, 3 do AuraIconFrames[index]:SetPoint("LEFT", AuraIconFrames[index-1], "RIGHT", 5, 0) end
	AuraIconFrames[4]:SetPoint("BOTTOMLEFT", AuraIconFrames[1], "TOPLEFT", 0, 8)
	for index = 5, 6 do AuraIconFrames[index]:SetPoint("LEFT", AuraIconFrames[index-1], "RIGHT", 5, 0) end
	-- Functions
	frame._Hide = frame.Hide
	frame.Hide = function() ClearWidgetContext(frame); frame:_Hide() end
	frame:SetScript("OnHide", function() for index = 1, 4 do PolledHideIn(AuraIconFrames[index], 0) end end)	
	frame.Filter = DefaultFilterFunction
	frame.UpdateContext = UpdateWidgetContext
	frame.Update = UpdateWidgetContext
	frame.UpdateTarget = UpdateWidgetTarget
	return frame
end

-----------------------------------------------------
-- External
-----------------------------------------------------
TidyPlatesWidgets.GetAuraWidgetByGUID = GetAuraWidgetByGUID
TidyPlatesWidgets.IsAuraShown = IsAuraShown

TidyPlatesWidgets.CreateAuraWidget = CreateAuraWidget
TidyPlatesWidgets.EnableAuraWatcher = Enable
TidyPlatesWidgets.DisableAuraWatcher = Disable

-----------------------------------------------------
-- Debuff Library
-----------------------------------------------------
--[[
	-- Druid
	SetSpellDuration(8921, 12)	-- Moonfire
	SetSpellDuration(1822, 9)	-- Rake
	SetSpellDuration(33876, 60)	-- Mangle

	-- Deathknight
	-- Hunter
	-- Mage
	-- Paladin
	-- Priest
	-- Rogue
	-- Shaman
	-- Warlock
	-- Warrior
--]]
function DynamicHashTableSize(entries)
  if (entries == 0) then
    return 36;
  else
    return math.pow(2, math.ceil(math.log(entries) / math.log(2))) * 40 + 36;
  end
end

local TableMemory

TableMemory = function(pTable, level)
	level = level or 1
	local sum = 0
	local entries = 0
	local indent = " "
	for s = 1, level do
		indent = indent.." "
	end
			
	for i,v in pairs(pTable) do		
		if type(v) == 'table' then 
			local mem = TableMemory(v, level+1)
			sum = sum + mem
			entries = entries + 1
		else entries = entries + 1 end
	end
	return DynamicHashTableSize(entries) + sum, entries
end

--/run TidyPlatesDebuffMemoryUsage()

function TidyPlatesDebuffMemoryUsage()
	--print("Debuff Widget Cached Auras", TableMemory(TidyPlatesData.CachedAuraDurations))
	print("Debuff Widget AuraInstances Table Memory...")
	print("         Sum:",TableMemory(AuraInstances))
end
























