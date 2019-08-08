Map = Class{}

function Map:init()
	-- STUFF AND THINGS
	self.tileMap = {}
	self.tileDataMap = {}
	self.tileCollisionMapData = {}
	self.tileCollisionMap = {}
	self.tileSet = nil
	self.playerSpawn = { x = 0, y = 0 }
end

function Map:loadMap(mapname, tileSet, w, h)
	-- RESET VALUES FOR PREVIOUSLY LOADED MAP
	mapname = mapname or "devmap"
	self.tileSet = tileSet
	self.tileMap = {}
	self.tileWidth = w or 16
	self.tileHeight = h or 16
	self.tileDataMap = {}
	self.tileCollisionMapData = {}
	self.tileCollisionMap = {}
	self.playerSpawn = { x = 0, y = 0 }

	-- read actual tile map (sprites)
	for line in love.filesystem.lines('maps/' .. mapname .. '.txt') do
		table.insert(self.tileMap, line)
	end

	-- insert quads to spritebatch
	for i = 1, #self.tileMap do
		for j = 1, #self.tileMap[i] do
			local character = string.sub(self.tileMap[i], j, j)
			-- checking for valid character
			if character ~= '-' then
				-- 0 is temp here, need to find a better way to do this
				self.tileSet:add(love.graphics.newQuad(16 * tonumber(character), 0, self.tileWidth, self.tileHeight, self.tileSet:getTexture():getDimensions()), 16 * (j - 1), 16 * (i - 1))
			end
		end
	end

	-- read prop data
	for line in love.filesystem.lines('maps/' .. mapname .. '.dat') do
		table.insert(self.tileDataMap, line)
	end

	-- read collision data
	for line in love.filesystem.lines('maps/' .. mapname .. '.col') do
		table.insert(self.tileCollisionMapData, line)
	end

	self:buildCollisionMap(mapname)

	-- Check if the map files have the same length, and print an error if not
	if #self.tileMap ~= #self.tileDataMap or #self.tileMap ~= #self.tileCollisionMapData then
		print('ERROR: FILES FOR ' .. mapname .. ' DO NOT HAVE THE SAME LENGTH')
	end

	self:setPlayerSpawn()
end

function Map:buildCollisionMap(mapname)
	-- throw error if no collision map exists.
	mapname = mapname or "NOMAPNAME"
	if #self.tileCollisionMapData == 0 then
		print('ERROR: NO COLLISION MAP PRESENT FOR ' .. mapname)
	end

	-- build the collision boxes
	for i = 1, #self.tileCollisionMapData do
		for j = 1, #self.tileCollisionMapData[i] do
			local character = string.sub(self.tileCollisionMapData[i], j, j)
			-- checking for valid character
			if character == 'C' then
				table.insert(self.tileCollisionMap, { x = (j - 1) * 16, y = (i - 1) * 16 })
			end
		end
	end

	print(#self.tileCollisionMap)
end

function Map:setPlayerSpawn()
	for i = 1, #self.tileDataMap do
		for j = 1, #self.tileDataMap[i] do
			local character = string.sub(self.tileDataMap[i], j, j)
			-- checking for valid character
			if character ~= '-' then
				-- player start
				if character == 'S' then
					self.playerSpawn.x, self.playerSpawn.y = j * 16, i * 16
				end
			end
		end
	end

	print('playerSpawn:  x-' .. self.playerSpawn.x .. ', y-' .. self.playerSpawn.y)
end

function Map:draw()
	love.graphics.draw(self.tileSet)

	if DEBUG then
		self:drawDebug()
	end
end

function Map:drawDebug()
	love.graphics.setColor(0, 1, 0, 1)
	for i = 1, #self.tileCollisionMap do
		local col = self.tileCollisionMap[i]
		love.graphics.rectangle("line", col.x, col.y, 16, 16 )
	end
	love.graphics.setColor(1, 1, 1, 1)
end