Player = Class{}

function Player:init(x, y)
	self.position = { x = x, y = y }
	self.dimensions = { width = 8, height = 18 }

	self.speed = .9
end

function Player:update(dx, dy)
	self.position.x = self.position.x + (dx * self.speed)
	self.position.y = self.position.y + (dy * self.speed)
end

function Player:draw()
	love.graphics.rectangle('fill', self.position.x, self.position.y, self.dimensions.width, self.dimensions.height)
end

function Player:drawDebug()
	-- DEBUG STUFF
end