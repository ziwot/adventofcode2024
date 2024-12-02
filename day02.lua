local inspect = require("inspect")
local utils = require("utils")

local input = utils.read_file("./day02.txt")

local safe = {}

for _, v in ipairs(input) do
	local prev = nil
	for _, vv in ipairs(v) do
		if prev ~= nil then
			print(prev, vv)
		end
		prev = vv
	end
end

-- print(inspect(input))
