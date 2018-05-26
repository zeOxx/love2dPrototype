TileHelper = Class{}

function TileHelper:init()
	self.tileSets = {}

	self:addDevTileSet()
end

function TileHelper:addDevTileSet()
	local devSet = TileSet('dev')

	table.insert(devSet.tiles, Tile(16, 16, 0, love.graphics.newImage('assets/tiles/dev/dgray16x16.png'), '0'))
	table.insert(devSet.tiles, Tile(16, 16, 0, love.graphics.newImage('assets/tiles/dev/orange16x16.png'), '1'))
	table.insert(devSet.tiles, Tile(16, 16, 0, love.graphics.newImage('assets/tiles/dev/white16x16.png'), '2'))

	table.insert(self.tileSets, devSet)
end

function TileHelper:addTileSet()

end

function TileHelper:getDevTileSet()
	return self.tileSets[1]
end