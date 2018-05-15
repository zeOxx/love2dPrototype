-- lIBS
push = require 'libs/push'
Class = require 'libs/class'

-- Classes
require 'Camera'
require 'Player'
require 'Mouse'
require 'Keyhandler'

-- Globals
GAME_TITLE = 'Prototype01'
RESOLUTION_WIDTH = 1920
RESOLUTION_HEIGHT = 1080
VIRTUAL_WIDTH = 480
VIRTUAL_HEIGHT = 270

RATIO = 1920 / 480

DEBUG = false

GAME_STATE = 'GAME'

-- Load
function love.load()
	initWindow()
	initMouse()
	initFonts()

	mouse = Mouse(push:toGame(love.mouse.getPosition()))
	player = Player(0, 0)
	camera = Camera(player.position.x + (VIRTUAL_WIDTH / 2), player.position.y + (VIRTUAL_HEIGHT / 2))
	keyhandler = Keyhandler()

	DEBUG = false
end

-- Inits
function initWindow()
	love.window.setTitle(GAME_TITLE)

	love.graphics.setDefaultFilter('nearest', 'nearest')
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, RESOLUTION_WIDTH, RESOLUTION_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
end

function initMouse()
	love.mouse.setRelativeMode(true)
end

function initFonts()
	smallFont = love.graphics.newFont('assets/fonts/font.ttf', 8)
	love.graphics.setFont(smallFont)
end

-- Update mouse position stuff
function love.mousemoved(x, y, dx, dy)
	mouse:update(dx, dy)
end

-- update
function love.update()
	keyhandler:update()
end

function love.draw()
	camera:set()
		-- clear screen
		love.graphics.clear({ .2, .2, .5, 1 })

		player:draw()
	camera:unset()

	-- HUD STUFF
	push:start()
		mouse:draw()
	push:finish()

	-- DEBUG
	drawDebug()
end

function drawDebug()
	if DEBUG then
		push:start()
			mouse:drawDebug()
			player:drawDebug()
			camera:drawDebug()
		push:finish()
	end
end