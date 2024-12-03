local inspect = require("inspect")
local utils = require("utils")

local input = utils.read_file("./day02.txt")

badLevels = function(v)
	local prev = nil
	local order = nil
	local currOrder = nil
	local indexes = {}

	for i, vv in ipairs(v) do
		local n = tonumber(vv)

		if prev ~= nil then
			if prev == n then
				table.insert(indexes, i)
				table.insert(indexes, i)
			elseif prev < n then
				currOrder = ">"
			else
				currOrder = "<"
			end

			if order == nil then
				order = currOrder
			end

			if order ~= currOrder then
				table.insert(indexes, i)
			end

			local distance = math.abs(prev - n)

			if distance < 1 or distance > 3 then
				table.insert(indexes, i)
			end
		end

		prev = n
	end

	return indexes
end

local safeReportFilterPt1 = function(v)
	local bl = badLevels(v)

	if #bl > 0 then
		return false
	end

	return true
end

-- fixme
local safeReportFilterPt2 = function(v)
	local bl = badLevels(v)

	if #bl > 0 then
		for _, i in ipairs(bl) do
			local vv = {}
			for j, vvv in ipairs(v) do
				if i ~= j then
					table.insert(vv, vvv)
				end
			end

			local stillBad = badLevels(vv)
			if #stillBad == 0 then
				return true
			else
				print(inspect(stillBad))
			end
		end

		return false
	end

	return true
end

-- pt 1.
-- local safe = utils.filter_inplace(input, safeReportFilterPt1)
local safe = utils.filter_inplace(input, safeReportFilterPt2)
print(#safe)
