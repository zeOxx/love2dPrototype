push = require 'libs/push'

Camera = Class{}

function Camera:init(x, y)
	self.position = { x = x, y = y }
end

function Camera:update()
	self.position.x = player.position.x-- + (VIRTUAL_WIDTH / 2)
	self.position.y = player.position.y-- + (VIRTUAL_HEIGHT / 2)

end

function Camera:set()
	push:start()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.translate(self.position.x, self.position.y)
end

function Camera:drawDebug()
	debugHelper:drawText('cameraX: ' .. self.position.x)
	debugHelper:drawText('cameraY: ' .. self.position.y)
end

function Camera:unset()
	push:finish()
end