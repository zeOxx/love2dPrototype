Player = Class{}

function Player:init(x, y)
	self.position = { x = x, y = y }
	self.dimensions = { width = 8, height = 18 }

	self.speed = .9
	self.walking = false
	self.walkSpeed = .5
end

function Player:getScreenPosition()
	return { x = self.position.x + camera.position.x + (self.dimensions.width / 2), y = self.position.y + camera.position.y + (self.dimensions.height / 2) }
end

function Player:update(dx, dy)
	if self.walking then
		self.position.x = self.position.x + (dx * self.walkSpeed)
		self.position.y = self.position.y + (dy * self.walkSpeed)
		mouse:updatePositionFromPlayerMovement(dx * self.walkSpeed, dy * self.walkSpeed)
	else
		self.position.x = self.position.x + (dx * self.speed)
		self.position.y = self.position.y + (dy * self.speed)
		mouse:updatePositionFromPlayerMovement(dx * self.speed, dy * self.speed)
	end
end

function Player:draw()
	love.graphics.rectangle('fill', self.position.x, self.position.y, self.dimensions.width, self.dimensions.height)
end

function Player:drawDebug()
	debugHelper:drawText('playerX: ' .. self.position.x)
	debugHelper:drawText('playerY: ' .. self.position.y)
	debugHelper:drawText('walking: ' .. tostring(self.walking))
end