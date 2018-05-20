push = require 'libs/push'

Camera = Class{}

function Camera:init(x, y)
	self.position = { x = x, y = y }
end

function Camera:update(x, y)
	self.position.x = x or player.position.x
	self.position.y = y or player.position.y

end

function Camera:move(dx, dy)
	self.position.x = self.position.x + dx
	self.position.y = self.position.y + dy
end

function Camera:set()
	push:start()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.translate(-self.position.x, -self.position.y)
end

function Camera:drawDebug()
	debugHelper:drawText('-CAMERA-')
	debugHelper:drawText('x: ' .. self.position.x)
	debugHelper:drawText('y: ' .. self.position.y)
end

function Camera:unset()
	push:finish()
end