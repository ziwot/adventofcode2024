local utils = require("utils")

local function bad_levels(v)
	local prev, order, curr_order, levels = nil, nil, nil, {}

	local function add_level(i)
		if i > 1 then
			if false == utils.tablecontains(levels, i - 1) then
				table.insert(levels, i - 1)
			end

			if i > 2 then
				if false == utils.tablecontains(levels, i - 2) then
					table.insert(levels, i - 2)
				end
			end
		end

		if false == utils.tablecontains(levels, i) then
			table.insert(levels, i)
		end

		if i < #v then
			if false == utils.tablecontains(levels, i + 1) then
				table.insert(levels, i + 1)
			end
		end
	end

	for i, vv in pairs(v) do
		local n = tonumber(vv)

		if prev ~= nil then
			if prev == n then
				add_level(i)
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
					add_level(i)
				else
					local distance = math.abs(prev - n)

					if distance < 1 or distance > 3 then
						add_level(i)
					end
				end
			end
		end

		prev = n
	end

	return levels
end

local function safe_report_filter(v)
	local bl = bad_levels(v)

	if #bl > 0 then
		return false
	end

	return true
end

local function dampener_safe_report_filter(v)
	local bl = bad_levels(v)

	if #bl > 0 then
		for _, i in pairs(bl) do
			local vv = {}
			for j, vvv in pairs(v) do
				if i ~= j then
					table.insert(vv, vvv)
				end
			end

			local bll = bad_levels(vv)
			if #bll == 0 then
				return true
			end
		end

		return false
	end

	return true
end

local data = utils.read_file_to_table(..., "%w+")
local safe = utils.filter_inplace(data, safe_report_filter)
local dampener_safe = utils.filter_inplace(data, dampener_safe_report_filter)
print(#safe, #dampener_safe)
