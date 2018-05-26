TileSet = Class{}

function TileSet:init(name, dimensions)
	self.name = name
	self.tiles = {}
	self.dimensions = dimensions or 16
end

function TileSet:getTileWithCharacter(character)
	local localTile = nil

	for i = 1, #self.tiles do
		if self.tiles[i].character == character then
			localTile = self.tiles[i]
			break
		end
	end

	return localTile
end