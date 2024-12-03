local inspect = require("inspect")
local utils = require("utils")

local input = utils.read_file("./day02.txt")

local bad_levels = function(v)
	local prev = nil
	local order = nil
	local curr_order = nil
	local levels = {}

	local add_level = function(t, i)
		if i > 1 then
			if false == utils.tablecontains(t, i - 1) then
				table.insert(t, i - 1)
			end
			if i > 2 then
				if false == utils.tablecontains(t, i - 2) then
					table.insert(t, i - 2)
				end
			end
		end
		if false == utils.tablecontains(t, i) then
			table.insert(t, i)
		end
		if i < #v then
			if false == utils.tablecontains(t, i + 1) then
				table.insert(t, i + 1)
			end
		end
	end

	for i, vv in ipairs(v) do
		local n = tonumber(vv)

		if prev ~= nil then
			if prev == n then
				add_level(levels, i)
			else
				if prev < n then
					curr_order = ">"
				else
					curr_order = "<"
				end

				if order == nil then
					order = curr_order
				end

				if order ~= curr_order then
					add_level(levels, i)
				else
					local distance = math.abs(prev - n)

					if distance < 1 or distance > 3 then
						add_level(levels, i)
					end
				end
			end
		end

		prev = n
	end

	return levels
end

local safe_report_filter = function(v)
	local bl = bad_levels(v)

	if #bl > 0 then
		return false
	end

	return true
end

local dampener_safe_report_filter = function(v)
	local bl = bad_levels(v)

	if #bl > 0 then
		for _, i in ipairs(bl) do
			local vv = {}
			for j, vvv in ipairs(v) do
				if i ~= j then
					table.insert(vv, vvv)
				end
			end

			local bll = bad_levels(vv)
			if #bll == 0 then
				return true
			end
		end

		print(inspect(v), inspect(bl))

		return false
	end

	return true
end

-- pt 1.
local safe = utils.filter_inplace(input, safe_report_filter)
local dampener_safe = utils.filter_inplace(input, dampener_safe_report_filter)
print(#safe, #dampener_safe)
