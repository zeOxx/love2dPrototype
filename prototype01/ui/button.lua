Button = Class{}

function Button:init(x, y, width, height, text, func)
	self.position = { x = x or 0, y = y or 0 }
	self.dimensions = { w = width or 1, h = height or 1 }
end

function Button:update(dt)

end

function Button:draw()
	love.graphics.rectangle("line", self.position.x, self.position.y, self.dimensions.w, self.dimensions.h)
end