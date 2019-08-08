TileHelper = Class{}

function TileHelper:init()
	-- NADA
end

function TileHelper:getDevTileSet()
	local tileSetImage = love.graphics.newImage('assets/tilesets/dev/devTileSet.png')
	local tileSet = love.graphics.newSpriteBatch(tileSetImage, tileSetImage:getWidth() * tileSetImage:getHeight())

	return tileSet
end