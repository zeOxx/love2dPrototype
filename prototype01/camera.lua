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
	debugHelper:draw('cameraX: ' .. camera.position.x)
	debugHelper:draw('cameraY: ' .. camera.position.y)
end

function Camera:unset()
	push:finish()
end