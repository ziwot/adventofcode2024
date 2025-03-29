local inspect = require("inspect")
local utils = require("utils")

local function run_program(program)
	local result = 0
	for _, v in pairs(program) do
		for _, vv in pairs(v) do
			local x, y = string.match(vv, "mul%((%d+),(%d+)%)")
			result = result + (x * y)
		end
	end

	return result
end

-- pt 1.
-- print(run_program(utils.read_file_to_table(..., "mul%(%d+,%d+%)")))

-- pt 2.
local function debug_program(s)
	local result = {}
	local i = 1
	local len = #s

	local first_dont = s:find("don't%(%)")
	local first_do = s:find("do%(%)")

	if first_dont < first_do then
		table.insert(result, s:sub(1, first_dont - 1))
		i = first_dont
	else
		table.insert(result, s:sub(1, first_do - 1))
		i = first_do
	end

	while i <= len do
		local do_pos = s:find("do%(%)", i)
		local dont_pos = s:find("don't%(%)", i)

		if do_pos and (not dont_pos or do_pos < dont_pos) then
			local next_dont = s:find("don't%(%)", do_pos + 4)
			local segment_end = next_dont or (len + 1)
			table.insert(result, s:sub(do_pos + 4, segment_end - 1))
			i = segment_end
		elseif dont_pos then
			local next_do = s:find("do%(%)", dont_pos + 7)
			i = next_do or len + 1
		else
			table.insert(result, s:sub(i))
			break
		end
	end

	return table.concat(result)
end

local program = debug_program(utils.read_file_to_string(...))
local result = 0
for x, y in program:gmatch("mul%((%d+),(%d+)%)") do
	result = result + (x * y)
end

print(result)
