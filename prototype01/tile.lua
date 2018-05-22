Tile = Class{}

function Tile:init(width, height, type, texture, character)
	self.dimensions = { width = width, height = height }
	self.type = type or 0
	self.texture = texture
	self.character = character or ' '
end

function Tile:draw()
	-- DRAW
end