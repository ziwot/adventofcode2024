local inspect = require("inspect")

local read_file = function(path)
	local file = io.open(path, "rb")
	if not file then
		return nil
	end

	local lines = {}

	for line in io.lines(path) do
		local words = {}
		for word in line:gmatch("%w+") do
			table.insert(words, word)
		end
		table.insert(lines, words)
	end

	file:close()
	return lines
end

local input = read_file("./day01_input.txt")

local left = {}
local right = {}

for _, v in ipairs(input) do
	print(v[2])
	table.insert(left, v[1])
	table.insert(right, v[2])
end

table.sort(left)
table.sort(right)

local distance_sum = 0

for i, v in ipairs(left) do
	distance_sum = distance_sum + math.abs(v - right[i])
end

print(distance_sum)
