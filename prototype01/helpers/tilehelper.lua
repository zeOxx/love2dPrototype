TileHelper = Class{}

function TileHelper:init()
	self:addDevTiles()

	self.tiles = {}
end

function TileHelper:addDevTiles()
	table.insert(self.tiles, Tile(16, 16, 0, love.graphics.newImage('assets/tiles/dev/dgray16x16.png'), '0'))
	table.insert(self.tiles, Tile(16, 16, 0, love.graphics.newImage('assets/tiles/dev/orange16x16.png'), '1'))
	table.insert(self.tiles, Tile(16, 16, 0, love.graphics.newImage('assets/tiles/dev/white16x16.png'), '2'))
end