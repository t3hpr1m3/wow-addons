-- Support for the Extravaganza
--
-- Map support liberally borrowed from GuildMap, by Bru on Blackhand

FishingBuddy.Extravaganza = {};

local Crayon = LibStub("LibCrayon-3.0");
local FL = LibStub("LibFishing-1.0");
local LT = LibStub("LibTourist-3.0");
local Astrolabe = DongleStub("Astrolabe-1.0");

local UPDATETIME_SCHOOLS = 5.0;
local UPDATETIME_COUNTER = 20.0;
local NUMMINIPOIS = 10;
local ICONPATH = "Interface\\AddOns\\FishingBuddy\\Icons\\";

local UpdateTimer = 0;

-- the actual names don't matter, except to help make sure I've got 'em all
local ExtravaganzaFish = {};
ExtravaganzaFish[19807] = "Speckled Tastyfish";
ExtravaganzaFish[19806] = "Dezian Queenfish";
ExtravaganzaFish[19805] = "Keefer's Angelfish";
-- makes you wonder what item 19804 is, doesn't it...
ExtravaganzaFish[19803] = "Brownell's Blue Striped Racer";

FishingBuddy.Extravaganza.Fish = ExtravaganzaFish;

local ContestIsOver;

local CurrentContest;
local Contests = {};
Contests[1] = {
	["day"] = 1,
	["hour"] = 14,
	["dur"] = 2,
	["fishid"] = 19807,
	["count"] = 40,
	["continent"] = "Eastern Kingdoms",
	["zones"] = { "Stranglethorn Vale", "The Cape of Stranglethorn", "Northern Stranglethorn" },
	["kind"] = FL.SCHOOL_TASTY,
	["setting"] = "STVTimer",
	["name"] = FBConstants.EXTRAVAGANZA,
	["yell"] = FBConstants.RIGGLE_BASSBAIT,
};

Contests[2] = {
	["day"] = 7,
	["hour"] = 14,
	["dur"] = 1,
	["fishid"] = 50289,
	["count"] = 1,
	["continent"] = "Northrend",
	-- ["zone"] -- any zone in Northrend
	["kind"] = FL.SCHOOL_FISH,	 -- normal fish pools
	["setting"] = "DerbyTimer",
	["name"] = FBConstants.DERBY,
	["yell"] = FBConstants.ELDER_CLEARWATER,
};

local FBGetSettingBool = FishingBuddy.GetSettingBool;
local function GetSettingBool(setting)
	if (FBGetSettingBool("ContestSupport")) then
		return FBGetSettingBool(setting);
	end
	-- return nil;
end

-- let an external entity forcibly mark a school
FishingBuddy.Extravaganza.MarkSchool = function()
	local zone, subzone = FL:GetZoneInfo();
	if ( zone == FBConstants.STVZONENAME ) then
		FishingBuddy.Schools.AddFishingSchool(FL.SCHOOL_TASTY, 19807, zone);
	end
end

local function ExtravaganzaHijackCheck()
	if ( FishingBuddy.NormalHijackCheck() ) then
		-- also check to make sure we're over a pool
		return FL:IsFishingPool();
	end
end

local function IsContestZone()
	if ( CurrentContest ) then
		local zone,_ = FL:GetZoneInfo();
		local landmass = LT:GetContinent(zone);
		-- Are we on the right continent?
		if ( landmass == CurrentContest.continent ) then
			-- if not zone limited, we're there
			if ( not CurrentContest.zones ) then
				return true;
			else
				-- otherwise, see if we're in the right zone
				for _,conzone in ipairs(CurrentContest.zones) do
					if ( conzone == zone) then
						return true;
					end
				end
			end
		end
	end
	-- return nil;
end

-- keep track of the pools we want to see
local iconcache = {};
local function GetFreePoolIcon()
	local pdx = nil;
	for idx=#iconcache,1,-1 do
		if (not iconcache[idx].inuse ) then
			pdx = idx;
		end
	end
	if ( not pdx ) then
		pdx = #iconcache + 1;
		local pool = CreateFrame("BUTTON", "FBIcon"..pdx, UIParent);
		pool:SetWidth(20);
		pool:SetHeight(20);
		local tex = pool:CreateTexture("FBIcon"..pdx.."Texture", "ARTWORK");
		tex:SetTexture("Interface\\Minimap\\ObjectIcons");
		tex:SetTexCoord(0.875, 1.0, 0.25, 0.5);
		tex:SetVertexColor(1, 1, 1, 0.3);
		tex:SetAllPoints();
		pool:SetNormalTexture(tex);
		pool.tex = tex;
		tinsert(iconcache, pool);
		pdx = #iconcache;
	end
	iconcache[pdx].inuse = true;
	return iconcache[pdx];
