-- Display the fish you're catching and/or have caught in a live display

FishingBuddy.WatchFrame = {};

local MAX_FISHINGWATCH_LINES = 1;
local WATCHDRAGGER_SHOW_DELAY = 0.5;

local ELAPSEDTIME_LINE = 1;
local WATCHDRAGGER_FADE_TIME = 0.15;

local zmto = FishingBuddy.ZoneMarkerTo;
local zmex = FishingBuddy.ZoneMarkerEx;

local ZoneFishingTime = 0;
local TotalTimeFishing = nil;

local Crayon = LibStub("LibCrayon-3.0");
local FL = LibStub("LibFishing-1.0");
local LT = LibStub("LibTourist-3.0");

local timerframe;

-- options for fish watcher
local WatcherOptions = {
	["WatchFishies"] = {
		["text"] = FBConstants.CONFIG_FISHWATCH_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FISHWATCH_INFO,
		["v"] = 1,
		["m"] = 1,
		["default"] = 1 },
	["WatchCurrentSkill"] = {
		["text"] = FBConstants.CONFIG_FISHWATCHSKILL_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FISHWATCHSKILL_INFO,
		["v"] = 1,
		["m"] = 1,
		["default"] = 1,
		["deps"] = { ["WatchFishies"] = "d" } },
	["WatchOnlyWhenFishing"] = {
		["text"] = FBConstants.CONFIG_FISHWATCHONLY_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FISHWATCHONLY_INFO,
		["v"] = 1,
		["m"] = 1,
		["default"] = 1,
		["deps"] = { ["WatchFishies"] = "d" } },
	["WatchCurrentZone"] = {
		["text"] = FBConstants.CONFIG_FISHWATCHZONE_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FISHWATCHZONE_INFO,
		["v"] = 1,
		["m"] = 1,
		["default"] = 0,
		["deps"] = { ["WatchFishies"] = "d" } },
	["WatchFishPercent"] = {
		["text"] = FBConstants.CONFIG_FISHWATCHPERCENT_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FISHWATCHPERCENT_INFO,
		["v"] = 1,
		["m"] = 1,
		["default"] = 1,
		["deps"] = { ["WatchFishies"] = "d" } },
	["WatchElapsedTime"] = {
		["text"] = FBConstants.CONFIG_FISHWATCHTIME_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FISHWATCHTIME_INFO,
		["v"] = 1,
		["m"] = 1,
		["default"] = 0,
		["deps"] = { ["WatchFishies"] = "d" } },
};

-- handle special frame actions
local function PlaceDraggerFrame()
	local where = FishingBuddy.GetSetting("WatcherLocation");
	if ( not where ) then
		where = {};
		where.x = 0;
		where.y = -384;
	end
	FishingWatchDrag:ClearAllPoints();
	FishingWatchDrag:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",
											 where.x, where.y);
end

-- a copy of the equivalent function from Blizz, but customized for our panel
local function PanelTemplates_TabResize_Copy(tab, padding, absoluteSize, maxWidth, absoluteTextSize)
	local tabName = tab:GetName();
	
	local buttonMiddle = getglobal(tabName.."Middle");
	local buttonMiddleDisabled = getglobal(tabName.."MiddleDisabled");
	local sideWidths = 2 * getglobal(tabName.."Left"):GetWidth();
	local tabText = getglobal(tab:GetName().."Text");
	local width, tabWidth;
	local textWidth;
	if ( absoluteTextSize ) then
		textWidth = absoluteTextSize;
	else
		textWidth = tabText:GetWidth();
	end
	-- If there's an absolute size specified then use it
	if ( absoluteSize ) then
		if ( absoluteSize < sideWidths) then
			width = 1;
			tabWidth = sideWidths
		else
			width = absoluteSize - sideWidths;
			tabWidth = absoluteSize
		end
		tabText:SetWidth(width);
	else
		-- Otherwise try to use padding
		if ( padding ) then
			width = textWidth + padding;
		else
			width = textWidth + 24;
		end
		-- If greater than the maxWidth then cap it
		if ( maxWidth and width > maxWidth ) then
			if ( padding ) then
				width = maxWidth + padding;
			else
				width = maxWidth + 24;
			end
			tabText:SetWidth(width);
		else
			tabText:SetWidth(0);
		end
		tabWidth = width + sideWidths;
	end
	
	if ( buttonMiddle ) then
		buttonMiddle:SetWidth(width);
	end
	if ( buttonMiddleDisabled ) then
		buttonMiddleDisabled:SetWidth(width);
	end
	
	tab:SetWidth(tabWidth);
	local highlightTexture = getglobal(tabName.."HighlightTexture");
	if ( highlightTexture ) then
		highlightTexture:SetWidth(tabWidth);
	end
