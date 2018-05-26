Map = Class{}

function Map:init()
	-- STUFF AND THINGS
	self.tileMap = {}
	self.tileSet = nil
end

function Map:loadMap(mapname, tileSet)
	-- RESET VALUES FOR PREVIOUSLY LOADED MAP
	mapname = mapname or "devmap"
	self.tileSet = tileSet

	for line in love.filesystem.lines("maps/" .. mapname .. ".txt") do
		table.insert(self.tileMap, line)
	end
end

function Map:draw(x, y)
	for i = 1, #self.tileMap do
		for j = 1, #self.tileMap[i] do
			if string.sub(self.tileMap[i], j, j) ~= '-' then
				local tile = self.tileSet:getTileWithCharacter(string.sub(self.tileMap[i], j, j))
				tile:draw(j + x, i + y)
			end
		end
	end
end