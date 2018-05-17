Player = Class{}

function Player:init(x, y)
	self.position = { x = x, y = y }
	self.dimensions = { width = 8, height = 18 }

	self.speed = .9
	self.walking = false
	self.walkSpeed = .5
end

function Player:update(dx, dy)
	if self.walking then
		self.position.x = self.position.x + (dx * self.walkSpeed)
		self.position.y = self.position.y + (dy * self.walkSpeed)
	else
		self.position.x = self.position.x + (dx * self.speed)
		self.position.y = self.position.y + (dy * self.speed)
	end
end

function Player:draw()
	love.graphics.rectangle('fill', self.position.x, self.position.y, self.dimensions.width, self.dimensions.height)
end

function Player:drawDebug()
	debugHelper:draw('playerX: ' .. player.position.x)
	debugHelper:draw('playerY: ' .. player.position.y)
	debugHelper:draw('walking: ' .. tostring(player.walking))
end