end

local function SizeDraggerFrame()
	local width = FishingWatchFrame:GetWidth();
	local height = FishingWatchFrame:GetHeight();
	FishingWatchDrag:SetHeight(height);
	FishingWatchDrag:SetWidth(width);
end

local function ShowDraggerFrame()
	if ( not FishingWatchTab:IsVisible() ) then
		SizeDraggerFrame();
		FishingWatchTab:SetText(FBConstants.NAME);
		PanelTemplates_TabResize_Copy(FishingWatchTab, 10);
		FishingWatchTab:Show();
		FishingWatchDrag:Show();
		UIFrameFadeIn(FishingWatchDrag, WATCHDRAGGER_FADE_TIME, 0, 0.15);
		UIFrameFadeIn(FishingWatchTab, WATCHDRAGGER_FADE_TIME, 0, 1.0);
	end
end

local function FadeWatcherFrameOut(frame, alpha)
	local fadeInfo = {};
	fadeInfo.mode = "OUT";
	fadeInfo.timeToFade = WATCHDRAGGER_FADE_TIME;
	fadeInfo.startAlpha = alpha;
	fadeInfo.endAlpha = 0;
	local f = frame;
	fadeInfo.finishedFunc = function() f:Hide() end;
	UIFrameFade(frame, fadeInfo);
end

local function HideDraggerFrame(save)
	if ( FishingWatchTab:IsVisible() ) then
		if ( save ) then
			local qx = UIParent:GetLeft()
			local qy = UIParent:GetTop();
			local wx = FishingWatchDrag:GetLeft()
			local wy = FishingWatchDrag:GetTop();
			local where;
			if ( wx and wy ) then
				where = {};
				where.x = wx - qx;
				where.y = wy - qy;
			end
			FishingBuddy.SetSetting("WatcherLocation", where);
		end
		FadeWatcherFrameOut(FishingWatchDrag, 0.15);
		FadeWatcherFrameOut(FishingWatchTab, 1.0);
	end
end

local function ResetWatcherFrame(update)
	PlaceDraggerFrame();
	FishingWatchTab:Show();
	FishingWatchDrag:Show();
	FishingWatchDrag:ClearAllPoints();
	FishingWatchDrag:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	HideDraggerFrame(true);
	if ( update ) then
		FishingBuddy.WatchUpdate();
	end
end

FishingBuddy.ShowDraggerFrame = ShowDraggerFrame;
FishingBuddy.HideDraggerFrame = HideDraggerFrame;
FishingBuddy.PlaceDraggerFrame = PlaceDraggerFrame;
FishingBuddy.ResetWatcherFrame = ResetWatcherFrame;

FishingBuddy.Commands[FBConstants.WATCHER] = {};
FishingBuddy.Commands[FBConstants.WATCHER].help = FBConstants.WATCHER_HELP;
FishingBuddy.Commands[FBConstants.WATCHER].func =
	function(what)
		if ( what and ( what == FBConstants.RESET ) ) then
			ResetWatcherFrame(true);
			return true;
		end
	end;

-- handle tracking the fish that are in the current zone
-- we'll handle mutlti-zone watching without reset later (i.e a future option)
local totalCount = 0;
local totalCurrent = 0;
local gotDiffs = false;

local goldcoins = { ["count"] = 0, ["current"] = 0, ["text"] = FBConstants.GOLD_COIN, ["calc"] = 1 };
local silvercoins = { ["count"] = 0, ["current"] = 0, ["text"] = FBConstants.SILVER_COIN, ["calc"] = 1 };
local coppercoins = { ["count"] = 0, ["current"] = 0, ["text"] = FBConstants.COPPER_COIN, ["calc"] = 1 };
local missed = { ["count"] = 0, ["current"] = 0, ["text"] = SPELL_FAILED_TRY_AGAIN, ["quality"] = 0, ["calc"] = 1, ["skipped"] = 1 };
local fishdata = nil;
local fishsort = nil;

