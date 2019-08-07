Keyhandler = Class{}

function Keyhandler:init()
	-- EMPTY
end

function Keyhandler:updateGame()
	-- Player movement
	-- X
	local dx, dy = 0, 0
	if love.keyboard.isDown('a') then
		dx = -1
	elseif love.keyboard.isDown('d') then
		dx = 1
	end

	-- Y
	if love.keyboard.isDown('w') then
		dy = -1
	elseif love.keyboard.isDown('s') then
		dy = 1
	end
	local length = math.sqrt(dx^2+dy^2)
	if length > 1 then
		dx,dy = dx/length ,dy/length
	end
	player:setDelta(dx, dy)

	-- Camera during debug
	if DEBUG then
		local cdx, cdy = 0, 0
		if love.keyboard.isDown('left') then
			cdx = -1
		elseif love.keyboard.isDown('right') then
			cdx = 1
		end

		if love.keyboard.isDown('up') then
			cdy = -1
		elseif love.keyboard.isDown('down') then
			cdy = 1
		end

		camera:move(cdx, cdy)
	end

	-- Mouse
	if love.mouse.isDown(1) then
		player:shoot()
	end
end

function Keyhandler:updateMenu()
	-- Update menu here
end

function Keyhandler:keyPressGame(key)
	-- escape handling
	if key == 'escape' then
		love.event.quit()
	end

	-- DEBUG on or off
	if key == 'f1' then
		DEBUG = not DEBUG
	end

	if key == 'lshift' then
		player.walking = true
	end
end

function Keyhandler:keyReleaseGame(key)
	if key == 'lshift' then
		player.walking = false
	end
end

function love.keypressed(key)
	if GAME_STATE == GAME_STATES.game then
		keyhandler:keyPressGame(key)
	end
end

function love.keyreleased(key)
	if GAME_STATE == GAME_STATES.game then
		keyhandler:keyReleaseGame(key)
	end
end