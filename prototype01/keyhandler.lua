Keyhandler = Class{}

function Keyhandler:init()
	-- EMPTY
end

function Keyhandler:update()
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

	player:update(dx, dy)
end

function love.keypressed(key)
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

function love.keyreleased(key)
	if key == 'lshift' then
		player.walking = false
	end
end