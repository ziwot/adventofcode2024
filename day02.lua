local inspect = require("inspect")
local utils = require("utils")

local input = utils.read_file("./day02.txt")

-- just filter out from input..
-- for i, v in ipairs(input) do
--
-- end

local safe = utils.filter_inplace(input, function(v, k)
	local prev = nil
	local order = nil
	local currOrder = nil

	for _, vv in ipairs(v) do
		if prev ~= nil then
			if prev == vv then
				print(k)
				return false
			elseif prev < vv then
				currOrder = ">"
			else
				currOrder = "<"
			end

			if order == nil then
				order = currOrder
			end

			if order ~= currOrder then
				print(k)
				return false
			end

			local distance = math.abs(prev - vv)

			if distance < 1 or distance > 3 then
				print(k)
				return false
			end
		end

		prev = vv
	end

	return true
end)

print(#safe)
