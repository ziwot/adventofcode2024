local utils = require("utils")

local data = utils.read_file_to_table(..., "%w+")

-- distance totale
-- retoune la somme des différence entre 2 element d'une table
local function total_distance(locations)
	local l, r = utils.split_locations(locations)

	table.sort(l)
	table.sort(r)

	local td = 0
	for i, v in pairs(l) do
		td = td + math.abs(v - r[i])
	end

	return td
end

-- score de similitude
local function similarity_score(locations)
	local l, r = utils.split_locations(locations)
	local score = 0

	for _, vl in pairs(l) do
		local count = 0
		for _, vr in pairs(r) do
			if vl == vr then
				count = count + 1
			end
		end
		score = score + (vl * count)
	end

	return score
end

print(total_distance(data))
print(similarity_score(data))
