-- Support for schools

local FL = LibStub("LibFishing-1.0");
local LT = LibStub("LibTourist-3.0");

FishingBuddy.Schools = {};

local SCHOOLS = {};
local CLOSEENOUGH = 15; -- fifteen yards

-- Let's store fishing holes like this
-- FishingBuddy_Info["Schools"][ZONE]
-- Store everything to two digits?

local function AddFishingSchool(kind, fishid, zidx, x, y)
	local entry = {};
	if ( not zidx ) then
		zidx, _ = FishingBuddy.GetZoneIndex();
	elseif ( type(zidx) == "string" ) then
		zidx = FishingBuddy.GetZoneIndex(zidx);
	end
	if ( not x or not y ) then
		x, y =  GetPlayerMapPosition("player");
	end

	-- Okay, the fishing hole is actually between 10 and 20 yards away
	-- roughly in the direction that we're pointing now
	-- since most people face the hole directly, it's a good bet anyway
	local facing = GetPlayerFacing();
	if ( facing ) then
		local zone = FishingBuddy_Info["ZoneIndex"][zidx];
		local yx, yy = LT:GetZoneYardSize(zone);
		if ( yx ) then
			facing = facing + math.pi;
			-- let's average the distance and say 15 yards
			x, y = x * yx, y * yy;
			x, y = x + math.sin(facing)*15, y + math.cos(facing)*15;
			-- put them back in non-yard adjusted format
			x, y = x / yx, y / yy;
		end
	end
	
	if ( not FishingBuddy_Info["FishSchools"] ) then
		FishingBuddy_Info["FishSchools"] = {};
	end
	if ( not FishingBuddy_Info["FishSchools"][zidx] ) then
		FishingBuddy_Info["FishSchools"][zidx] = {};
	else
		-- how do we find the same pool?
		local C, _, x1, y1 = FL:GetCurrentPlayerPosition();
		local Z = FishingBuddy.GetBaseZoneIndex(zidx);
		-- if we're in an instance, don't do math
		if ( C ) then
			for _,hole in pairs(FishingBuddy_Info["FishSchools"][zidx]) do
				local d,_,_ = LT:GetYardDistance(Z, x, y, Z, hole.x, hole.y);
FishingBuddy.Debug("d "..FL:printable(d).." "..CLOSEENOUGH);
				if ( d and d < CLOSEENOUGH ) then
					if ( fishid ) then
						if ( hole.count ) then
							hole.count = hole.count + 1;
						else
							hole.count = 1;
						end
						if ( hole.fish ) then
							for f,count in pairs(hole.fish) do
								if ( f == fishid ) then
									hole.fish[f] = count + 1;
									return;
								end
							end
						else
							hole.fish = {};
						end
						hole.fish[fishid] = 1;
					end
					return;
				end
			end
		end
	end
	entry.kind = kind;
	entry.x = x;
	entry.y = y;
	entry.count = 1;
	if ( fishid ) then
		entry.fish = {};
		entry.fish[fishid] = 1;
	end
	tinsert(FishingBuddy_Info["FishSchools"][zidx], entry);

	FishingBuddy.RunHandlers(FBConstants.ADD_SCHOOL_EVT, kind, fishid, zidx, x, y);

	return true;
end
FishingBuddy.Schools.AddFishingSchool = AddFishingSchool;

local function CheckFishingPool(text, fishid, poolhint)
	local info = FL:IsFishingPool(text);
	if ( poolhint or info ) then
		if ( not info ) then
			info = FL:IsFishingPool(FL.SCHOOL);
		end
		if ( AddFishingSchool(info.kind, fishid) and
			 FishingBuddy.GetSettingBool("ShowNewSchools") ) then
				local zone,_ = FL:GetZoneInfo();
				FishingBuddy.Print(FBConstants.ADDSCHOOLMSG, text, zone);
		end
	end
end

local function GetSchools(zidx)
	if ( type(zidx) == "string" ) then
		zidx = FishingBuddy.GetZoneIndex(zidx);
	end
	if ( FishingBuddy_Info["FishSchools"] and FishingBuddy_Info["FishSchools"][zidx] ) then
		return FishingBuddy_Info["FishSchools"][zidx];
	else
		return {};
	end
end
FishingBuddy.Schools.GetSchools = GetSchools;

local function CollapseHoles()
	if ( FishingBuddy_Info["FishSchools"] ) then
		local zonecopy = {};
		for zidx,holes in pairs(FishingBuddy_Info["FishSchools"]) do
			local copy = {};
			for _,hole in pairs(holes) do
				tinsert(copy, hole);
			end
			zonecopy[zidx] = copy;
		end
		for zidx,holes in pairs(zonecopy) do
			FishingBuddy_Info["FishSchools"][zidx] = nil;
			for _,hole in pairs(holes) do
				if ( hole.fish ) then
					for f,c in pairs(hole.fish) do
						for i in pairs(1,c) do
							AddFishingSchool(hole.kind, f, zidx, hole.x, hole.y);
						end
					end
				else
					AddFishingSchool(hole.kind, nil, zidx, hole.x, hole.y);
				end
			end
		end
	end
end
FishingBuddy.Schools.CollapseHoles = CollapseHoles;

local SchoolEvents = {};
SchoolEvents[FBConstants.ADD_FISHIE_EVT] = function(id, name, zone, subzone, texture, quantity, quality, level, idx, poolhint)
	local text = FishingBuddy.LastTooltipText();
	CheckFishingPool(text, id, poolhint);
end

FishingBuddy.API.RegisterHandlers(SchoolEvents);