-- is this one of the four kinds of catch we're not going to sort into
-- our "fish" list
local function IsSpecialFish(fishid, itemTexture)
	local basetexture = "INV_Misc_Coin";
	local goldtexture = "_17";
	local silvertexture = "_18";
	local coppertexture = "_19";

	if (string.find(itemTexture, basetexture)) then
		if (string.find(itemTexture, goldtexture)) then
			return goldcoins;
		elseif (string.find(itemTexture, silvertexture)) then
			return silvercoins;
		elseif (string.find(itemTexture, coppertexture)) then
			return coppercoins;
		end
	end
	if ( FL:IsMissedFish(fishid) ) then
		return missed;
	end
	-- return nil;
end

-- fix old data that had UNKNOWN as a zone name.
-- this is *really* old data, and we might not need it
-- unless, of course, there is a bug in LibBabble-Zone. Sigh.
local function UpdateUnknownZone(zone, subzone, zidx, sidx)
	if ( subzone == UNKNOWN or subzone == FBConstants.UNKNOWN ) then
		return;
	end
	
	local uzidx = FishingBuddy.GetZoneIndex(UNKNOWN);
	if ( uzidx ) then
		local fh = FishingBuddy_Info["FishingHoles"];
		local uidx = zmto(uzidx,0);
		local count = FishingBuddy_Info["SubZones"][uidx];
		if ( count ) then
			for s=1,count,1 do
				uidx = zmto(uzidx, s);
				if ( fh[uidx] ) then
					local uszone = FL:GetBaseSubZone(FishingBuddy_Info["SubZones"][uidx]);
					if ( uszone == subzone ) then
						for k,v in pairs(fh[uidx]) do
							if ( fh[sidx][k] ) then
								fh[sidx][k] = fh[sidx][k] + v;
							else
								fh[sidx][k] = v;
							end
						end
						for k,_ in pairs(fh[uidx]) do
							fh[uidx][k] = nil;
						end
					end
				end
			end
		end
	end
end

-- build a single info entry for a given FishingBuddy.WatchFrame.OnClick 
local function BuildInfoEntry(fishid, count)
	local IsCountedFish = FishingBuddy.API.IsCountedFish;
	local IsQuestFish = FishingBuddy.API.IsQuestFish;

	local fz = FishingBuddy_Info["FishingHoles"];
	local ff = FishingBuddy_Info["Fishies"];
	local hidden = FishingBuddy_Info["HiddenFishies"];

	local info = {};
	if ( not hidden[fishid] ) then
		_, _, _, _, _, info.text, _ = FishingBuddy.GetFishie(fishid);
	end
	info.quality = ff[fishid].quality or 0;
	info.current = 0;
	info.count = count;
	if ( IsCountedFish(fishid) ) then
		totalCount = totalCount + info.count;
		totalCurrent = totalCurrent + info.current or 0;
	else
		info.skipped = 1;
		info.quest = IsQuestFish(fishid);
	end
	return info;
end

-- sort fishort, based on fishdata
local function SortFishData(forcename)
	if ( forcename or not FishingBuddy.GetSettingBool("SortByPercent") ) then
		table.sort(fishsort, function(a,b) return fishdata[a].text < fishdata[b].text; end);
	else
		table.sort(fishsort, function(a,b) return fishdata[a].count and fishdata[b].count and fishdata[b].count<fishdata[a].count; end);
	end
end

