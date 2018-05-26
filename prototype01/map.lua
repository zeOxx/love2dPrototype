Map = Class{}

function Map:init()
	-- STUFF AND THINGS
	self.tileMap = {}
	self.tileDataMap = {}
	self.tileSet = nil
	self.playerSpawn = { x = 0, y = 0 }
end

function Map:loadMap(mapname, tileSet)
	-- RESET VALUES FOR PREVIOUSLY LOADED MAP
	mapname = mapname or "devmap"
	self.tileSet = tileSet

	for line in love.filesystem.lines('maps/' .. mapname .. '.txt') do
		table.insert(self.tileMap, line)
	end

	for line in love.filesystem.lines('maps/' .. mapname .. '.dat') do
		table.insert(self.tileDataMap, line)
	end

	-- Check if the map files have the same length, and print an error if not
	if #self.tileMap ~= #self.tileDataMap then
		print('ERROR: FILES FOR ' .. mapname .. ' DO NOT HAVE THE SAME LENGTH')
	end

	self:setPlayerSpawn()
end

function Map:setPlayerSpawn()
	for i = 1, #self.tileDataMap do
		for j = 1, #self.tileDataMap[i] do
			local character = string.sub(self.tileDataMap[i], j, j)

			if character ~= '-' then
				if character == 'S' then
					self.playerSpawn.x, self.playerSpawn.y = j * self.tileSet.dimensions, i * self.tileSet.dimensions
				end
			end
		end
	end

	print('playerSpawn:  x-' .. self.playerSpawn.x .. ', y-' .. self.playerSpawn.y)
end

function Map:draw()
	for i = 1, #self.tileMap do
		for j = 1, #self.tileMap[i] do
			local character = string.sub(self.tileMap[i], j, j)

			if character ~= '-' then
				local tile = self.tileSet:getTileWithCharacter(character)
				tile:draw(j, i)
			end
		end
	end
end