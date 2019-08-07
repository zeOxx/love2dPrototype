Mouse = Class{}

function Mouse:init(x, y)
	self.position = { x = x, y = y }

	self.crosshairSprite = love.graphics.newImage('assets/sprites/crosshair.png')
	self.menuSprite = love.graphics.newImage('assets/sprites/menumouse.png')
end

function Mouse:getMiddlePosition(noCam)
	if noCam then
		return {
			x = self.position.x + (self.crosshairSprite:getWidth() / 2),
			y = self.position.y + (self.crosshairSprite:getHeight() / 2)
		}
	else
		return {
			x = self.position.x - camera.position.x + (self.crosshairSprite:getWidth() / 2),
			y = self.position.y - camera.position.y + (self.crosshairSprite:getHeight() / 2)
		}
	end
end

function Mouse:updatePosition(dx, dy)
	self.position.x = self.position.x + (dx / RATIO)
	self.position.y = self.position.y + (dy / RATIO)
end

function Mouse:updatePositionFromPlayerMovement(dx, dy)
	self.position.x = self.position.x + dx
	self.position.y = self.position.y + dy
end

function Mouse:draw()
	if GAME_STATE == GAME_STATES.game then
		love.graphics.draw(self.crosshairSprite, self.position.x, self.position.y)
	elseif GAME_STATE == GAME_STATES.mainMenu then
		love.graphics.draw(self.menuSprite, self.position.x, self.position.y)
	end
end

function Mouse:drawDebug()
	debugHelper:drawText('-MOUSE-')
	debugHelper:drawText('x: ' .. self.position.x)
	debugHelper:drawText('y: ' .. self.position.y)
end

-- Update mouse position stuff
function love.mousemoved(x, y, dx, dy)
	mouse:updatePosition(dx, dy)
end


-- LOVE EVENTS
function love.mousereleased(x, y, button, isTouch)
	x = mouse.position.x - camera.position.x
	y = mouse.position.y - camera.position.y

	if button ~= 1 then
		return
	end

	if GAME_STATE == GAME_STATES.mainMenu then
		local button = menuHelper:getButton(x, y)

		if button ~= nil then
			button.onClick()
			love.audio.play(button.clickSound)
		end
	end
end