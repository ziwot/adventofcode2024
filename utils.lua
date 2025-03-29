local m = {}

-- lit un fichier et retourne son contenu
m.read_file = function(path)
	local f = assert(io.open(path, "rb"))
	local content = assert(f:read("*a"))
	f:close()

	return content
end

-- lit un fichier et retourne une table correspondante
-- selon le pattern passé
m.read_file_to_table = function(path, pattern)
	assert(io.open(path, "rb"))
	local t = {}

	for l in io.lines(path) do
		local items = {}
		for item in l:gmatch(pattern) do
			table.insert(items, item)
		end
		table.insert(t, items)
	end

	return t
end

-- lit un fichier et retourne une string
m.read_file_to_string = function(path)
	assert(io.open(path, "rb"))
	local s = ""

	for l in io.lines(path) do
		s = s .. l
	end

	return s
end

-- split les lignes de la table des locations
-- retourne les 2 tables obtenues
m.split_locations = function(t)
	local l = {}
	local r = {}

	for _, v in ipairs(t) do
		table.insert(l, v[1])
		table.insert(r, v[2])
	end

	return l, r
end

m.filter_inplace = function(t, filterIter)
	local out = {}

	for k, v in pairs(t) do
		if filterIter(v, k, t) then
			table.insert(out, v)
		end
	end

	return out
end

m.tablecontains = function(t, v)
	if next(t) == nil then
		return false
	else
		for i = 1, #t do
			if t[i] == v then
				return true
			end
		end
		return false
	end
end
return m
