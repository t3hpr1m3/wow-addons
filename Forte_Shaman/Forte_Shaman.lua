-- ForteXorcist v1.975.7 by Xus 26-08-2011 for 4.2.0

if FW.CLASS == "SHAMAN" then
	local FW = FW;
	local FWL = FW.L;
	local SH = FW:ClassModule("Shaman");
	
	local CA = FW.Modules.Casting;
	local ST = FW.Modules.Timer;
	local CD = FW.Modules.Cooldown;
	
	-- Register ID renames first!
	FW:RegisterCustomName(71220,FWL.ENERGIZED_RELIC);
	
	if ST then
		--
		-- Spells
		-- spell, hastarget, duration, isdot, istype, reducedinpvp, texture, stacks
		-- istype: ST.DEFAULT	ST.SHARED ST.UNIQUE	ST.PET ST.POWERUP ST.CHARM ST.DEBUFF ST.DRAIN ST.HEAL ST.BUFF
		
		ST:RegisterChannel(61882, 0, 1); -- Earthquake		
		
		-- Elemental Spells
		ST:RegisterSpell(8050,	1,021,1,ST.DEFAULT) -- Flame Shock
			ST:RegisterSpellModGlph(8050, 55447, 009); -- Glyph of Flame Shock
		ST:RegisterSpell(8056,	1,008,0,ST.DEFAULT); -- Frost Shock
			ST:RegisterSpellModGlph(8056, 55443, 002); -- Glyph of Frost Shock
		-- Enhancement Spells
		ST:RegisterSpell(51533,	0, 30,0,ST.PET); -- Feral Spirit
		ST:RegisterSpell(17364, 1, 12,0,ST.DEFAULT); -- Stormstrike
		-- Restoration Spells
		ST:RegisterSpell(16177, 1,015,0,ST.BUFF); -- Ancestral Fortitude
		ST:RegisterSpell(974, 1,600,0,ST.BUFF); -- Earth Shield
		ST:RegisterSpell(51945, 1,012,0,ST.HEAL); -- Earthliving
		ST:RegisterSpell(29206, 1,015,0,ST.BUFF); -- Healing Way
		ST:RegisterSpell(61295, 1,012,0,ST.HEAL); -- Riptide
			
		ST:RegisterCooldown(51505,008); -- Lava Burst
		ST:RegisterCooldown(51490,045); -- Thunderstorm
		ST:RegisterCooldown(421,006); -- Chain Lightning
			ST:RegisterCooldownModTlnt(421,51483,1,-0.75);
			ST:RegisterCooldownModTlnt(421,51483,2,-1.50);
			ST:RegisterCooldownModTlnt(421,51483,3,-2.50);

		--[[
		for like tremor totem, and the cleansing totem
		magma totem too
		]]
		
		ST:RegisterTickSpeed(8190,2); -- Magma Totem
		--ST:RegisterTickSpeed(58582,2); -- Stoneclaw Totem
		
		--ST:RegisterTickSpeed( 8143,3); -- Tremor Totem
		
		--
		-- Buffs
		-- buffnam
		--
		ST:RegisterBuff(58060); -- Glyph of Renewed Life

		-- Elemental
		ST:RegisterBuff(30165); -- Elemental Devastation
		ST:RegisterBuff(324); -- Lightning Shield
		ST:RegisterBuff(64701); -- Elemental Mastery
		ST:RegisterBuff(16246); -- Clearcasting

		-- Enhancement
		ST:RegisterBuff(53817); -- Maelstrom Weapon
		ST:RegisterBuff(30824); -- Shamanistic Rage
		ST:RegisterBuff(30802); -- Unleashed Rage

		-- Restoration
		ST:RegisterBuff(53390); -- Tidal Waves
		ST:RegisterBuff(52128); -- Water Shield
		
		-- Relics
		ST:RegisterBuff(71220); -- Energized Item - Shaman T10 Restoration Relic (Riptide)

		-- Code to track totems
		local select = select;
		local strfind = strfind;
		local function SH_TotemUpdate(event,index)
			-- Fire = 1 Earth = 2 Water = 3 Air = 4
			local _, name, startTime, duration, icon = GetTotemInfo(index);
			local flag = ST.LAST_TIMER_FLAG+index;
			local i = ST.ST:find(flag,6);
			if i then
				if name ~= "" then
					ST.ST:remove(i);
				else
					if ST.ST[i][1]-GetTime()<0.75 then
						ST:Fade(i,2);
					else
						ST:Fade(i,3);
					end
				end
			end
			if name ~= "" then
				ST:RegisterManualSpellOfFlag(name,flag);
				ST.ST:insert(startTime+duration,0,duration,name,0,flag,icon,name,2,0,"none",0,ST.PRIOR_NONE,0,1,0,0,00000,0,startTime+duration,duration,1.0,0);
			end
		end
		FW:RegisterToEvent("PLAYER_TOTEM_UPDATE", SH_TotemUpdate);
		
		ST:AddTimerFlag("TotemFireColor");
		ST:AddTimerFlag("TotemEarthColor");
		ST:AddTimerFlag("TotemWaterColor");
		ST:AddTimerFlag("TotemAirColor");
		
		FW:RegisterDelayedLoadEvent(function(self)
			for i=1,4,1 do
				SH_TotemUpdate(self,i);
			end
		end);
		
		ST:RegisterCasterBuffs();
		ST:RegisterMeleeBuffs();
		
		FW:SetMainCategory(FWL.SPELL_TIMER);
			FW:SetSubCategory(FWL.MY_SPELLS);
				FW:RegisterOption(FW.CO2,1,FW.NON,FWL.TOTEM_FIRE,			"",	"TotemFireColor",	ST.FilterChange);	
				FW:RegisterOption(FW.CO2,1,FW.NON,FWL.TOTEM_EARTH,			"",	"TotemEarthColor",	ST.FilterChange);	
				FW:RegisterOption(FW.CO2,1,FW.NON,FWL.TOTEM_WATER,			"",	"TotemWaterColor",	ST.FilterChange);	
				FW:RegisterOption(FW.CO2,1,FW.NON,FWL.TOTEM_AIR,			"",	"TotemAirColor",	ST.FilterChange);	
		
		FW.InstanceDefault.Timer.TotemFireColor = 	{[0]=true,1.00,0.37,0.00};
		FW.InstanceDefault.Timer.TotemEarthColor = 	{[0]=true,1.00,0.56,0.00};
		FW.InstanceDefault.Timer.TotemWaterColor = 	{[0]=true,0.00,1.00,0.67};
		FW.InstanceDefault.Timer.TotemAirColor = 	{[0]=true,0.00,1.00,1.00};
	end

	if CD then
		CD:RegisterCasterPowerupCooldowns();
		CD:RegisterMeleePowerupCooldowns();
	end
end