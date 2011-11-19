






-- GetSellValue support


do

	local function VendorCost(itemID)
		local value = GetSellValue(itemID)

		if value then
			return value * 4
		end
	end


	local function VendorValue(itemID)
		local value = GetSellValue(itemID)

		if value then
			return value
		end
	end


	local function Init()
		LSW.vendorValue = VendorValue
		LSW.vendorCost = VendorCost
	end


	local function Test(index)
		if GetSellValue then
			return true
		end

		return false
	end

	LSW:RegisterPricingSupport("GetSellValue", Test, Init)
end



