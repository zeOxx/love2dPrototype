TileSet = Class{}

function TileSet:init(name)
	self.name = name
	self.tiles = {}
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