-- lIBS
push = require 'libs/push'
Class = require 'libs/class'

-- Classes
require 'Camera'
require 'Player'
require 'Mouse'
require 'Keyhandler'
require 'Projectile'
require 'Weapon'
require 'Map'
require 'TileSet'
require 'Tile'

-- Helpers
require 'helpers/Debughelper'
require 'helpers/Camerahelper'
require 'helpers/Tilehelper'


-- Globals
GAME_TITLE = 'Prototype01'
RESOLUTION_WIDTH = 1920
RESOLUTION_HEIGHT = 1080
VIRTUAL_WIDTH = 480
VIRTUAL_HEIGHT = 270

RATIO = RESOLUTION_WIDTH / VIRTUAL_WIDTH

DEBUG = false

GAME_STATE = 'GAME'

-- Load
function love.load()
	initWindow()
	initMouse()
	initFonts()

	mouse = Mouse(0, 0)
	player = Player(0, 0)
	camera = Camera(player.position.x - (VIRTUAL_WIDTH / 2), player.position.y - (VIRTUAL_HEIGHT / 2))
	keyhandler = Keyhandler()
	debugHelper = DebugHelper()
	cameraHelper = CameraHelper()
	tileHelper = TileHelper()
	map = Map()
	map:loadMap('devmap', tileHelper:getDevTileSet())

	DEBUG = false
end

-- Inits
function initWindow()
	love.window.setTitle(GAME_TITLE)

	love.graphics.setDefaultFilter('nearest', 'nearest')
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, RESOLUTION_WIDTH, RESOLUTION_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = false
	})
end

function initMouse()
	love.mouse.setRelativeMode(true)
end

function initFonts()
	debugFont = love.graphics.newFont('assets/fonts/font.ttf', 8)
	love.graphics.setFont(debugFont)
end

-- Update mouse position stuff
function love.mousemoved(x, y, dx, dy)
	mouse:updatePosition(dx, dy)
end

-- update
function love.update(dt)
	local focusPoint = cameraHelper:getCameraFocusPoint()
	camera:update(focusPoint.x - (VIRTUAL_WIDTH / 2), focusPoint.y - (VIRTUAL_HEIGHT / 2))
	keyhandler:update()
	player:update(dt)
	debugHelper:update()
end

function love.draw()
	camera:set() -- CAMERA SET
	-- clear screen
	love.graphics.clear({ 0, 0, 0, 1 })
	map:draw(-10, -10)

	player:draw()
	mouse:draw()

	camera:unset() -- CAMERA UNSET

	-- HUD STUFF (TODO)

	-- DEBUG
	drawDebug()
end

function drawDebug()
	if DEBUG then
		push:start() -- START
		debugHelper:draw()

		love.graphics.setColor(0, 1, 0, 1)
		player:drawDebug()
		mouse:drawDebug()
		camera:drawDebug()
		debugHelper:drawText('FPS: ' .. love.timer.getFPS())
		push:finish() -- FINISH
	end
end