TileHelper = Class{}

function TileHelper:init()
	-- setting tileset names so paths are easy to get
	self.tileSets = {
		dev = { set = 'dev', name = 'devTileSet' }
	}
end

function TileHelper:getTileSet(tileSet)
	local tileSetImage = love.graphics.newImage('assets/tilesets/' .. tileSet.set .. '/' .. tileSet.name .. '.png')
	local tileSet = love.graphics.newSpriteBatch(tileSetImage, tileSetImage:getWidth() * tileSetImage:getHeight())

	return tileSet
end