end

local lastzone = nil;
local contestpools = {};
local function HidePools()
	for _,pool in ipairs(iconcache) do
		if (pool.inuse) then
			Astrolabe:RemoveIconFromMinimap(pool);
			pool.inuse = nil;
		end
	end
end

local function UpdateIcons()
	for _,t in ipairs(contestpools) do
		if (t.icon) then
			if ( Astrolabe:IsIconOnEdge(t.icon) ) then
				t.icon.tex:SetVertexColor(1, 1, 1, 0.1);
			else
				t.icon.tex:SetVertexColor(1, 1, 1, 0.3);
			end
		end
	end
end

local function ShowPools(forced)
	if ( IsContestZone() and GetSettingBool("ShowPools") ) then
		local zone,_ = FL:GetZoneInfo();
		if ( forced or not lastzone or lastzone ~= zone ) then
			lastzone = zone;
			local kind = CurrentContest.kind;
			local schools = FishingBuddy.Schools.GetSchools(zone);
			HidePools();
			contestpools = {};
			for idx=1,table.getn(schools) do
				local t = schools[idx];
				if ( not kind or t.kind == kind ) then
					local info = {};
					info.x = t.x;
					info.y = t.y;
					info.icon = GetFreePoolIcon();
					tinsert(contestpools, info);
				end
			end
			if ( #contestpools > 0 ) then
				local C, Z, x, y = Astrolabe:GetCurrentPlayerPosition();
				for idx=1,#contestpools do
					local t = contestpools[idx];
					local icon = t.icon;
					Astrolabe:PlaceIconOnMinimap( icon, C, Z, t.x, t.y );
					if ( Astrolabe:IsIconOnEdge(icon) ) then
						icon.tex:SetVertexColor(1, 1, 1, 0.1);
					else
						icon.tex:SetVertexColor(1, 1, 1, 0.3);
					end
				end
			end
			FishingBuddy.contestpools = contestpools;
			FishingBuddy.Dump(contestpools);
		end
	end
end

-- Should we display the extravaganza message?
local function IsTime(activate)
	CurrentContest = nil;
	if ( FishingBuddy.IsLoaded() ) then
		if ( GetSettingBool("STVTimer") ) then
			local hour,minute = GetGameTime();
			local weekday, _, _, _ = CalendarGetDate();
			for idx=1,#Contests do
				local c = Contests[idx];
				if ( GetSettingBool(c.setting) ) then
					if ( weekday == c.day ) then
						local s = c.hour - 2;
						local e = c.hour + c.dur;
						if ( hour >= s and hour < e ) then
							CurrentContest = c;
						end
					end
				end
			end
		end
	end
	if ( CurrentContest ) then
		if ( activate ) then
			FishingExtravaganzaFrame:Show();
			ShowPools();
		end
		if ( GetSettingBool("STVPoolsOnly") ) then
			if ( IsContestZone() ) then
				FishingBuddy.SetHijackCheck(ExtravaganzaHijackCheck);
			else
				FishingBuddy.SetHijackCheck();
			end
		end
		if ( not GetSettingBool("ShowPools") ) then
			HidePools();
		end
		return true;
	else
		HidePools();
		FishingBuddy.SetHijackCheck();
	end
	-- return nil;
end
FishingBuddy.Extravaganza.IsTime = IsTime;

-- Check for mouse down event for dragging frame.
FishingBuddy.Extravaganza.OnDragStart = function(self, button)
	if (not self.isMoving and (button == "LeftButton")) then
		self:StartMoving();
		self.isMoving = true;
	end
end

-- Check for drag stop event to stop dragging.
FishingBuddy.Extravaganza.OnDragStop = function(self, button)
	if (self.isMoving) then
		self:StopMovingOrSizing();
		self.isMoving = false;
	end
end

local ExtravaganzaEvents = {}
ExtravaganzaEvents[FBConstants.ADD_FISHIE_EVT] = function(id, name, ...)
	if ( CurrentContest and CurrentContest.fishid == id ) then
		UpdateTimer = 0;
		for _,contest in ipairs(Contests) do
			local _,_,_,_,_,n = FishingBuddy.GetFishie(contest.fishid);
			if ( n ) then
				contest.fishname = n;
			end
		end
	end
end

ExtravaganzaEvents[FBConstants.ADD_SCHOOL_EVT] = function(kind, fishid, zidx, x, y)
	if ( CurrentContest and kind == CurrentContest.kind and IsContestZone() and GetSettingBool("ShowPools") ) then
		local icon = GetFreePoolIcon();
		icon.tex:SetVertexColor(1, 1, 1, 0.2);

		local C, Z, _, _ = Astrolabe:GetCurrentPlayerPosition();
		local t = {};
		t.x = x;
		t.y = y;
		t.icon = icon;
		tinsert(contestpools, t);		
		Astrolabe:PlaceIconOnMinimap( icon, C, Z, t.x, t.y );
	end
end

ExtravaganzaEvents[FBConstants.OPT_UPDATE_EVT] = function(changed)
	IsTime();
	Astrolabe:CalculateMinimapIconPositions();
end

-- Handle watching the loot
FishingBuddy.Extravaganza.OnLoad = function(self)
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	self:RegisterEvent("VARIABLES_LOADED");

	self:RegisterForDrag("LeftButton");
	self:Hide();

	FishingBuddy.API.RegisterHandlers(ExtravaganzaEvents);
end

FishingBuddy.Extravaganza.OnShow = function(self)
	-- check each of the bags on the player
	UpdateTimer = 0;
	FishingBuddy.Extravaganza.OnUpdate(self, 0);
end

FishingBuddy.Extravaganza.OnHide = function(self)
	if ( FishingExtravaganzaPOIUpdate and
		  FishingExtravaganzaPOIUpdate:IsVisible() ) then
		FishingExtravaganzaPOIUpdate:Hide();
	end
end

-- Elder Clearwater yells: The Kalu'ak Fishing Derby starts in 5 minutes!
-- Elder Clearwater yells: The Kalu'ak Fishing Derby has begun!  The first person to bring a blacktip shark to me in Dalaran will be declared the winner!  Blacktip sharks can be caught anywhere you can catch a pygmy suckerfish.
-- Elder Clearwater yells: NAME has won the Kalu'ak Fishing Derby!

FishingBuddy.Extravaganza.OnEvent = function(self, event, ...)
	if ( event == "CHAT_MSG_YELL" ) then
		if ( CurrentContest ) then
			-- Riggle Bassbait yells: We have a winner! (.*) is the Master Angler!
			local arg1 = select(1, ...);
			local e,s,n = string.find(arg1, CurrentContest.yell);
			if ( e ) then
				ContestIsOver = true;
			end
		end
	elseif ( event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_LOGIN" ) then
		if ( IsContestZone() and IsTime() ) then
			self:RegisterEvent("CHAT_MSG_YELL");
			ShowPools();
		else
			self:UnregisterEvent("CHAT_MSG_YELL");
			HidePools();
		end
	elseif ( event == "VARIABLES_LOADED" ) then
		for _,contest in ipairs(Contests) do
			local _,_,_,_,_,n = FishingBuddy.GetFishie(contest.fishid);
			if ( n ) then
				contest.fishname = n;
			end
		end
		
		IsTime(true);
		self:UnregisterEvent("VARIABLES_LOADED");
		Astrolabe:Register_OnEdgeChanged_Callback(UpdateIcons,1);
	end
end

FishingBuddy.Extravaganza.OnUpdate = function(self, elapsed)
	if ( IsTime() ) then
		if ( not self:IsShown() ) then
			self:Show();
		end
		UpdateTimer = UpdateTimer - elapsed;
		if ( UpdateTimer <= 0 ) then
			local numCaught = GetItemCount(CurrentContest.fishid);
			local hour,minute = GetGameTime();
			local minleft;
			local checkhour = CurrentContest.hour;
			local cname = CurrentContest.name;
			local line;
			local contestNow = false;
			if ( hour >= checkhour ) then
				if ( ContestIsOver ) then
					line = FBConstants.FATLADYSINGS;
				else
					line = FBConstants.TIMELEFT;
				end
				line = line..FBConstants.DASH.." |cff";
				line = line..Crayon:GetThresholdHexColor(numCaught/40);
				line = line..FBConstants.FISHCAUGHT.."|r";
				checkhour = checkhour + CurrentContest.dur;
				contestNow = true;
			else
				line = FBConstants.TIMETOGO;
			end
			minleft = (checkhour - hour)*60 - minute;
			if ( minleft >= 0 ) then
				if ( minleft < 10 ) then
					FishingExtravaganzaFrameText:SetTextColor(1.0, 0.1, 0.1);
				else
					FishingExtravaganzaFrameText:SetTextColor(0.1, 1.0, 0.1);
				end
				local mod = math.fmod;
				local fishname = CurrentContest.fishname;
				if ( not fishname ) then
					fishname = FBConstants.FISH;
				end
				line = string.format(line, cname, minleft/60, mod(minleft, 60), numCaught, CurrentContest.count, fishname);
				FishingExtravaganzaFrameText:SetText(line);
				local width = FishingExtravaganzaFrameText:GetWidth();
				self:SetWidth(width + 16);
			end
			-- listen for yells, etc.?
			FishingBuddy.Extravaganza.OnEvent(FishingExtravaganzaFrame, "ZONE_CHANGED_NEW_AREA");
			if ( IsContestZone() ) then
				UpdateTimer = UPDATETIME_SCHOOLS;
			else
				UpdateTimer = UPDATETIME_COUNTER;
			end
		end
	else
		HidePools();
		self:Hide();
	end
end

-- eventually, display what fish you caught here
FishingBuddy.Extravaganza.MiniMap_OnEnter = function(self)
end

FishingBuddy.Commands[FBConstants.TIMER] = {};
FishingBuddy.Commands[FBConstants.TIMER].help = FBConstants.TIMERRESET_HELP;
FishingBuddy.Commands[FBConstants.TIMER].func =
	function(what)
		if ( what == FBConstants.RESET ) then
			FishingExtravaganzaFrame:ClearAllPoints();
			FishingExtravaganzaFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		end
		return true;
	end;

if ( FishingBuddy.Debugging ) then
	local start = 0;
	-- debugging routines
	FishingBuddy.Extravaganza.Debug = function(day, hour, zone, continent)
		FishingBuddy.Debug("Contest debug: %q %q %s %s", FL:printable(continent), FL:printable(zone), FL:printable(day), FL:printable(hour));
		-- Contests[1].zone = zone;
		-- Contests[1].continent = continent;
		-- Contests[1].day = day;
		-- Contests[1].hour = hour;
		-- Contests[1].kind = nil;
		Contests[2].day = day;
		Contests[2].hour = hour;
		Contests[2].kind = nil;
		IsTime(true);
		ShowPools(true);
	end
	
	-- test the extravaganze school marking functions
	-- need to expand this for 1.9 if we can tell automatically
	FishingBuddy.Commands["mark"] = {};
	FishingBuddy.Commands["mark"].func =
		function(what, ...)
			if ( what == "reset" ) then
				FishingBuddy_Info["FishSchools"] = nil;
			elseif ( what == "debug" ) then
				local hour,_ = GetGameTime();
				local weekday, _, _, _ = CalendarGetDate();
				local zone,_ = FL:GetZoneInfo();
				local landmass = LT:GetContinent(zone);
				FishingBuddy.Extravaganza.Debug(weekday, hour, zone, landmass);
			elseif ( what == "test" ) then
				local C, Z, x, y = Astrolabe:GetCurrentPlayerPosition();
				local icon = GetFreePoolIcon();
				local facing = GetPlayerFacing();
				if ( facing ) then
					local zone,_ = FL:GetZoneInfo();
					local yx, yy = LT:GetZoneYardSize(zone);
					if ( yx ) then
						-- let's average the distance and say 15 yards
						x, y = x * yx, y * yy;
						x, y = x + math.sin(facing)*15, y + math.cos(facing)*15;
						-- put them back in non-yard adjusted format
						x, y = x / yx, y / yy;
					end
				end
				Astrolabe:PlaceIconOnMinimap( icon, C, Z, x, y );
			else
				FishingBuddy.Extravaganza.MarkSchool();
			end
			return true;
		end;
	
end
