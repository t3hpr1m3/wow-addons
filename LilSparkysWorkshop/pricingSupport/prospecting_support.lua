


-- prospecting support




local enabled = true


do
-- results : [ore][gem] = numProspected
	local prospectingResults = {
		[52183] = { --Pyrite Ore						early results averaged per type (common/rare)
			[52327] = 2, --Volatile Earth
			[52178] = 0.167, --Zephyrite
			[52182] = 0.167, --Jasper
			[52177] = 0.167, --Carnelian
			[52179] = 0.167, --Alicite
			[52181] = 0.167, --Hessonite
			[52180] = 0.167, --Nightstone
			[52193] = 0.075, --Ember Topaz
			[52194] = 0.075, --Demoneye
			[52195] = 0.075, --Amberjewel
			[52192] = 0.075, --Dream Emerald
			[52190] = 0.075, --Inferno Ruby
			[52191] = 0.075, --Ocean Sapphire
		},
		[52185] = { --Elementium Ore					early results averaged per type
			[52178] = 0.18, --Zephyrite
			[52182] = 0.18, --Jasper
			[52177] = 0.18, --Carnelian
			[52179] = 0.18, --Alicite
			[52181] = 0.18, --Hessonite
			[52180] = 0.18, --Nightstone
			[52193] = 0.045, --Ember Topaz
			[52194] = 0.045, --Demoneye
			[52195] = 0.045, --Amberjewel
			[52192] = 0.045, --Dream Emerald
			[52190] = 0.045, --Inferno Ruby
			[52191] = 0.045, --Ocean Sapphire
		},
		[53038] = { --Obsidium Ore					early results averaged per type
			[52178] = 0.235, --Zephyrite
			[52182] = 0.235, --Jasper
			[52177] = 0.235, --Carnelian
			[52179] = 0.235, --Alicite
			[52181] = 0.235, --Hessonite
			[52180] = 0.235, --Nightstone
			[52193] = 0.012, --Ember Topaz
			[52194] = 0.012, --Demoneye
			[52195] = 0.012, --Amberjewel
			[52192] = 0.012, --Dream Emerald
			[52190] = 0.012, --Inferno Ruby
			[52191] = 0.012, --Ocean Sapphire
		},

		[36912] = { --Saronite Ore
			[36929] = 0.275, --Huge Citrine
			[36930] = 0.062, --Monarch Topaz
			[36923] = 0.275, --Chalcedony
			[36924] = 0.062, --Sky Sapphire
			[36932] = 0.275, --Dark Jade
			[36918] = 0.062, --Scarlet Ruby
			[36926] = 0.275, --Shadow Crystal
			[36927] = 0.06, --Twilight Opal
			[36920] = 0.27, --Sun Crystal
			[36933] = 0.06, --Forest Emerald
			[36921] = 0.06, --Autumn\'s Glow
			[36917] = 0.27, --Bloodstone
		},
		[23424] = { --Fel Iron Ore
			[23441] = 0.012, --Nightseye
			[23438] = 0.012, --Star of Elune
			[23112] = 0.27, --Golden Draenite
			[23439] = 0.012, --Noble Topaz
			[23437] = 0.012, --Talasite
			[23117] = 0.26, --Azure Moonstone
			[23436] = 0.012, --Living Ruby
			[23440] = 0.012, --Dawnstone
			[21929] = 0.27, --Flame Spessarite
			[23079] = 0.27, --Deep Peridot
			[23077] = 0.265, --Blood Garnet
			[23107] = 0.265, --Shadow Draenite
		},
		[2771] = { --Tin Ore
			[3864] = 0.034, --Citrine
			[1210] = 0.575, --Shadowgem
			[1529] = 0.032, --Jade
			[7909] = 0.032, --Aquamarine
			[1705] = 0.58, --Lesser Moonstone
			[1206] = 0.585, --Moss Agate
		},
		[23425] = { --Adamantite Ore
			[23441] = 0.034, --Nightseye
			[23438] = 0.034, --Star of Elune
			[23112] = 0.275, --Golden Draenite
			[23439] = 0.036, --Noble Topaz
			[23079] = 0.275, --Deep Peridot
			[23437] = 0.036, --Talasite
			[23117] = 0.27, --Azure Moonstone
			[23436] = 0.034, --Living Ruby
			[23440] = 0.034, --Dawnstone
			[21929] = 0.28, --Flame Spessarite
			[24243] = 1, --nil
			[23077] = 0.275, --Blood Garnet
			[23107] = 0.27, --Shadow Draenite
		},
		[2770] = { --Copper Ore
			[818] = 0.5, --Tigerseye
			[1210] = 0.1, --Shadowgem
			[774] = 0.5, --Malachite
		},
		[36909] = { --Cobalt Ore
			[36929] = 0.375, --Huge Citrine
			[36930] = 0.012, --Monarch Topaz
			[36923] = 0.375, --Chalcedony
			[36924] = 0.012, --Sky Sapphire
			[36932] = 0.375, --Dark Jade
			[36918] = 0.014, --Scarlet Ruby
			[36926] = 0.37, --Shadow Crystal
			[36927] = 0.012, --Twilight Opal
			[36920] = 0.37, --Sun Crystal
			[36917] = 0.365, --Bloodstone
			[36921] = 0.012, --Autumn\'s Glow
			[36933] = 0.012, --Forest Emerald
		},
		[36910] = { --Titanium Ore
			[36917] = 0.37, --Bloodstone
			[36918] = 0.064, --Scarlet Ruby
			[36919] = 0.064, --nil
			[36920] = 0.355, --Sun Crystal
			[36921] = 0.06, --Autumn\'s Glow
			[36922] = 0.064, --nil
			[36923] = 0.365, --Chalcedony
			[36924] = 0.062, --Sky Sapphire
			[36925] = 0.064, --nil
			[36926] = 0.365, --Shadow Crystal
			[36927] = 0.062, --Twilight Opal
			[36928] = 0.066, --nil
			[46849] = 0.875, --nil
			[36930] = 0.064, --Monarch Topaz
			[36931] = 0.07, --nil
			[36932] = 0.37, --Dark Jade
			[36933] = 0.06, --Forest Emerald
			[36934] = 0.068, --nil
			[36929] = 0.37, --Huge Citrine
		},
		[3858] = { --Mithril Ore
			[12364] = 0.024, --Huge Emerald
			[12361] = 0.024, --Blue Sapphire
			[3864] = 0.52, --Citrine
			[12800] = 0.024, --Azerothian Diamond
			[7909] = 0.525, --Aquamarine
			[7910] = 0.53, --Star Ruby
			[12799] = 0.026, --Large Opal
		},
		[10620] = { --Thorium Ore
			[12799] = 0.4, --Large Opal
			[23112] = 0.002, --Golden Draenite
			[23079] = 0.002, --Deep Peridot
			[12361] = 0.39, --Blue Sapphire
			[23117] = 0.002, --Azure Moonstone
			[12800] = 0.39, --Azerothian Diamond
			[23077] = 0.002, --Blood Garnet
			[21929] = 0.002, --Flame Spessarite
			[12364] = 0.395, --Huge Emerald
			[23107] = 0.002, --Shadow Draenite
			[7910] = 0.3, --Star Ruby
		},
		[2772] = { --Iron Ore
			[3864] = 0.525, --Citrine
			[1529] = 0.535, --Jade
			[7909] = 0.05, --Aquamarine
			[1705] = 0.525, --Lesser Moonstone
			[7910] = 0.05, --Star Ruby
		},
	}


	local prospectingLevels = {
		[52183] = 500, --Pyrite Ore
		[52185] = 475, --Elementium Ore
		[53038] = 425, --Obsidium Ore
		[36912] = 400, --Saronite Ore
		[36909] = 350, --Cobalt Ore
		[23425] = 325, --Adamantite Ore
		[23424] = 275, --Fel Iron Ore
		[10620] = 250, --Thorium Ore
		[3858] = 175, --Mithril Ore
		[2772] = 125, -- Iron Ore
		[2771] = 50, --Tin Ore
		[2770] = 20, --Copper Ore
	}


	local prospectingLevels = {
		[52183] = { "playerProspectLevel", 500}, --Pyrite Ore
		[52185] = { "playerProspectLevel", 475}, --Elementium Ore
		[53038] = { "playerProspectLevel", 425}, --Obsidium Ore
		[36912] = { "playerProspectLevel", 400}, --Saronite Ore
		[36909] = { "playerProspectLevel", 350}, --Cobalt Ore
		[23425] = { "playerProspectLevel", 325}, --Adamantite Ore
		[23424] = { "playerProspectLevel", 275}, --Fel Iron Ore
		[10620] = { "playerProspectLevel", 250}, --Thorium Ore
		[3858] = { "playerProspectLevel", 175}, --Mithril Ore
		[2772] = { "playerProspectLevel", 125}, -- Iron Ore
		[2771] = { "playerProspectLevel", 50}, --Tin Ore
		[2770] = { "playerProspectLevel", 20}, --Copper Ore
	}


	-- spoof recipes for prospected ores -> gems
	local function AddToRecipeCache()
		for oreID, gemTable in pairs(prospectingResults) do
			local reagentTable = {}
			local recipeName = "Prospect "..(GetItemInfo(oreID) or "item:"..oreID)

			reagentTable[oreID] = 5

			LSW:AddRecipe(-oreID, recipeName, gemTable, reagentTable, prospectingLevels[oreID])
		end
	end

	local function Init()
--		LSW:ChatMessage("LilSparky's Workshop adding native Prospecting support")

		AddToRecipeCache()
	end


	local function Test(index)
		if enabled then
			return true
		end

		return false
	end

	LSW:RegisterPricingSupport("Prospecting", Test, Init)
end


