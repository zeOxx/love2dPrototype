Mouse = Class{}

function Mouse:init(x, y)
	self.position = { x = x, y = y }

	self.crosshairSprite = love.graphics.newImage('assets/sprites/crosshair.png')
end

function Mouse:update(dx, dy)
	mouse.position.x = mouse.position.x + (dx / RATIO)
	mouse.position.y = mouse.position.y + (dy / RATIO)
end

function Mouse:draw()
	if GAME_STATE == 'GAME' then
		love.graphics.draw(self.crosshairSprite, self.position.x, self.position.y)
	end
end

function Mouse:drawDebug()
	love.graphics.print('mouseX: ' .. self.position.x or 0, 5, 25)
	love.graphics.print('mouseY: ' .. self.position.y or 0, 5, 35)
end