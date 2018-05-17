Mouse = Class{}

function Mouse:init(x, y)
	self.position = { x = x, y = y }

	self.crosshairSprite = love.graphics.newImage('assets/sprites/crosshair.png')
end

function Mouse:getMiddlePosition()
	return { x = self.position.x + (self.crosshairSprite:getWidth() / 2), y = self.position.y + (self.crosshairSprite:getHeight() / 2) }
end

function Mouse:updatePosition(dx, dy)
	mouse.position.x = mouse.position.x + (dx / RATIO)
	mouse.position.y = mouse.position.y + (dy / RATIO)
end

function Mouse:updatePositionFromPlayerMovement(dx, dy)
	mouse.position.x = mouse.position.x + dx
	mouse.position.y = mouse.position.y + dy
end

function Mouse:draw()
	if GAME_STATE == 'GAME' then
		love.graphics.draw(self.crosshairSprite, self.position.x, self.position.y)
	end
end

function Mouse:drawDebug()
	debugHelper:drawText('mouseX: ' .. mouse.position.x)
	debugHelper:drawText('mouseY: ' .. mouse.position.y)
end