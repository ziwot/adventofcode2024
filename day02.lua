local inspect = require("inspect")
local utils = require("utils")

local input = utils.read_file("./day02.txt")

local safeReportFilter = function(v)
	local prev = nil
	local order = nil
	local currOrder = nil

	for _, vv in ipairs(v) do
		local n = tonumber(vv)

		if prev ~= nil then
			if prev == n then
				return false
			elseif prev < n then
				currOrder = ">"
			else
				currOrder = "<"
			end

			if order == nil then
				order = currOrder
			end

			if order ~= currOrder then
				return false
			end

			local distance = math.abs(prev - n)

			if distance < 1 or distance > 3 then
				return false
			end
		end

		prev = n
	end

	return true
end

-- pt 1.
local safe = utils.filter_inplace(input, safeReportFilter)
print(#safe)
