push = require 'libs/push'

Camera = Class{}

function Camera:init(x, y)
	self.position = { x = x, y = y }
end

function Camera:set()
	push:start()
	love.graphics.translate(self.position.x, self.position.y)
end

function Camera:drawDebug()
	love.graphics.print('cameraX: ' .. self.position.x or 0, 100, 120)
	love.graphics.print('cameraY: ' .. self.position.y or 0, 100, 130)
end

function Camera:unset()
	push:finish()
end