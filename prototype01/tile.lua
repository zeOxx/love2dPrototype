Tile = Class{}

function Tile:init(width, height, type, texture, character)
	self.dimensions = { w = width, h = height }
	self.type = type or 0
	self.texture = texture
	self.character = character or ' '
end

function Tile:draw(x, y)
	-- DRAW
	love.graphics.draw(self.texture, (x - 1) * self.dimensions.w, (y - 1) * self.dimensions.h)
end