-- for the specified zone and subzone, display the watch data
-- we might want to display multiple zones someday, so this
-- will need to be rewrittent to store the data differently
local function BuildCurrentData(zone, subzone, zidx, sidx)
	-- catch any errors in the unknown zone update
	pcall(UpdateUnknownZone, zone, subzone, zidx, sidx);

	totalCount = 0;
	totalCurrent = 0;
	fishdata = {};
	fishsort = {};
	gotDiffs = false;
	
	goldcoins.count = 0;
	goldcoins.current = 0;
	silvercoins.count = 0;
	silvercoins.current = 0;
	coppercoins.count = 0;
	coppercoins.current = 0;
	missed.count = 0;
	missed.current = 0;

	local idx = zmto(zidx, sidx);
	local fz = FishingBuddy_Info["FishingHoles"];
	if ( fz and fz[idx] ) then
		local ff = FishingBuddy_Info["Fishies"];
		for fishid,count in pairs(fz[idx]) do
			local itemTexture = ff[fishid].texture;
			local info = IsSpecialFish(fishid, itemTexture);
			if ( info ) then
				info.count = info.count + count;
				if ( not info.skipped ) then
					totalCount = totalCount + count;
				end
			else
				info = BuildInfoEntry(fishid, count);
				fishdata[fishid] = info;
				tinsert(fishsort, fishid);
			end
		end
	end
	SortFishData();
end

local function HandleZoneChange()
	if ( not FishingBuddy.IsLoaded() ) then
		return;
	end
	fishsort = nil
	fishdata = nil;
	FishingBuddy.WatchUpdate();
	if ( TotalTimeFishing ) then
		TotalTimeFishing = TotalTimeFishing + ZoneFishingTime;
		ZoneFishingTime = 0;
		FishingBuddy.SetSetting("TotalTimeFishing", TotalTimeFishing);
	end
end

-- keep track of what's going on
local lastSkillCheck = 0;
local lastSkillMax = 0;
local WatchEvents = {};
WatchEvents["ZONE_CHANGED"] = HandleZoneChange;
WatchEvents["ZONE_CHANGED_INDOORS"] = HandleZoneChange;
WatchEvents["ZONE_CHANGED_NEW_AREA"] = HandleZoneChange;

WatchEvents["SKILL_LINES_CHANGED"] = function()
	if ( FishingBuddy.GetSettingBool("WatchCurrentSkill") ) then
		FishingBuddy.WatchUpdate();
	end
end

WatchEvents["SPELLCAST_STOP"] = function()
	if ( FishingWatchFrame:IsVisible() ) then
		-- update the skill line if we have one
		if ( FishingBuddy.GetSettingBool("WatchCurrentSkill") ) then
			FishingBuddy.WatchUpdate();
		end
	end
end

WatchEvents[FBConstants.ADD_FISHIE_EVT] = function(id, name, zone, subzone, texture, quantity, quality, level, idx)
	if ( FishingWatchFrame:IsVisible() ) then
		if ( fishdata[id] ) then
			info = fishdata[id];
		else
			info = IsSpecialFish(id, texture);
			if ( not info ) then
				-- we'll count these in a second
				fishdata[id] = BuildInfoEntry(id, 0);
				info = fishdata[id];
				tinsert(fishsort, id);
			end
		end
		info.count = info.count + quantity;
		info.current = info.current + quantity;
		if ( FishingBuddy.API.IsCountedFish(id) ) then
			totalCount = totalCount + quantity;
			totalCurrent = totalCurrent + quantity;
			gotDiffs = true;
		end
		SortFishData();
		FishingBuddy.WatchUpdate();
	end
end

WatchEvents["VARIABLES_LOADED"] = function()
	ZoneFishingTime = 0;
	lastSkillCheck, _, lastSkillMax = FL:GetCurrentSkill();

	-- Make everything draw at least once
	ShowDraggerFrame();
	HideDraggerFrame();
	
	FishingBuddy.OptionsFrame.HandleOptions(FBConstants.WATCHER_TAB, "Interface\\Icons\\Inv_Misc_Spyglass_03", WatcherOptions);
end

WatchEvents[FBConstants.FISHING_ENABLED_EVT] = function()
	-- because we're us, this will just use the setting of "CaughtSoFar"
	FL:SetCaughtSoFar();
	TotalTimeFishing = FishingBuddy.GetSetting("TotalTimeFishing");
	ZoneFishingTime = 0;
	FishingBuddy.WatchUpdate();
end

WatchEvents[FBConstants.FISHING_DISABLED_EVT] = function(started)
	ZoneFishingTime = ZoneFishingTime + GetTime() - started;
	if (TotalTimeFishing) then
		TotalTimeFishing = TotalTimeFishing + ZoneFishingTime;
		ZoneFishingTime = 0;
		FishingBuddy.SetSetting("TotalTimeFishing", TotalTimeFishing);
		FishingBuddy.SetSetting("CaughtSoFar", FL:GetCaughtSoFar());
	end
