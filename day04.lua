local inspect = require("inspect")
local utils = require("utils")

local t = utils.read_file_to_table(..., "%a")

-- inverse les index verticaux (lignes)
local grid = {}
for i, line in ipairs(t) do
	grid[(#t + 1) - i] = line
end

local directions = {
	-- Haut-gauche, Haut, Haut-droite
	{ -1, -1 },
	{ -1, 0 },
	{ -1, 1 },
	-- Gauche, Droite
	{ 0, -1 },
	{ 0, 1 },
	-- Bas-gauche, Bas, Bas-droite
	{ 1, -1 },
	{ 1, 0 },
	{ 1, 1 },
}

-- pt1.
local function count_words(g, w, start_row, start_col)
	if string.sub(w, 1, 1) ~= g[start_row][start_col] then
		return 0
	end

	local count = 0

	for _, dir in ipairs(directions) do
		local dx, dy = dir[1], dir[2]
		local current_row, current_col = start_row, start_col
		local valide = true

		for i = 2, #w do
			current_row = current_row + dx
			current_col = current_col + dy

			if current_row < 1 or current_row > #g or current_col < 1 or current_col > #g[1] then
				valide = false
				break
			end

			if string.sub(w, i, i) ~= g[current_row][current_col] then
				valide = false
				break
			end
		end

		if valide then
			count = count + 1
		end
	end

	return count
end

local nb = 0
for row, cols in ipairs(grid) do
	for col, char in ipairs(cols) do
		if char == "X" then
			nb = nb + count_words(grid, "XMAS", row, col)
		end
	end
end

print(nb)

-- pt. 2
directions = {
	{
		-- Haut-gauche
		{ -1, -1 },
		-- Bas-droite
		{ 1, 1 },
	},
	{
		-- Haut-droite
		{ -1, 1 },
		-- Bas-gauche
		{ 1, -1 },
	},
}

nb = 0
for row, cols in ipairs(grid) do
	for col, char in ipairs(cols) do
		if row > 1 and row < #grid and col > 1 and col < #grid[1] then
			if char == "A" then
				local nb_w = 0
				for _, dir in ipairs(directions) do
					local w = grid[row + dir[1][1]][col + dir[1][2]] .. "A" .. grid[row + dir[2][1]][col + dir[2][2]]
					if w == "MAS" or string.reverse(w) == "MAS" then
						nb_w = nb_w + 1
					end
				end
				if nb_w == 2 then
					nb = nb + 1
				end
			end
		end
	end
end

print(nb)
