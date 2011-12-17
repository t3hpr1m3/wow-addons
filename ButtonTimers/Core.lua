ABT = LibStub("AceAddon-3.0"):NewAddon("ButtonTimers", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ButtonTimers", "enUS", true)
local LBF = LibStub("LibButtonFacade", true)
local LSM = LibStub("LibSharedMedia-3.0")

-- TBD:
--
-- Submission checklist
-- comment out all Debug Print statements!
-- update toc file revision

ABT_MaxButton = 12
ABT_MaxBar = 4
ABT_Widgets = "ABTWid"
local ABT_Bars = {}
local ABT_Buttons = {}
local outer_margin = 8
ABT_TARGET = 1
ABT_FOCUS = 2
ABT_PLAYER = 3
ABT_MOUSEOVER = 4
ABT_PARTY = 5
ABT_PET = 6
ABT_VEHICLE = 7
ABT_TARGET_NAMES = { [ABT_TARGET]="target", [ABT_FOCUS]="focus", [ABT_PLAYER]="player", [ABT_PARTY]="party", [ABT_PET]="pet", [ABT_VEHICLE]="vehicle" }
ABT_AURA = 1
ABT_COOLDOWN = 2
ABT_BOTH = 4
ABT_NONE = 3
ABT_VERTICAL = 1
ABT_HORIZONTAL = 2
ABT_TOPRIGHT = 1
ABT_BOTTOMLEFT = 2
ABT_ONBUTTONS = 3
ABT_FULL = 1
ABT_FIXED = 2
local TimeSinceLastUpdate = nil
local ABT_UpdateInterval = .05
local ABT_DebuffUpdateInterval = .1
local ABT_second_spec_bar_fields = { ["enabled"] = true, ["buttonCount"] = true }
local needGetDebuffs = false
local lastDebuffUpdate = 0

--
-- This function returns a legit string no matter what you pass it.
-- It gets used in debug messages to avoid annoying lua errors.
function ABT:NS(arg1)
	if arg1 == nil then
		return "nil"
	elseif type(arg1) == "table" then
		local myval = "{"
		for i, j in pairs(arg1) do
			myval = myval.." ["..ABT:NS(i).."]="..ABT:NS(j)..","
		end
		myval = myval.."}"
		return myval
	else
		return tostring(arg1)
	end
end

function ABT:DebugTrace (arg1, enter)
	if ABT.db and ABT.db.char.showTrace == true then
		if (enter) then
			DEFAULT_CHAT_FRAME:AddMessage("ABT:"..arg1.." enter")
		else
			DEFAULT_CHAT_FRAME:AddMessage("ABT:"..arg1.." exit")
		end
	end
end

function ABT:DebugPrint (arg1)
	if ABT.db.char.showDebug == true then
		DEFAULT_CHAT_FRAME:AddMessage("ABT:"..arg1)
	end
end

-- parse a comma separated list into a table
function ABT:parseList (list)
	local _table = {}
	local idx = 1
	local value
	if list then
		for value in string.gmatch(list, "[^\n\r,]+") do
			if value then
				value = string.gsub(value, "^%s*(.-)%s*$", "%1") -- strip leading/trailing whitespace
				tinsert(_table, value)
			end
		end
	end
	return _table
end
function ABT:getKey(info)
	local key
	if #info == 3 then
		key = info[#info-2]..info[#info-1]..info[#info]
	elseif #info == 2 then
		key = info[#info-1]..info[#info]
	else
		key = info[#info]
	end
	return key
end

function ABT:GetValue (barIdx, buttonIdx, field)
	local key = nil
	local secondTalent = nil
	if buttonIdx and barIdx and field then
		key = "bar"..barIdx.."button"..buttonIdx..field
		if GetActiveTalentGroup() == 2 then -- if we're using an alt spec
			secondTalent = true
		end
	elseif barIdx and field then
		if ABT_second_spec_bar_fields[field] and GetActiveTalentGroup() == 2 then
			secondTalent = true
		end
		key = "bar"..barIdx..field
	elseif field then
		key = field
	end
	if key then
		if secondTalent and ABT.db.char[key.."2"] ~= nil then
			return ABT.db.char[key.."2"] -- alt spec setting exists
		end
		return ABT.db.char[key] -- primary spec setting
	end
end

function ABT:SetValue (barIdx, buttonIdx, field, value)
	local key = nil
	local secondTalent = nil

	if buttonIdx and barIdx and field then
		if GetActiveTalentGroup() == 2 then -- if we're using an alt spec
			secondTalent = true
--			ABT:DebugPrint ("secondary spec activated "..secondTalent)
		end
		key = "bar"..barIdx.."button"..buttonIdx..field
	elseif barIdx and field then
		if ABT_second_spec_bar_fields[field] and GetActiveTalentGroup() == 2 then
			secondTalent = true
		end
		key = "bar"..barIdx..field
	elseif field then
		key = field
	end
	if key then
		if secondTalent then
			ABT.db.char[key.."2"] = value
		else -- primary talents
			-- if there was no secondary talent setting before, set it now to the old value
			if ABT.db.char[key.."2"] == nil then
				ABT.db.char[key.."2"] = ABT.db.char[key]
			end
			ABT.db.char[key] = value
		end
	end
end

function ABT:GetButtonLabel(info)
	local barIdx, buttonIdx = ABT:getIndex (info)
	return ABT:GetButtonName (barIdx, buttonIdx)
end

function ABT:IsButtonHidden(barIdx, buttonIdx)
	if barIdx and buttonIdx then
		-- return ABT:GetValue (barIdx, nil, "enabled") and buttonIdx > ABT:GetValue (barIdx, nil, "buttonCount")
		return buttonIdx > ABT:GetValue (barIdx, nil, "buttonCount")
	else
		return false
	end
end

function ABT:GetButtonHidden(info)
	ABT:IsButtonHidden(ABT:getIndex(info))
end

function ABT:getIndex(info)
	local buttonIdx = nil
	local barIdx = nil
	local field = nil

	for i = 1, #info do
		local a = string.match(info[i], "button(.+)")
		if a and tonumber(a) then
			buttonIdx = tonumber(a)
		else
			a = string.match(info[i], "bar(.+)")
			if a and tonumber(a) then
				barIdx = tonumber(a)
			else
				field = info[i]
			end
		end
	end
	return barIdx, buttonIdx, field
end

function ABT:getFunc(info)
	local barIdx, buttonIdx, field = ABT:getIndex(info)
	return ABT:GetValue (barIdx, buttonIdx, field)
end

function ABT:setFunc(info, value)
	local barIdx, buttonIdx, field = ABT:getIndex(info)
	ABT:SetValue (barIdx, buttonIdx, field, value)

	local barIdx, buttonIdx = ABT:getIndex(info)
	if barIdx ~= nil then   -- button option or bar option
		ABT:SetBar (barIdx)
	else                                             -- general option
		for barIdx = 1, ABT_MaxBar do
			ABT:SetBar (barIdx)
		end
	end
	ABT:MarkNeedDebuffs()
end

function ABT:isNotAura(info)
	local barIdx, buttonIdx = ABT:getIndex(info) 
	local type = ABT:GetValue (barIdx, buttonIdx, "timerType")
	return (type ~= ABT_AURA and type ~= ABT_BOTH)
end

function ABT:isNotCooldown(info)
	local barIdx, buttonIdx = ABT:getIndex(info) 
	local type = ABT:GetValue (barIdx, buttonIdx, "timerType")
	return (type ~= ABT_COOLDOWN and type ~= ABT_BOTH)
end

local buttonOptions = {
	type = "group",
	name = function(info) return ABT:GetButtonLabel(info) end,
	hidden = function(info) return ABT:IsButtonHidden(ABT:getIndex(info)) end,
	order = function(info) local barIndex, buttonIndex = ABT:getIndex(info) return buttonIndex end,
	desc = "Options for each button",
	childGroups = "tree",
	inline = false,
	args = {
		target = {
			order = 2,
			type = "select",
			name = L["Target"],
			desc = L["Target to monitor for Auras."],
			values = { [ABT_TARGET]=L["Target"], [ABT_FOCUS]=L["Focus"], [ABT_PLAYER]=L["Player"], [ABT_PARTY]=L["Party/Raid Member"], [ABT_PET]=L["Pet"], [ABT_VEHICLE]=L["Vehicle"] },
			style = "dropdown",
			set = "setFunc",
			get = "getFunc",
		},

		playerTarget = {
			order = 5,
			type = "select",
			hidden = function (info)  local barIdx, buttonIdx = ABT:getIndex(info) return ABT:GetValue (barIdx, buttonIdx, "target") ~= ABT_PARTY  end,
			name = L["Party/Raid Member"],
			desc = L["The party / raid member to target"],
			values = function () return ABT:GetPartyList() end,
			style = "dropdown",
			set = "setFunc",
			get = "getFunc",
		},
		useAsSpellTarget = {
			order = 6,
			type = "toggle",
			name = L["Use as spell target"],
			desc = L["If set, target will be the spell target as well as the target to monitor for the selected aura."],
			set = "setFunc",
			get = "getFunc",
		},
		timerType = {
			type = "select",
			order = 10,
			name = L["Type"],
			values = { [ABT_AURA]=L["Aura"], [ABT_COOLDOWN]=L["Cooldown"], [ABT_BOTH]=L["Both"], [ABT_NONE]=L["None"]},
			style = "dropdown",
			set = "setFunc",
			get = "getFunc",
		},
		barType = {
			type = "select",
			order = 20,
			name = L["Timer Type"],
			desc = L["Choose full time to see the full length of the timer, choose fixed time to see a set maximum time."],
			values = { [ABT_FULL]=L["Full time"], [ABT_FIXED]=L["Fixed time"] },
			style = "dropdown",
			set = "setFunc",
			get = "getFunc",
		},
		barTime = {
			order = 30,
			type = "range",
			hidden = function (info) local barIdx, buttonIdx = ABT:getIndex(info) return ABT:GetValue (barIdx, buttonIdx, "barType") ~= ABT_FIXED  end,
			name = L["Bar Time"],
			desc = L["Max time displayed on bar"],
			min = 1,
			max = 100,
			step = 1,
			bigStep = 1,
			set = "setFunc",
			get = "getFunc",
		},
		showOthers = {
			order = 40,
			type = "toggle",
			hidden = "isNotAura",
			name = L["Show others spells"],
			desc = L["Show this spell on the target even if someone else cast it."],
			set = "setFunc",
			get = "getFunc",
		},
		showTickPrediction = {
			order = 45,
			type = "toggle",
			hidden = "isNotAura",
			name = L["Show tick prediction"],
			desc = L["Show estimate of next dot tick time."],
			set = "setFunc",
			get = "getFunc",
		},
		auras = {
			order = 50,
			hidden = "isNotAura",
			type = "input",
			name = L["Other Auras"],
			desc = L["Add any additional aura names or spellIds as a comma separated list."],
			multiline = true,
			set = "setFunc",
			get = "getFunc",
		},
		showAuraIcon = {
			order = 55,
			hidden = "isNotAura",
			type = "toggle",
			name = L["Show Aura Icon"],
			desc = L["Display the aura's icon on the button in place of the spell icon."],
			set = "setFunc",
			get = "getFunc",
		},
		spell = {
			order = 60,
			hidden = "isNotCooldown",
			type = "input",
			name = L["Cooldown Spell"],
			desc = L["If you would like to see the cooldown for a spell other than the one on the button, enter the name or spellId here."],
			set = "setFunc",
			get = "getFunc",
		},
		timerColor = {
			order = 70,
            name = L["Bar Color"],
            desc = L["Bar color for timers"],
            type = "color",
			hasAlpha = true,
            set = function (info, r, g, b, a) return ABT:setFunc (info, {r, g, b, a}) end,
            get = function (info) return unpack(ABT:getFunc(info)) end
        },
		textColor = {
			order = 70,
            name = L["Text Color"],
            desc = L["Text color for timers"],
            type = "color",
			hasAlpha = true,
            set = function (info, r, g, b, a) return ABT:setFunc (info, {r, g, b, a}) end,
            get = function (info) return unpack(ABT:getFunc(info)) end
        },
		timerWarnColor = {
			order = 70,
 			hidden = "isNotAura",
			name = L["Warning Bar Color"],
            desc = L["Bar color for timers when remaining time < cast time"],
            type = "color",
			hasAlpha = true,
            set = function (info, r, g, b, a) return ABT:setFunc (info, {r, g, b, a}) end,
            get = function (info) return unpack(ABT:getFunc(info)) end
        },
		colorChange = {
			order = 65,
			hidden = "isNotAura",
			type = "toggle",
			name = L["Warn < cast time."],
			desc = L["Change the bar color when timer < cast time."],
			set = "setFunc",
			get = "getFunc",
		},
		timerAdjust = {
			order = 90,
			type = "input",
			name = L["Adjust Timer"],
			desc = L["Number of seconds to add to timer (can be negative)."],
			set = "setFunc",
			get = "getFunc",
		}
	}
}

function ABT:GetBarDesc(info)
	local offset = ABT:getFunc(info)
	local barIdx = math.modf(offset / 12) + 1
	local buttonIdx = (offset % 12) + 1
--  ABT:DebugPrint( "First button of bar is: Action bar: "..ABT:NS(barIdx)..", button: "..ABT:NS(buttonIdx))
	return "Bar: "..ABT:NS(barIdx)..", Button: "..ABT:NS(buttonIdx)
end

local barOptions = {
	type = "group",
	name = function(info) return info[#info] end,
	order = function(info) local barIndex, buttonIndex = ABT:getIndex(info) return barIdx end,
--	handler = ABT,
	desc = "Options for the bar",
	childGroups = "tree",
	inline = false,
	args = {
		enabled = {
			order = 10,
			type = "toggle",
			name = L["Bar Enabled"],
			desc = L["Enable this bar"],
			set = "setFunc",
			get = "getFunc",
		},
		inCombat = {
			order = 15,
			type = "toggle",
			name = L["Hide out of combat"],
			desc = L["Show this bar only when in combat"],
			set = "setFunc",
			get = "getFunc",
		},
		hideTooltips={
			order = 18,
			name= L["Hide Tooltips"],
			desc= L["Hide tooltips on buttons"],
			type= "toggle",
			set = "setFunc",
			get = "getFunc",
		},
		locked = {
			order = 19,
			type = "toggle",
			name = L["Bar Locked"],
			desc = L["Lock bar in place"],
			set = "setFunc",
			get = "getFunc",
		},
		buttonCount = {
			order = 20,
			type = "range",
			name = L["Button Count"],
			desc = L["Number of Buttons on bar"],
			min = 1,
			max = 12,
			step = 1,
			bigStep = 1,
			set = "setFunc",
			get = "getFunc",
		},
		actionDesc = {
			order = 29,
			type = "description",
			name = L["First button on bar is action slot:"],
		},
		actionOffset = {
			order = 30,
			type = "range",
			name = function(info) return ABT:GetBarDesc(info) end,
			desc = L["Move this slider to change which action slots are shown on the bar."],
			min = 0,
			max = 119,
			step = 1,
			bigStep = 1,
			set = "setFunc",
			get = "getFunc",
		},	
		orientation = {
			order = 40,
			type = "select",
			name = L["Orientation"],
			values = { [ABT_VERTICAL]=L["Vertical"], [ABT_HORIZONTAL]=L["Horizontal"] },
			style = "dropdown",
			set = "setFunc",
			get = "getFunc",
		},
		location = {
			order = 45,
			type = "select",
			name = L["Timer Location"],
			values = { [1]=L["Right/Top"], [2]=L["Left/Bottom"], [3]=L["Timers on Buttons"] },
			style = "dropdown",
			set = "setFunc",
			get = "getFunc",
		},
		spacing = {
			order = 60,
			type = "range",
			name = L["Button Spacing"],
			desc = L["The space between the buttons"],
			min = 0,
			min = 0,
			max = 16,
			step = 1,
			bigStep = 1,
			set = "setFunc",
			get = "getFunc",
		},
		scale = {
			order = 70,
			type = "range",
			name = L["Bar Scale"],
			desc = L["Allows you to scale the bar size"],
			min = .1,
			max = 2,
			step = .01,
			bigStep = .01,
			set = "setFunc",
			get = "getFunc",
		},
		length = {
			order = 80,
			type = "range",
			name = L["Bar Length"],
			desc = L["Length of bar in pixels"],
			min = 1,
			max = 600,
			step = 1,
			bigStep = 1,
			set = "setFunc",
			get = "getFunc",
		},
		font = {
			order = 90,
			type = "select",
			dialogControl = "LSM30_Font", --Select your widget here
			name = L["Bar Font"],
			desc = L["Fonts to use for this bar"],
			values = AceGUIWidgetLSMlists.font, -- this table needs to be a list of keys found in the sharedmedia type you want
			get = "getFunc",
			set = "setFunc",
		},
				
		texture = {
			order = 100,
			type = "select",
			dialogControl = "LSM30_Statusbar", --Select your widget here
			name = L["Statusbar texture"],
			desc = L["Texture of the status bar"],
			values = AceGUIWidgetLSMlists.statusbar, -- this table needs to be a list of keys found in the sharedmedia type you want
			get = "getFunc",
			set = "setFunc",		
		},
		button1 = buttonOptions,
		button2 = buttonOptions,
		button3 = buttonOptions,
		button4 = buttonOptions,
		button5 = buttonOptions,
		button6 = buttonOptions,
		button7 = buttonOptions,
		button8 = buttonOptions,
		button9 = buttonOptions,
		button10 = buttonOptions,
		button11 = buttonOptions,
		button12 = buttonOptions,
	}
}

local options = {
    name = "ButtonTimers",
    handler = ABT,
    type = "group",
	childGroups = "tree",
    args = {
		enable={
			order = 10,
			name= L["Enable"],
			desc= L["Enables / disables the addon"],
			type= "toggle",
			set = "setFunc",
			get = "getFunc",
		},
	    showDebug = {
			order = 100,
			hidden = true,
            name = L["ShowDebug"],
            desc = L["Show debug messages"],
            type = "toggle",
            set = "setFunc",
            get = "getFunc",
        },
	    showTrace = {
			order = 110,
			hidden = true,
            name = L["ShowTrace"],
            desc = L["Show trace messages"],
            type = "toggle",
            set = "setFunc",
            get = "getFunc",
        },
		showBackground = {
			order = 120,
			hidden = true,
            name = L["ShowBackground"],
            desc = L["Show background bar"],
            type = "toggle",
            set = "setFunc",
            get = "getFunc",
        },
		bar1 = barOptions,
		bar2 = barOptions,
		bar3 = barOptions,
		bar4 = barOptions,
    },
}

function ABT:InitDefaults()
	local defaults = {
		char = {}
	}
	defaults.char.enable = true
	defaults.char.showDebug = false
	defaults.char.showTrace = false
	defaults.char.showBackground = false
	for bar = 1, ABT_MaxBar do
		defaults.char["bar"..bar.."enabled"] = true
		defaults.char["bar"..bar.."locked"] = false
		defaults.char["bar"..bar.."orientation"] = ABT_VERTICAL
		defaults.char["bar"..bar.."location"] = ABT_TOPRIGHT
		defaults.char["bar"..bar.."scale"] = 1
		defaults.char["bar"..bar.."length"] = 300
		defaults.char["bar"..bar.."spacing"] = 8
		defaults.char["bar"..bar.."buttonCount"] = 12
		defaults.char["bar"..bar.."actionOffset"] = (10-bar) * 12 -- default bars 10, 9, 8, 7
		defaults.char["bar"..bar.."auraColor"] = { 0, 1, 1, .5 }
		defaults.char["bar"..bar.."cooldownColor"] = { 0, 1, 0, .5 }
		defaults.char["bar"..bar.."hideTooltips"] = false
		defaults.char["bar"..bar.."enabled2"] = true
		defaults.char["bar"..bar.."buttonCount2"] = 12
		for button = 1, ABT_MaxButton do
			defaults.char["bar"..bar.."button"..button.."target"] = ABT_TARGET
			defaults.char["bar"..bar.."button"..button.."timerType"] = ABT_AURA
			defaults.char["bar"..bar.."button"..button.."useAsSpellTarget"] = true
			defaults.char["bar"..bar.."button"..button.."barType"] = ABT_FULL
			defaults.char["bar"..bar.."button"..button.."barTime"] = 20
			defaults.char["bar"..bar.."button"..button.."showOthers"] = false
			defaults.char["bar"..bar.."button"..button.."showTickPrediction"] = true
			defaults.char["bar"..bar.."button"..button.."auras"] = nil
			defaults.char["bar"..bar.."button"..button.."showAuraIcon"] = false
			defaults.char["bar"..bar.."button"..button.."spell"] = nil
			defaults.char["bar"..bar.."button"..button.."colorChange"] = nil
			defaults.char["bar"..bar.."button"..button.."timerColor"] = { 0, 1, 1, .5 }
			defaults.char["bar"..bar.."button"..button.."textColor"] = { 1, 1, 0, 1 }
			defaults.char["bar"..bar.."button"..button.."timerWarnColor"] = { 1, 0, 0, .5 }
			defaults.char["bar"..bar.."button"..button.."timerAdjust"] = "0"
			-- alt spec inits
			defaults.char["bar"..bar.."button"..button.."target2"] = ABT_TARGET
			defaults.char["bar"..bar.."button"..button.."timerType2"] = ABT_AURA
			defaults.char["bar"..bar.."button"..button.."barType2"] = ABT_FULL
			defaults.char["bar"..bar.."button"..button.."barTime2"] = 20
			defaults.char["bar"..bar.."button"..button.."showOthers2"] = false
			defaults.char["bar"..bar.."button"..button.."showTickPrediction2"] = true
			defaults.char["bar"..bar.."button"..button.."auras2"] = nil
			defaults.char["bar"..bar.."button"..button.."spell2"] = nil
			defaults.char["bar"..bar.."button"..button.."colorChange2"] = nil
			defaults.char["bar"..bar.."button"..button.."textColor2"] = { 1, 1, 0, 1 }
			defaults.char["bar"..bar.."button"..button.."timerColor2"] = { 0, 1, 1, .5 }
			defaults.char["bar"..bar.."button"..button.."timerWarnColor2"] = { 1, 0, 0, .5 }
			defaults.char["bar"..bar.."button"..button.."timerAdjust2"] = "0"
		end
	end
	return defaults
end

function ABT:OnInitialize()
  -- Code that you want to run when the addon is first loaded goes here.
	ABT:DebugTrace ("OnInitialize", true)
	ABT:RegisterChatCommand("buttontimers", "SlashProcessorFunc")
	-- bt overwrites bartender, doh
	ABT:RegisterChatCommand("abt", "SlashProcessorFunc")
    LibStub("AceConfig-3.0"):RegisterOptionsTable("ButtonTimers", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("ButtonTimers", "ButtonTimers")
    self.db = LibStub("AceDB-3.0"):New("ButtonTimersDB", ABT:InitDefaults(), "Default")
	ABT:MakeWidgets()
	ABT:DebugTrace ("OnInitialize")

	-- libSharedMedia
	LSM.RegisterCallback(self, "LibSharedMedia_Registered", "UpdateUsedMedia")

	-- Binding Variables
	for bar=1,ABT_MaxBar do
		setglobal("BINDING_HEADER_ButtonTimersBar"..bar, "ButtonTimers Bar "..bar);
		for button=1, ABT_MaxButton do
			local buttonName = ABT_Widgets.."bar"..bar.."button"..button.."Button"
			setglobal("BINDING_NAME_CLICK "..buttonName..":LeftButton", "Button "..button);
		end
	end
end

--
-- libSharedMedia Callback
-- This function will check newly registered media to see if
-- it's in use in the user's configuration. It's mainly here 
-- in case this add-on gets loaded before SharedMedia or other
-- media add-in mods
function ABT:UpdateUsedMedia (event, mediatype, key)
	if mediatype == "statusbar" then
		-- see if we are using this statusbar texture anywhere
		for barIdx = 1, ABT_MaxBar do
			-- if we're using it, update
			if key == ABT:GetValue (barIdx, nil, "texture") then
--				ABT:DebugPrint ("Found newly registered statusbar "..ABT:NS(key))
				ABT:SetBar (barIdx)
			end
		end
	end
	if mediatype == "font" then
		-- see if we are using font anywhere
		for barIdx = 1, ABT_MaxBar do
			-- if we're using it, update
			if key == ABT:GetValue (barIdx, nil, "font") then
--				ABT:DebugPrint ("Found newly registered font "..ABT:NS(key))
				ABT:SetBar (barIdx)
			end
		end
	end
end

-- Button Facade Callback
function ABT:OnSkin(skin, gloss, backdrop, group, button, colors)
	if group then
--		ABT:DebugPrint ("OnSkin group "..ABT:NS(group).." skin="..ABT:NS(skin))
		ABT.db.char["buttonFacade"..group] = {skin, gloss, backdrop, colors}
	end
end

function ABT:OnEnable()
	ABT:DebugTrace ("OnEnable", true)
    -- Called when the addon is enabled
	self:RegisterEvent ("UNIT_AURA", "MarkNeedDebuffs")
	self:RegisterEvent ("UNIT_AURASTATE", "MarkNeedDebuffs")
	self:RegisterEvent ("PLAYER_TARGET_CHANGED", "MarkNeedDebuffs")
	self:RegisterEvent ("PLAYER_FOCUS_CHANGED", "MarkNeedDebuffs")
	self:RegisterEvent ("PLAYER_ENTERING_WORLD", "SetAllBars")
	self:RegisterEvent ("PLAYER_TALENT_UPDATE", "SetAllBars")
	self:RegisterEvent ("ACTIONBAR_UPDATE_COOLDOWN", "GetCooldowns")
	self:RegisterEvent ("ACTIONBAR_UPDATE_USABLE", "GetCooldowns")
	self:RegisterEvent ("PARTY_MEMBERS_CHANGED", "UpdatePlayerTargets")
	self:RegisterEvent ("RAID_ROSTER_UPDATE", "UpdatePlayerTargets")
	self:RegisterEvent ("ACTIONBAR_SLOT_CHANGED", function (event, arg1) 
			ActionButton_OnEvent(event) ABT:ApplyDefault (arg1) ABT:ButtonUpdate()
			end)
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnEnterCombat")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnLeaveCombat")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "ProcessCombatLogEvent")
	ABT:RegisterBF()
	ABT:ButtonUpdate()
	ABT:DebugTrace ("OnEnable")
end

function ABT:OnEnterCombat ()
	if ABT:GetValue (nil, nil, "enable") then
		for barIdx = 1, ABT_MaxBar do
			local barEnabled = ABT:GetValue (barIdx, nil, "enabled")
			local inCombat = ABT:GetValue (barIdx, nil, "inCombat")
			if barEnabled and inCombat then
				ABT_Bars[barIdx]:Show()
			end
		end
	end
end

function ABT:OnLeaveCombat ()
	if ABT:GetValue (nil, nil, "enable") then
		for barIdx = 1, ABT_MaxBar do
			local barEnabled = ABT:GetValue (barIdx, nil, "enabled")
			local inCombat = ABT:GetValue (barIdx, nil, "inCombat")
			if barEnabled and inCombat then
				ABT_Bars[barIdx]:Hide()
			end
			if ABT_Bars[barIdx].needsRefresh then
				ABT:SetBar(barIdx)
			end
		end
	end
end

function ABT:ApplyDefault (slot)
--    ABT:DebugPrint ("ApplyDefault called on slot "..ABT:NS(slot))
    if slot == nil then
        return
    end
    -- find buttons using this slot
    local barIdx = 1
    local buttonIdx = 0
    local overall_defaults = ABT_Defaults["overall"]
    repeat
        barIdx, buttonIdx = ABT:GetNextButton(barIdx, buttonIdx)
        if barIdx and buttonIdx then
            local button = ABT_Buttons[barIdx][buttonIdx]
            if slot == button.button:GetAttribute("action") then
                -- found one
                ABT:DebugPrint ("Slot "..slot.." used on bar="..barIdx.." button="..buttonIdx)
                local actionType, actionId, actionSubType = GetActionInfo(slot)
                -- only apply defaults if it actually changed
                if (actionType ~= button.actionType or actionId ~= button.actionId or actionSubType ~= button.actionSubType) then
                    button.actionType = actionType
                    button.actionId = actionId
                    button.actionSubType = actionSubType
                    if actionType == "spell" or actionType == "macro" then
                        local spellName = ABT:GetButtonName(barIdx, buttonIdx)
                        ABT:DebugPrint ("spellName="..ABT:NS(spellName).." id="..ABT:NS(actionId))
                        local options = ABT_Defaults[actionId]
                        if options == nil then
                            options = ABT_Defaults[spellName]
                        end
                        if options ~= nil then
                            -- reset the fields to default values
                            if overall_defaults ~= nil then
                                for f, v in pairs(overall_defaults) do
                                    ABT:SetValue (barIdx, buttonIdx, f, v)
                                end
                            end
                            -- apply the specific default for this spell
                            ABT:DebugPrint (ABT:NS(options))
                            for f, v in pairs(options) do
                                ABT:DebugPrint ("Applying default field="..ABT:NS(f).." value="..ABT:NS(v))
                                ABT:SetValue (barIdx, buttonIdx, f, v)
                            end
                        end
                    end
                end
            end
        end
    until buttonIdx == nil
end
function ABT:ButtonUpdate ()
	ABT:GetCooldowns()
	ABT:MarkNeedDebuffs()
end

function ABT:OnDisable()
	ABT:DebugTrace ("OnDisable", true)
    -- Called when the addon is disabled
	self:UnregisterEvent ("UNIT_AURA")
	self:UnregisterEvent ("UNIT_AURASTATE")
	self:UnregisterEvent ("PLAYER_TARGET_CHANGED")
	self:UnregisterEvent ("PLAYER_FOCUS_CHANGED")
	self:UnregisterEvent ("PLAYER_ENTERING_WORLD")
	self:UnregisterEvent ("PLAYER_TALENT_UPDATE")
	self:UnregisterEvent ("ACTIONBAR_UPDATE_COOLDOWN")
	self:UnregisterEvent ("ACTIONBAR_UPDATE_USABLE")
	self:UnregisterEvent ("PARTY_MEMBERS_CHANGED")
	self:UnregisterEvent ("RAID_ROSTER_UPDATE")
	self:UnregisterEvent ("ACTIONBAR_SLOT_CHANGED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	ABT:DebugTrace ("OnDisable")
end

function ABT:SlashProcessorFunc(input)
	ABT:DebugTrace ("SlashProcessorFunc", true)
  -- Process the slash command ('input' contains whatever follows the slash command)
--	ABT:DebugPrint ("Received command "..input)
	if (input == "reset") then
		for barIdx = 0, ABT_MaxButton do
			local bar = ABT_Bars[barIdx]
			if bar then
				bar:ClearAllPoints()
				bar:SetPoint("CENTER")
			end
		end
	elseif (input == "toggleDebug") then
		if ABT.db.char.showDebug then
			ABT:DebugPrint ("turning debug messages off")
			ABT.db.char.showDebug = false
		else
			ABT.db.char.showDebug = true
			ABT:DebugPrint ("turning debug messages on")
		end
	elseif (input == "toggleTrace") then
		if ABT.db.char.showTrace then
--			ABT:DebugPrint ("turning trace messages off")
			ABT.db.char.showTrace = false
		else
			ABT.db.char.showTrace = true
--			ABT:DebugPrint ("turning trace messages on")
		end
	else
		InterfaceOptionsFrame_OpenToCategory("ButtonTimers")
	end
	ABT:DebugTrace ("SlashProcessorFunc")
end

-- update the bars
function ABT:OnUpdate (self, elapsed)
	if self:IsShown() and ABT:GetValue(nil, nil, "enable") then
		if self.TimeSinceLastUpdate == nil then 
			self.TimeSinceLastUpdate = elapsed
		end
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	
		if (self.TimeSinceLastUpdate > ABT_UpdateInterval) then
			local currentTime = GetTime()
			self.TimeSinceLastUpdate = 0;
			-- use a flag and implement here so this can only go off a limited frequency
			if (needGetDebuffs and ((currentTime - lastDebuffUpdate) > ABT_DebuffUpdateInterval)) then
				ABT:GetDebuffs()
				needGetDebuffs = false
				lastDebuffUpdate = currentTime
			end
			if self.countdown.expirationTime and self.countdown.expirationTime > currentTime then
				local remaining = self.countdown.expirationTime - currentTime;
				if remaining > 10 then
						self.countdown:SetFormattedText(SecondsToTimeAbbrev(remaining))
				else
						self.countdown:SetFormattedText("%.1f", remaining)
				end
				if self.castTime and self.tex.warnColor and remaining * 1000 < self.castTime then
					self.tex:SetVertexColor (unpack(self.tex.warnColor))
					if not self.flash:IsShown() then
						self.flash:Show()
					end
				elseif self.flash:IsShown() then
					self.flash:Hide()
				end
				ABT:SetStatusBarRemaining (self, remaining)
				-- fade in next tick predictor
				local fade = self.nextTick.fade
				if fade and fade < 10 then
					fade = fade + 1
					self.nextTick:SetTexture(1, 1, 1, fade * .099) -- should be .1, but floating point error seems to mess it up
					self.nextTick.fade = fade
				end
			else
				self.countdown.expirationTime = nil
				self.countdown:SetText(nil)
				self.nextTick:Hide()
				self.spellName:SetText(nil)
				self.status:Hide()
				self.effect = nil
				self.lastTick = nil
			end
			if self.timer.expirationTime and self.timer.expirationTime > currentTime then
				local remaining = self.timer.expirationTime - currentTime;
				if remaining > 10 then
					self.timer:SetFormattedText(SecondsToTimeAbbrev(remaining))
				else
					self.timer:SetFormattedText("%.1f", remaining)
				end
			else
				self.timer.expirationTime = nil
				self.timer:SetText(nil)
			end
			if self.timer.expirationTime == nil and self.countdown.expirationTime == nil then
				self.flash:Hide()
				self.texture = nil
			end
			if self.defaultTexture then
				self.icon:SetTexture (self.texture or self.defaultTexture)
			end
		end
	end
end

function ABT:GetButtonName (barIdx, buttonIdx)
	local buttonName
	local button = ABT_Buttons[barIdx][buttonIdx]
	local actionSlot = button.button:GetAttribute("action")	
	local actiontype, id, subType
	if actionSlot then
		actiontype, id, subType = GetActionInfo(actionSlot)
--		ABT:DebugPrint ("type="..ABT:NS(actiontype).." id="..ABT:NS(id).."subType="..ABT:NS(subType))
	end
	if actiontype == "spell" then
		local spellName = nil
		if subType == "pet" and actionSlot > 120 then
			spellName = GetPetActionInfo (actionSlot-120)
		elseif id > 0 then
			spellName = GetSpellInfo (id)
		end
--		ABT:DebugPrint ("spellName = "..ABT:NS(spellName))
		if spellName then
			buttonName = spellName
		end
	elseif actiontype == "macro" then
		buttonName = GetActionText(actionSlot)
	elseif actiontype == "item" then
		buttonName = GetItemInfo(id)
	end
	if buttonName == nil then
		buttonName = "bar"..barIdx.."button"..buttonIdx
	end
	return buttonName
end

--
-- Help, does this really need to do all buttons for each call?
-- couldn't we just update cooldowns on buttons that gave the action?
function ABT:GetCooldowns (self, arg1)
	ABT:DebugTrace ("GetCooldowns", true)
	local barIdx = 1
	local buttonIdx = 0
	repeat 
		barIdx, buttonIdx = ABT:GetNextButton(barIdx, buttonIdx)
		if barIdx and buttonIdx then
			local key = "bar"..barIdx.."button"..buttonIdx
			local timerType = ABT:GetValue (barIdx, buttonIdx, "timerType")
			local location = ABT:GetValue(barIdx, nil, "location")
			if timerType == ABT_COOLDOWN or timerType == ABT_BOTH then -- cooldown timer
				local otherSpell = ABT:GetValue (barIdx, buttonIdx, "spell")
				local otherSpellId = tonumber(otherSpell)
				local button = ABT_Buttons[barIdx][buttonIdx]
				local slot = button.button:GetAttribute ("action")
				local useTimer = (timerType == ABT_BOTH or (timerType == ABT_COOLDOWN and location == ABT_ONBUTTONS))
				local useStatusbar = (timerType == ABT_COOLDOWN and location ~= ABT_ONBUTTONS)

				local start, duration, enabled
				if otherSpellId then
					start, duration, enabled = GetSpellCooldown (otherSpellId)
				elseif otherSpell and otherSpell ~= "" then
					start, duration, enabled = GetSpellCooldown (otherSpell)
				elseif (slot) then
					start, duration, enabled = GetActionCooldown (slot)
				end
				if start and duration then
					-- we have a cooldown to track
					if start > 0 and duration > 1.5 then
						local add = tonumber(ABT:GetValue (barIdx, buttonIdx, "timerAdjust"))

						if useTimer then
							button.timer.expirationTime = start + duration + (add or 0)
							if (button.timer.expirationTime <= 0) then
								button.timer.expirationTime = nil
							end
						elseif useStatusbar then
							button.countdown.expirationTime = start + duration + (add or 0)
							if (button.countdown.expirationTime <= 0) then
								button.countdown.expirationTime = nil
							else
								if ABT:GetValue (barIdx, nil, "orientation") == ABT_VERTICAL then
									if otherSpell then
										button.spellName:SetText(otherSpell)
									end
									-- find the name of the spell, so we can put it on the timer
									spellName = ABT:GetButtonName (barIdx, buttonIdx)
									if spellName then
										button.spellName:SetText(spellName)
									end
								else
									button.spellName:SetText(nil)
								end
								local barTime
								if ABT:GetValue (barIdx, buttonIdx, "barType") == ABT_FIXED then
									barTime = ABT:GetValue (barIdx, buttonIdx, "barTime")
								else
									barTime = duration
								end
								button.tex.max = barTime
								button.status:Show()
							end
						end
					-- we have a cooldown timer running, but the cooldown is no longer
					-- active. Reset it. If it's less than the GCD, though, just let it run out.
					elseif useTimer and button.timer.expirationTime and (button.timer.expirationTime - GetTime()) > 1.5 then
						button.timer.expirationTime = nil
					elseif useStatusbar and button.countdown.expirationTime and (button.countdown.expirationTime - GetTime()) > 1.5 then
						button.countdown.expirationTime = nil
					end
				end
			end
		end
	until buttonIdx == nil
	ABT:DebugTrace ("GetCooldowns")
end

function ABT:MarkNeedDebuffs(event, arg1)
--	ABT:DebugPrint ("MarkNeedDebuffs")
	needGetDebuffs = true
end

function ABT:GetDebuffs()
	ABT:DebugTrace ("GetDebuffs", true)
	local unit = nil
--	ABT:DebugPrint ("GetDebuffs "..ABT:NS(event).." "..ABT:NS(arg1))
	-- loop over buttons looking for aura timer buttons matching the target
	local barIdx = 1
	local buttonIdx = 0
	repeat 
		barIdx, buttonIdx = ABT:GetNextButton(barIdx, buttonIdx)
--		ABT:DebugPrint ("bar="..ABT:NS(barIdx).." button="..ABT:NS(buttonIdx))
		if barIdx and buttonIdx then
			local button = ABT_Buttons[barIdx][buttonIdx]
			local key = "bar"..barIdx.."button"..buttonIdx
			local timerType = ABT:GetValue (barIdx, buttonIdx, "timerType")
			local location = ABT:GetValue(barIdx, nil, "location")
			local target = button.targetUnit
			if (target == nil) then target = "target" end
			local showOthers = ABT:GetValue (barIdx, buttonIdx, "showOthers")
			local buttonFound = false -- haven't yet found a match for this button
			local useTimer = (timerType == ABT_AURA and location == ABT_ONBUTTONS)
			local useStatusbar = (timerType == ABT_BOTH or (timerType == ABT_AURA and location ~= ABT_ONBUTTONS))
			local tickPrediction = ABT:GetValue(barIdx, buttonIdx, "showTickPrediction")
			local showAuraIcon = ABT:GetValue(barIdx, buttonIdx, "showAuraIcon")
			local actionslot = button.button:GetAttribute("action")
			if (timerType == ABT_AURA or timerType == ABT_BOTH) then -- aura timer
				local effectList = ABT:parseList (ABT:GetValue (barIdx, buttonIdx, "auras"))
				-- build effects list
				if actionslot then
					local actionType, actionId, actionSubType = GetActionInfo (actionslot)
--				ABT:DebugPrint ("type="..ABT:NS(actionType).." id="..ABT:NS(actionId).." subtype="..ABT:NS(actionSubType).." slot="..actionslot)
					if actionType == "spell" then
						local spellName = nil
						if actionSubType == "pet" and actionslot > 120 then
							spellName = GetPetActionInfo (actionslot-120)
						elseif actionId > 0 then
							spellName = GetSpellInfo ( actionId )	
						end
						effectList[100] = spellName
					end
				end

				-- now look for the aura for this button
				local effect
				for _, effect in pairs(effectList) do
					local effectId = tonumber(effect)
					for debuff = 1, 2 do -- check debuffs, then buffs
						for index = 1, 40 do
--							ABT:DebugPrint ("Looking for -"..effect.."- on button "..button:GetName().." target="..ABT:NS(target))
							local name, rank, iconTexture, count, debuffType, duration, timeLeft, expirationTime, isMine, caster, spellId
							timeLeft = nil
							isMine = nil
							expirationTime = nil
							if debuff == 1 then
								name, rank, iconTexture, count, debuffType, duration, expirationTime, caster, _, _, spellId = UnitDebuff (target, index); -- 3.0
								if (name == "Jinx: Curse of the Elements") then
--									ABT:DebugPrint ("now I found effect "..ABT:NS(name).." id="..ABT:NS(spellId).." on target: "..target.." caster="..ABT:NS(caster))
--									ABT:DebugPrint ("try to match against effect="..ABT:NS(effect).." id="..ABT:NS(effectId))
								end
							else
								name, rank, iconTexture, count, debuffType, duration, expirationTime, caster, _, _, spellId = UnitBuff (target, index); -- 3.0
							end
							
							if name == nil then break end -- no more buffs/debuffs

							-- the effect was found on the mob, now lets see if it's ours
							-- use the effect if it is ours, or if the anyCaster flag is set and the button 
							-- was not previously found. This will prioritize our own spells for display if multiple
							-- matching effects are found
							isMine = (caster == "player" or caster == "pet" or caster == "vehicle")
							if ((name ~= nil and name == effect) or (effectId ~= nil and effectId == spellId)) and (isMine or (showOthers and not buttonFound)) then
								if (name == "Jinx: Curse of the Elements") then
									ABT:DebugPrint ("match! "..ABT:NS(name).." rank="..ABT:NS(rank).." count="..ABT:NS(count).." type="..ABT:NS(debuffType).." duration="..ABT:NS(duration).." timeLeft="..ABT:NS(timeLeft).." expirationTime="..ABT:NS(expirationTime).." id="..ABT:NS(spellId).." on target: "..target.." caster="..ABT:NS(caster))
								end
									local currenttime = GetTime()
								timeLeft = expirationTime-currenttime
								local timeStart = expirationTime - duration
								local add = tonumber(ABT:GetValue (barIdx, buttonIdx, "timerAdjust"))
								
								if useTimer then
									button.timer.expirationTime = expirationTime + (add or 0)-- time left on this effect
									if (button.timer.expirationTime <= 0) then
										button.timer.expirationTime = nil
									end
								elseif useStatusbar then
									button.countdown.expirationTime = expirationTime + (add or 0)-- time left on this effect
									if (button.countdown.expirationTime <= 0) then
										button.countdown.expirationTime = nil
										button.effect = nil
									else
										button.count = count
										local barTime
										if ABT:GetValue (barIdx, buttonIdx, "barType") == ABT_FIXED then
											barTime = ABT:GetValue (barIdx, buttonIdx, "barTime")
										else
											barTime = duration
										end
										button.tex.max = barTime
										if button.tex.timerColor then
											button.tex:SetVertexColor (unpack(button.tex.timerColor))
										end
										if button.tex.warnColor then
											button.castTime = ABT:GetCastTime (button)
										end
										button.status:Show()
										if tickPrediction then
											button.effect = effect
										end
										local spellText = nil
										if ABT:GetValue (barIdx, nil, "orientation") == ABT_HORIZONTAL then
											if count > 1 then
												spellText = "x"..ABT:NS(count)
											end
										else -- orientation == ABT_VERTICAL
											spellText = effect

											if count > 1 then
												spellText = spellText.." x"..ABT:NS(count)
											end
											if target ~= "target" then
												spellText = spellText..": "..ABT:NS(UnitName(target))
											end
										end
										button.spellName:SetText(spellText)
										
										if button.tickLength then
											if (timeLeft > (duration - button.tickLength)) then
												ABT:SetTickTime (button, duration - button.tickLength)
											elseif timeLeft < button.tickLength then
												button.nextTick:Hide()
											end
										end
									end
								end
--								ABT:DebugPrint ("bar"..barIdx.."button"..buttonIdx.."showAuraIcon="..ABT:NS(showAuraIcon).." a="..ABT:NS(button.timer.expirationTime).." b="..ABT:NS(button.countdown.expirationTime))
								if ((button.timer.expirationTime or button.countdown.expirationTime) and showAuraIcon and actionslot) then
									button.texture = iconTexture
									button.defaultTexture = GetActionTexture(actionslot)
--									ABT:DebugPrint ("bar"..barIdx.."button"..buttonIdx.." setting icon to: "..ABT:NS(iconTexture))
								end
								buttonFound = true
							end
						end
					end
				end
				if not buttonFound then
					if useTimer then
						button.timer.expirationTime = nil
					elseif useStatusbar then
						button.countdown.expirationTime = nil
					end
				end
			end
		end
	until buttonIdx == nil
--	ABT:DebugPrint ("Exiting GetDebufs buttonIdx="..ABT:NS(buttonIdx))
	ABT:DebugTrace ("GetDebuffs")
end

function ABT:GetNextButton(currentBar, currentButton)
	while true do
		currentButton = currentButton + 1
		if currentButton > ABT_MaxButton then
			currentBar = currentBar + 1
			currentButton = 1
			if currentBar > ABT_MaxBar then
				return nil, nil
			end
		end
		if not ABT:IsButtonHidden (currentBar, currentButton) then
			return currentBar, currentButton
		end
	end
end

function ABT:StartMoving (self)
	ABT:DebugTrace ("StartMoving", true)
	if (not InCombatLockdown() and not self.locked) then
		self:StartMoving()
	end
	ABT:DebugTrace ("StartMoving")
end

function ABT:StopMoving (self)
	ABT:DebugTrace ("StopMoving", true)
	self:StopMovingOrSizing ()
	local barIdx = self.barIdx
	local attach = { self:GetPoint() }
	ABT:SetValue (barIdx, nil, "attach", attach)
--	ABT:DebugPrint ("stop moving bar="..barIdx.." "..ABT:NS(attach))
	ABT:DebugTrace ("StopMoving", true)
end

function ABT:MakeWidgets()
	ABT:DebugTrace ("MakeWidgets", true)
	for barIdx = 1, ABT_MaxBar do
		local barName = ABT_Widgets.."bar"..barIdx
		local bar = CreateFrame ("Frame", barName, UIParent)
		ABT_Bars[barIdx] = bar
		bar.barIdx = barIdx
		-- this texture is handy for seeing where the frame is to drag it.
		-- only show it if the bar is draggable.
		bar.texture = bar:CreateTexture ()
		bar.texture:SetAllPoints(bar)
		bar.texture:SetTexture(1, 1, 1, .1)
		bar.texture:Hide()
		--
		-- setup for dragging
		bar:SetMovable (true)
		bar:SetClampedToScreen (true)
		bar:EnableMouse (true)
		bar:SetScript ("OnMouseDown", function (self) ABT:StartMoving (self) end)
		bar:SetScript ("OnMouseUp", function (self) ABT:StopMoving (self) end)
		bar:SetScript ("OnDragStop", function (self) ABT:StopMoving () end)

		ABT_Buttons[barIdx] = {}
		for buttonIdx = 1, ABT_MaxButton do
			local buttonName = barName.."button"..buttonIdx
			local button = CreateFrame ("Frame", buttonName , bar, "ABTButtonTemplate")

			ABT_Buttons[barIdx][buttonIdx] = button
			button:SetScript ("OnUpdate", function (self, elapsed) ABT:OnUpdate (self, elapsed) end)
			button.barIdx = barIdx
			button.buttonIdx = buttonIdx
			button.icon = _G[buttonName.."ButtonIcon"]
			button.status = _G[buttonName.."ButtonStatusBar"]
			button.tex = _G[buttonName.."ButtonStatusBarTex"]
			button.spellName = _G[buttonName.."ButtonStatusBarSpellName"]
			button.countdown = _G[buttonName.."ButtonStatusBarCountdown"]
			button.timer = _G[buttonName.."ButtonTimer"]
			button.status:Show()
			button.cooldown = _G[buttonName.."ButtonCooldown"]
			button.flash = _G[buttonName.."ButtonTint"]
			button.button = _G[buttonName.."Button"]
			button.nextTick = button.status:CreateTexture(buttonName.."ButtonnextTick", "OVERLAY")
			button.nextTick:SetTexture(1, 1, 1, 1)
			button.nextTick:Hide()
			button.button:HookScript ("OnEnter", 
									function () 
										if ABT:GetValue(barIdx, nil, "hideTooltips") then 
											GameTooltip:Hide() 
										end 
									end)
		end
	end
	ABT:SetAllBars()
	ABT:DebugTrace ("MakeWidgets")
end

-- register buttons with buttonfacade
function ABT:RegisterBF (event, arg1)
	ABT:DebugTrace ("RegisterBF", true)
	if LBF then
		-- buttonfacade callback
		LBF:RegisterSkinCallback("ButtonTimers", self.OnSkin, self)
		for barIdx = 1, ABT_MaxBar do
			local groupID = "Button Timers Bar"..barIdx
			local group = LBF:Group("ButtonTimers", groupID)
			local bfOptions = ABT.db.char["buttonFacade"..groupID]
			if bfOptions then
				group.SkinID,group.Gloss,group.Backdrop,group.Colors = unpack(bfOptions)
			end

			local bar = ABT_Bars[barIdx]

			for buttonIdx = 1, ABT_MaxButton do
				local buttonName = ABT_Widgets.."bar"..barIdx.."button"..buttonIdx
				local button = ABT_Buttons[barIdx][buttonIdx].button
				-- ButtonFacade Support
				local btnData = {
					Icon = _G[buttonName.."Icon"],
					Cooldown = _G[buttonName.."Cooldown"],
					HotKey = _G[buttonName.."HotKey"],
					Count = _G[buttonName.."Count"],
					Name = _G[buttonName.."Name"],
				}
				group:AddButton(button, btnData)
			end
		end
	end
	ABT:DebugTrace ("RegisterBF")
end

local scaleInit = {}

function ABT:SetAllBars (event, arg1)
	for barIdx = 1, ABT_MaxBar do
		ABT:SetBar (barIdx)
	end
end

function ABT:SetBar (barIdx)
	ABT:DebugTrace ("SetBar"..barIdx, true)
	
	if InCombatLockdown() then
		-- we're in combat, don't do anything now, but flag it so we
		-- can do the operation when we leave combat.
		ABT_Bars[barIdx].needsRefresh = true
		return
	end
	local width = 0
	local height = 0

	local buttonCount = ABT:GetValue(barIdx, nil, "buttonCount")
	local orientation = ABT:GetValue(barIdx, nil, "orientation")
	local location = ABT:GetValue(barIdx, nil, "location") 
	local scale = ABT:GetValue(barIdx, nil, "scale")
	local length = ABT:GetValue(barIdx, nil, "length")
	local margin = ABT:GetValue(barIdx, nil, "spacing")
	local actionOffset = ABT:GetValue(barIdx, nil, "actionOffset")
	local enabled = ABT:GetValue(barIdx, nil, "enabled") and ABT:GetValue(nil, nil, "enable")
	local locked = ABT:GetValue(barIdx, nil, "locked")
	local showBackground = ABT:GetValue(nil, nil, "showBackground")
	local inCombat = ABT:GetValue(barIdx, nil, "inCombat")
	local inCombat = ABT:GetValue(barIdx, nil, "inCombat")
	local barFont = LSM:Fetch ("font", ABT:GetValue (barIdx, nil, "font"))
	local barTexture = LSM:Fetch ("statusbar", ABT:GetValue (barIdx, nil, "texture"))
	
	local bar = ABT_Bars[barIdx]

	-- bar enable
	if enabled then
		bar:Show()
	else
		bar:Hide()
		return
	end
	
	-- bar lockdown
	bar.locked = locked
	
	local attach = ABT:GetValue(barIdx, nil, "attach")

	-- set bar position
	if (attach == nil) then
		attach = {"CENTER", nil, "CENTER", (44 * (barIdx-1)), 0}
		ABT:SetValue (barIdx, nil, "attach", attach)
	end
 	bar:ClearAllPoints()
	bar:SetPoint(unpack(attach))

	-- scale option
	local oldscale = bar:GetScale()
	local newscale = scale  * .6

	if oldscale ~= newscale and attach then
		bar:SetScale(newscale)
		if scaleInit[barIdx] ~= nil then
			local point, parent, relpoint, xOfs, yOfs = unpack(attach)
			xOfs = xOfs * oldscale / newscale
			yOfs = yOfs * oldscale / newscale
			attach = {point, parent, relpoint, xOfs, yOfs}
			ABT:SetValue (barIdx, nil, "attach", attach)
--			ABT:DebugPrint ("scaled DB attach="..ABT:NS(attach))
			bar:ClearAllPoints()
			bar:SetPoint(unpack(attach))
		else
			scaleInit[barIdx] = true		
		end
	end
	
	-- button count, target
	for buttonIdx = 1, ABT_MaxButton do
		local button = ABT_Buttons[barIdx][buttonIdx]
                local actionSlot = button.button:GetAttribute("action")
                if actionSlot then
                    button.actionType, button.actionId, button.actionSubType = GetActionInfo(actionSlot)
                end
		if not ABT:IsButtonHidden (barIdx, buttonIdx) then
			button:Show()
			button.visible = true
			local targetIdx = ABT:GetValue(barIdx, buttonIdx, "target")
			local useAsSpellTarget = ABT:GetValue(barIdx, buttonIdx, "useAsSpellTarget")
			button.targetUnit = nil
			if targetIdx == ABT_PARTY then
				local playerTarget = ABT:GetValue(barIdx, buttonIdx, "playerTarget")
				button.targetUnit = ABT:FindPlayerUnitId (playerTarget)
			elseif targetIdx ~= ABT_TARGET then
				button.targetUnit = ABT_TARGET_NAMES[targetIdx]
			else
				button.targetUnit = nil
			end
			if useAsSpellTarget then
				button.button:SetAttribute("unit", button.targetUnit)
			else
				button.button:SetAttribute("unit", nil)
			end

			local statusbarTexture = barTexture or "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar"
--			ABT:DebugPrint ("statusbarTexture="..statusbarTexture)
			local timerColor = ABT:GetValue (barIdx, buttonIdx, "timerColor")
			local textColor = ABT:GetValue (barIdx, buttonIdx, "textColor")
			local warnColor = ABT:GetValue (barIdx, buttonIdx, "timerWarnColor")
			local colorChange = ABT:GetValue (barIdx, buttonIdx, "colorChange")
			local timerType = ABT:GetValue (barIdx, buttonIdx, "timerType")
			
			button.tex.timerColor = timerColor
			button.tex:SetTexture(statusbarTexture)
			if colorChange and warnColor and (timerType == ABT_AURA or timerType == ABT_BOTH) then
				button.tex.warnColor = warnColor
				button.flash:SetTexture (unpack(warnColor))
			else
				button.tex.warnColor = nil
			end
			if timerColor then
				button.tex:SetVertexColor (unpack(timerColor))
			end
			if textColor then
				button.countdown:SetTextColor (unpack(textColor))
				button.spellName:SetTextColor (unpack(textColor))
				button.timer:SetTextColor (unpack(textColor))
			end
	
			button.button:SetAttribute ("action", buttonIdx + actionOffset)
			height = button:GetHeight()
			width = button:GetWidth()

			-- set fonts
			if barFont then
--				ABT:DebugPrint ("font="..ABT:NS(barFont))
				local fontHeight = height / 2
				button.timer:SetFont (barFont, fontHeight)
				button.countdown:SetFont (barFont, fontHeight)
				button.spellName:SetFont (barFont, fontHeight)
			end
			button.status:ClearAllPoints()
			button.countdown:ClearAllPoints()
			button.tex:ClearAllPoints()
			button.spellName:ClearAllPoints()
			button.cooldown.noCooldownCount = nil -- for OmniCC
			button.timer:SetText(nil)
			button.countdown.expirationTime = nil
			button.timer.expirationTime = nil
			local x, y, statusX, statusY
			if orientation == ABT_VERTICAL then
				x = outer_margin
				y = -1* (buttonIdx-1) * (height+margin) - outer_margin
				button.tex.orientation = "HORIZONTAL"
				button.tex:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1) -- standard texture orientation
				button.status:SetHeight(34)
				button.tex:SetHeight(34)
				button.spellName:SetWidth(length-60) -- field starts 60 pixels to the right
				button.spellName:SetHeight(34) -- don't go into a multiline display
				button.status:SetWidth(length)
				button.spellName:Show()
				if location == ABT_TOPRIGHT then
					button.tex.reverse = false
					button.status:SetPoint("TOPLEFT", button:GetName(), "TOPRIGHT")
					button.tex:SetPoint("LEFT", button.status:GetName(), "LEFT", 3, 0)
					button.countdown:SetPoint("LEFT", button.status:GetName(), "LEFT", 14, 0)
					button.spellName:SetPoint("LEFT", button.status:GetName(), "LEFT", 60, 0)
				elseif location == ABT_BOTTOMLEFT then
					button.tex.reverse = true
					button.status:SetPoint("TOPRIGHT", button:GetName(), "TOPLEFT")
					button.tex:SetPoint("RIGHT", button.status:GetName(), "RIGHT", -4, 0)
					button.countdown:SetPoint("RIGHT", button.status:GetName(), "RIGHT", -14, 0)
					button.spellName:SetPoint("RIGHT", button.status:GetName(), "RIGHT", -60, 0)
				elseif location == ABT_ONBUTTONS or timerType == ABT_BOTH then
					button.cooldown.noCooldownCount = true -- for OmniCC
					button.status:Hide()
				end
			else -- orientation == ABT_HORIZONTAL
				x = (buttonIdx-1) * (width+margin) + outer_margin
				y = -outer_margin
				button.tex.orientation = "VERTICAL"
				button.tex:SetTexCoord(0, 1, 1, 1, 0, 0, 1, 0) -- rotate texture 90 degrees for vertical bar
				button.status:SetHeight(length)
				button.status:SetWidth(34)
				button.tex:SetWidth(34)
				button.spellName:SetWidth(68) -- don't truncate the stack counter in this orientation
				button.spellName:Show()
				if ((location == ABT_TOPRIGHT) or (timerType == ABT_BOTH and location == ABT_ONBUTTONS)) then
					button.tex.reverse = false
					button.status:SetPoint("BOTTOMLEFT", button:GetName(), "TOPLEFT")
					button.tex:SetPoint("BOTTOM", button.status:GetName(), "BOTTOM", 0, 3)
					button.countdown:SetPoint("BOTTOMLEFT", button.status:GetName(), "BOTTOMLEFT", 0, 14)
					button.spellName:SetPoint("BOTTOMLEFT", button.status:GetName(), "BOTTOMLEFT", 0, 32)
				elseif location == ABT_BOTTOMLEFT then
					button.tex.reverse = true
					button.status:SetPoint("TOPLEFT", button:GetName(), "BOTTOMLEFT")
					button.tex:SetPoint("TOP", button.status:GetName(), "TOP", 0, -4)
					button.countdown:SetPoint("TOPLEFT", button.status:GetName(), "TOPLEFT", 0, -14)
					button.spellName:SetPoint("TOPLEFT", button.status:GetName(), "TOPLEFT", 0, -32)
				elseif location == ABT_ONBUTTONS then
					button.cooldown.noCooldownCount = true -- for OmniCC
					button.status:Hide()
				end
			end
			button:ClearAllPoints()
			button:SetPoint ("TOPLEFT", x, y)
	
			if locked then
				bar.texture:Hide()
			else
				bar.texture:Show()
			end
		else
			button:Hide()
			button.visible = false
		end
	end
	
	-- layout
	if width ~= 0 and height ~= 0 then
		local barWidth
		local barHeight
		if orientation == ABT_VERTICAL then -- vertical
			barHeight = (height * buttonCount) + ((buttonCount - 1) * margin) + (outer_margin * 2)
			barWidth = width + (outer_margin * 2)
		else -- horizontal
			barHeight = height + (outer_margin * 2)
			barWidth = (width * buttonCount) + ((buttonCount - 1) * margin) + (outer_margin * 2)
		end
--		ABT:DebugPrint ("barHeight="..barHeight.." barWidth="..barWidth)
		bar:SetHeight(barHeight)
		bar:SetWidth(barWidth)
	end

	if inCombat and not InCombatLockdown() then
		bar:Hide()
	end	
	ABT_Bars[barIdx].needsRefresh = nil
	ABT:ButtonUpdate()
	ABT:DebugTrace ("SetBar")
end

function ABT:UpdatePlayerTargets()
ABT:DebugTrace ("UpdatePlayerTargets", true)
	local barIdx = 1
	local buttonIdx = 0
	repeat 
		barIdx, buttonIdx = ABT:GetNextButton(barIdx, buttonIdx)
		if barIdx and buttonIdx then
			if (ABT:GetValue(barIdx, buttonIdx, "target") == ABT_PARTY) then
				local playerTarget = ABT:GetValue (barIdx, buttonIdx, "playerTarget")
				local unitId = ABT:FindPlayerUnitId (playerTarget)
				local button = ABT_Buttons[barIdx][buttonIdx]
				button.targetUnit = unitId
				button.button:SetAttribute ("unit", unitId)
			end
		end
	until buttonIdx == nil
	ABT:MarkNeedDebuffs()
	ABT:DebugTrace ("UpdatePlayerTargets")
end

function ABT:FindPlayerUnitId (playerTarget)
	local unitId = nil
--	ABT:DebugPrint ("FindPlayerUnitId looking for: "..ABT:NS(playerTarget))
	if playerTarget ~= nil then
		local raidNum = GetNumRaidMembers()
		if raidNum > 0 then
			for i = 1, raidNum do
				if UnitName("raid"..i) == playerTarget then
					unitId = "raid"..i
					break
				end
			end
		else
			local partyNum = GetNumPartyMembers()
			for i = 1, partyNum do
				if UnitName("party"..i) == playerTarget then
					unitId = "party"..i
					break
				end
			end
		end
	end
--	ABT:DebugPrint ("FindPlayerUnitId found "..ABT:NS(playerTarget).." as "..ABT:NS(unitId))
	return unitId
end

function ABT:GetPartyList ()
	local _table = {}
	local playerName = nil
	local raidNum = GetNumRaidMembers()
	if raidNum > 0 then
		for i = 1, raidNum do
			playerName = UnitName("raid"..i)
			if playerName then _table[playerName] = playerName end
		end
	else
		for i = 1, 4 do
			playerName = UnitName("party"..i)
			if playerName then _table[playerName] = playerName end
		end
	end
	return _table
end

function ABT:SetStatusBarRemaining (self, remaining)
	local value = remaining / self.tex.max
	if value > 1 then value = 1 end
	local length = ABT:GetValue(self.barIdx, nil, "length")
	if self.tex.orientation == "VERTICAL" then
		self.tex:SetHeight(value*length)
	else
		self.tex:SetWidth(value*length)
	end
end

function ABT:GetCastTime (button)
	local actionSlot = button.button:GetAttribute("action")	
	local actiontype, id, subType
	if actionSlot then
		actiontype, id, subType = GetActionInfo(actionSlot)
	end
	if actiontype == "spell" and id > 0 then
		local spellName
		spellName = GetSpellInfo (id)
		local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellName)
--		ABT:DebugPrint (ABT:NS(actionSlot).." "..ABT:NS(actiontype).." "..ABT:NS(id).." "..ABT:NS(name).." Cast time= "..ABT:NS(castTime))
		return castTime
	end
end

local ABT_TICKWIDTH = 2  -- height/width assumes horizontal bar, for vertical swap them
local ABT_TICKHEIGHT = 8
--
-- Position the tick marker for a button's status bar at the time requested.
function ABT:SetTickTime (self, tickTime)
    -- ABT:DebugPrint ("tt="..tickTime.." max="..self.tex.max.." showTicks="..ABT:NS(ABT:GetValue(self.barIdx, self.buttonIdx, "showTickPrediction")))
	if tickTime and tickTime <= self.tex.max and ABT:GetValue(self.barIdx, self.buttonIdx, "showTickPrediction") then
		if tickTime < 0 then
			tickTime = 0
		end
		local length = ABT:GetValue(self.barIdx, nil, "length") -- get length of bar
		local offset
		local location = ABT:GetValue(self.barIdx, nil, "location") 
		if location == ABT_TOPRIGHT then
			offset = tickTime * length / self.tex.max         -- compute position of tick marker in terms of pixel offset from start of bar
		else
			offset = (self.tex.max - tickTime) * length / self.tex.max         -- compute position of tick marker in terms of pixel offset from start of bar
		end
--		ABT:DebugPrint ("length="..ABT:NS(length).." offsetTime="..ABT:NS(tickTimer).." offset="..ABT:NS(offset).." orien="..ABT:NS(self.tex.orientation)).." loc="..ABT:NS(location))
		-- see if it's already up and in place
		if self.nextTick:IsShown() and self.nextTick.offset == offset then
			return
		end
		self.nextTick:Hide()
		self.nextTick.offset = offset
		-- set dimensions and position of tick marker
		self.nextTick:ClearAllPoints()  -- reset position
		if self.tex.orientation == "VERTICAL" then
			self.nextTick:SetWidth(ABT_TICKHEIGHT)
			self.nextTick:SetHeight(ABT_TICKWIDTH)
			if location == ABT_TOPRIGHT then
				self.nextTick:SetPoint("BOTTOMLEFT", self.status:GetName(), "BOTTOMLEFT", 0, offset)
			else
				self.nextTick:SetPoint("BOTTOMLEFT", self.status:GetName(), "BOTTOMLEFT", 0, offset)
			end
		else
			self.nextTick:SetHeight(ABT_TICKHEIGHT)
			self.nextTick:SetWidth(ABT_TICKWIDTH)
			if location == ABT_TOPRIGHT then
				self.nextTick:SetPoint("TOPLEFT", self.status:GetName(), "TOPLEFT", offset, 0)
			else
				self.nextTick:SetPoint("TOPLEFT", self.status:GetName(), "TOPLEFT", offset, 0)
			end
		end
		self.nextTick.fade = 1
		self.nextTick:SetTexture(1, 1, 1, .1)
		self.nextTick:Show()            -- display tick marker
	else
		self.nextTick:Hide()
	end
end

-- look for incoming dot ticks and set the tick marker to the time of the next calculated tick
function ABT:ProcessCombatLogEvent (_, timestamp, event, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)
	-- only look at the player's events
	if UnitGUID("player") == srcGUID then
		-- only look at periodic spell damage
		if (string.find (event, "SPELL_PERIODIC")) then
			local spellName = select (2, ...)
--			ABT:DebugPrint (event.." "..spellName)
			-- loop over buttons
			local barIdx = 1
			local buttonIdx = 0
			repeat 
				barIdx, buttonIdx = ABT:GetNextButton(barIdx, buttonIdx)
				if barIdx and buttonIdx then
					local button = ABT_Buttons[barIdx][buttonIdx]
					if button.effect ~= nil then
--						ABT:DebugPrint ("checking bar="..barIdx.." button="..buttonIdx.." spell="..ABT:NS(button.effect))
					end
					-- this button is currently showing the effect that matches the damage event
					if button.effect == spellName then
						local target = button.targetUnit or "target"
						-- see if damage target matches the button target
						if (UnitGUID(target) == dstGUID) then
--							ABT:DebugPrint ("tick@"..timestamp.." spell="..spellName.." target="..target.." time="..time().." GetTime="..GetTime())
--							ABT:DebugPrint (" spell="..spellName.." GetTime="..GetTime())
							-- tickLength is the calculated time between dots ticks
							if (button.tickLength) then
								local nextTick = timestamp + button.tickLength -- calculate next tick time
--								ABT:DebugPrint ("nextTick="..nextTick.." tickLength="..button.tickLength.." expTime="..button.countdown.expirationTime)
								-- the timestamp is a value relative to the "time" function. GetTime has a different relative start.
								-- These two times are not compatible :/ Compute the offset based on the expiration time of the timer.
								-- That's going to cause some weirdness in terms of lag, but I don't have a solution right now.
								local offsetTime = 0
								if (button.countdown.expirationTime and button.tickLength) then
									offsetTime = (button.countdown.expirationTime - GetTime() - button.tickLength)
								end
								ABT:SetTickTime (button, offsetTime)
							end
							-- compute the time in between ticks.
							if button.lastTick then
								button.tickLength = timestamp - button.lastTick
--								ABT:DebugPrint ("ticklength="..button.tickLength)
							end
							button.lastTick = timestamp
						end
					end
				end
			until buttonIdx == nil
		end
	end
end