end

-- Handle display elapsed time in some reasonable fashion
local function DisplayedTime(elapsed)
	t = elapsed;
	local secs = t % 60;
	t = ( t - secs ) / 60;
	local mins = t % 60;
	t = ( t - mins ) /60;
	local hrs  = t % 24;
	t = ( t - hrs ) / 24;
	
	if ( t > 0 ) then
		return( string.format( "%d %.2d:%.2d:%.2d", t, hrs, mins, secs ) );
	else
		return( string.format( "%.2d:%.2d:%.2d", hrs, mins, secs ) );
	end
end

local fishingWatchMaxWidth;
local function SetEntry(index, text)
	local name = "FishingWatchLine"..index;
	local entry = getglobal(name);
	if ( not entry ) then
		local first = getglobal("FishingWatchLine1");
		entry = FishingWatchFrame:CreateFontString(name, "BACKGROUND", "FishingWatchFontTemplate");
		entry:SetJustifyH("LEFT");
		entry:SetHeight(first:GetHeight());
		entry:SetPoint("TOPLEFT", "FishingWatchLine"..(index-1), "BOTTOMLEFT");
		local fontFile, fontSize, fontFlags = first:GetFont();
	  entry:SetFont(fontFile, fontSize, fontFlags);
		MAX_FISHINGWATCH_LINES = MAX_FISHINGWATCH_LINES + 1;
	end
	entry:SetText(text);
	local tempWidth = entry:GetWidth();
	if ( not fishingWatchMaxWidth or tempWidth > fishingWatchMaxWidth ) then
		fishingWatchMaxWidth = tempWidth;
	end
	entry:Show();
end

-- Fish watcher functions
local function NoShow()
	local GSB = FishingBuddy.GetSettingBool;
	return (not GSB("WatchFishies") or (GSB("WatchOnlyWhenFishing") and not FL:IsFishingPole()));
end

local function UpdateTimerLine()
	if ( not NoShow() and FishingBuddy.GetSettingBool("WatchElapsedTime") ) then
		local StartedFishing = FishingBuddy.StartedFishing;
		if ( StartedFishing ) then
			if ( not TotalTimeFishing ) then
				WatchEvents[FBConstants.FISHING_ENABLED_EVT]();
			end
			local elapsed = math.floor(ZoneFishingTime + GetTime() - StartedFishing);
			local text = FBConstants.ELAPSED..": "..DisplayedTime(elapsed).."/"..DisplayedTime(math.floor(elapsed + TotalTimeFishing));
			SetEntry(ELAPSEDTIME_LINE, text);
			timerframe:Show();
		end
	elseif ( timerframe:IsShown() ) then
		timerframe:Hide();
	end
end

function UpdateTotalsLine(index)
	if ( not NoShow() ) then
		local totalpart = ": "..totalCount;
		local line;
		if ( gotDiffs ) then
			line = FBConstants.TOTALS..totalpart.." "..Crayon:Green("("..totalCurrent..")");
		else
			line = FBConstants.TOTAL..totalpart;
		end
		local GSB = FishingBuddy.GetSettingBool;
		if ( GSB("WatchCurrentSkill") ) then
			local _, playerskill = FL:GetFishingSkillLine(false, true);
			line = line..Crayon:White(" | ")..CHAT_MSG_SKILL..": "..playerskill;
			local needed;
			local caughtSoFar;
			lastSkillCheck, caughtSoFar, needed = FL:GetSkillUpInfo(lastSkillCheck);
			if ( needed ) then
				line = line.." ("..caughtSoFar.."/~"..needed..")";
			end
		end
		if ( not index ) then
			index = 1;
			if ( GSB("WatchElapsedTime") ) then
				index = index + 1;
			end
			if ( GSB("WatchCurrentZone") ) then
				index = index + 1;
			end
		end
		SetEntry(index, line);
	end
end

WatchEvents["LOOT_CLOSED"] = function()
	UpdateTotalsLine();
end

local function UpdateFishieEntry(index, info)
	local fishietext = FishingBuddy.StripRaw(info.text);
	local dopercent = FishingBuddy.GetSettingBool("WatchFishPercent");
	local amount = info.count;
	if ( info.skipped ) then
		if ( info.quest ) then
			fishietext = fishietext.." ("..amount..")";
		else
			fishietext = Crayon:Copper(fishietext.." ("..amount..")");
		end
	else
		if ( info.quality and ITEM_QUALITY_COLORS[info.quality] ) then
			fishietext = ITEM_QUALITY_COLORS[info.quality].hex..fishietext.."|r ";
		else
			fishietext = Crayon:Red(fishietext);
		end

		local white = "|cff"..Crayon.COLOR_HEX_WHITE;
		local silver = "|cff"..Crayon.COLOR_HEX_SILVER;
		local color1, color2;
		if ( gotDiffs ) then
			color1 = silver;
			color2 = white;
		else
			color1 = white;
		end
		local numbers = white.."(".."|r"..color1..amount;
		if ( dopercent ) then
			local percent = format("%.1f", ( amount / totalCount ) * 100);
			numbers = numbers.." : "..percent.."%";
		end
		if ( gotDiffs ) then
			numbers = numbers..", |r";
			amount = info.current or 0;
			local diffs = amount;
			if ( dopercent ) then
				local percent = format("%.1f", ( amount / totalCurrent ) * 100);
				diffs = diffs.." : "..percent.."%";
			end
			numbers = numbers..color2..diffs.."|r";
		else
			numbers = numbers.."|r";
		end
		fishietext = fishietext..numbers..white..")|r";
	end
	SetEntry(index, fishietext);
	index = index + 1;
	return index;
end

WatchEvents[FBConstants.OPT_UPDATE_EVT] = function(changed)
	FishingBuddy.WatchUpdate();
end

local function WatchUpdate()
	local reset = FishingBuddy.GetSetting("ResetWatcher");
	if ( not reset or reset < 1 ) then
		ResetWatcherFrame(false);
		FishingBuddy.SetSetting("ResetWatcher", 1);
	end

	local zone, subzone = FL:GetZoneInfo();
	if ( zone == FBConstants.UNKNOWN ) then
		return;
	end

	local noshow = NoShow();

	if ( noshow ) then
		if ( FishingWatchFrame:IsVisible() ) then
			HideDraggerFrame();
			FishingWatchFrame:Hide();
			for i=1, MAX_FISHINGWATCH_LINES, 1 do
				local line = getglobal("FishingWatchLine"..i);
				line:Hide();
			end
			timerframe:Hide();
		end
		return;
	end

	if ( not FishingWatchFrame:IsShown() ) then
		PlaceDraggerFrame();
		FishingWatchFrame:Show();
	end

	local line;

	if ( not fishsort ) then
		local zidx, sidx = FishingBuddy.AddZoneIndex(zone, subzone);
		BuildCurrentData(zone, subzone, zidx, sidx);
	end
	
	local index = 1;
	fishingWatchMaxWidth = 0;
	if (FishingBuddy.GetSettingBool("WatchElapsedTime")) then
		UpdateTimerLine();
		index = index + 1;
	end
	
	local skill, mods, skillmax = FL:GetCurrentSkill();
	local zoneskill, _ = FL:GetFishingSkillLine(false, true);
	if ( FishingBuddy.GetSettingBool("WatchCurrentZone") ) then
		SetEntry(index, zoneskill);
		index = index + 1;
	end

	UpdateTotalsLine(index);
	index = index + 1;

	for idx,fishid in ipairs(fishsort) do
		local info = fishdata[fishid];
		local fishie = info.text;
		if ( fishie ) then
			index = UpdateFishieEntry(index, info);
		end
	end

	if (coppercoins.count > 0) then
		index = UpdateFishieEntry(index, coppercoins);
	end
	if (silvercoins.count > 0) then
		index = UpdateFishieEntry(index, silvercoins);
	end
	if (goldcoins.count > 0) then
		index = UpdateFishieEntry(index, goldcoins);
	end
	if (missed.count > 0) then
		index = UpdateFishieEntry(index, missed);
	end

	for i=index, MAX_FISHINGWATCH_LINES, 1 do
		local line = getglobal("FishingWatchLine"..i);
		line:Hide();
	end

	FishingWatchFrame:SetHeight((index - 1) * 13);
	FishingWatchFrame:SetWidth(fishingWatchMaxWidth + 10);
	SizeDraggerFrame();
end
FishingBuddy.WatchUpdate = WatchUpdate;

FishingBuddy.WatchFrame.OnLoad = function(self)
	self:ClearAllPoints();
	self:SetPoint("TOPLEFT", "FishingWatchDrag", "TOPLEFT", 0, 0);

	-- FishingWatchElapsedTime, FishingWatchCurrentZone, FishingWatchInfo, FishingWatchLine1
	
	timerframe = CreateFrame("FRAME");
	timerframe:Hide();
	timerframe:SetScript("OnUpdate", UpdateTimerLine);

	FishingBuddy.API.RegisterHandlers(WatchEvents);
end

local isDragging = nil;
local hover;
FishingBuddy.WatchFrame.OnUpdate = function(self, elapsed)
	if ( FishingWatchFrame:IsVisible() ) then
		if ( isDragging ) then
			return;
		end
		if ( MouseIsOver(FishingWatchTab) or MouseIsOver(FishingWatchDrag) ) then
			local xPos, yPos = GetCursorPosition();
			if ( hover ) then
				if ( hover.xPos == xPos and hover.yPos == yPos ) then
					hover.hoverTime = hover.hoverTime + elapsed;
				else
					hover.hoverTime = 0;
					hover.xPos = xPos;
					hover.yPos = yPos;
				end
			else
				hover = {};
				hover.hoverTime = 0;
				hover.xPos = xPos;
				hover.yPos = yPos;
			end
			if ( hover.hoverTime > WATCHDRAGGER_SHOW_DELAY ) then
				ShowDraggerFrame();
				hover.hoverTime = 0;
			end
		else
			if ( hover ) then
				hover.hoverTime = hover.hoverTime + elapsed;
				if ( hover.hoverTime > WATCHDRAGGER_SHOW_DELAY ) then
					HideDraggerFrame(true);
					hover = nil;
				end
			end
		end
	elseif ( hover ) then
		HideDraggerFrame(true);
		hover = nil;
	end
end

FishingBuddy.WatchFrame.OnDragStart = function(self)
	isDragging = true;
	FishingWatchDrag:StartMoving();
end

FishingBuddy.WatchFrame.OnDragStop = function(self)
	FishingWatchDrag:StopMovingOrSizing();
	isDragging = nil;
end

local function HiddenFishToggle(id)
	if ( FishingBuddy_Info["HiddenFishies"][id] ) then
		FishingBuddy_Info["HiddenFishies"][id] = nil;
	else
		FishingBuddy_Info["HiddenFishies"][id] = true;
	end;
	FishingBuddy.WatchUpdate();
end

-- save some memory by keeping one copy of each one
local WatcherToggleFunctions = {};
-- let's use closures
local function WatcherMakeToggle(fishid)
	if ( not WatcherToggleFunctions[fishid] ) then
		local id = fishid;
		WatcherToggleFunctions[fishid] = function() HiddenFishToggle(id); end;
	end
	return WatcherToggleFunctions[fishid];
end
FishingBuddy.WatchFrame.MakeToggle = WatcherMakeToggle;

local function WatchMenu_Initialize()
	local zidx, sidx = FishingBuddy.GetZoneIndex();
	local idx = zmto(zidx, sidx);
	local fz = FishingBuddy_Info["FishingHoles"];
	if ( fz and fz[idx] ) then
		local ff = FishingBuddy_Info["Fishies"];
		for fishid in pairs(fz[idx]) do
			info = {};
			info.text = ff[fishid][loc];
			info.func = WatcherMakeToggle(fishid);
			info.checked = ( not FishingBuddy_Info["HiddenFishies"][fishid] );
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info);
		end
	end
end

FishingBuddy.WatchFrame.OnClick = function(self)
-- we need to be smarter about the things we filter (trash, coins, etc.)
	if ( false ) then
		local menu = getglobal("FishingBuddyWatcherMenu");
		UIDropDownMenu_Initialize(menu, WatchMenu_Initialize, "MENU");
		ToggleDropDownMenu(1, nil, menu, "FishingWatchTab", 10, 10);
	end
end
