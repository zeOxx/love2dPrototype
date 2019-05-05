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

-- UI


-- Helpers
require 'helpers/Debughelper'
require 'helpers/Camerahelper'
require 'helpers/Tilehelper'
require 'helpers/Menuhelper'


-- Globals
GAME_TITLE = 'Prototype01'
RESOLUTION_WIDTH = 1920
RESOLUTION_HEIGHT = 1080
VIRTUAL_WIDTH = 480
VIRTUAL_HEIGHT = 270

RATIO = RESOLUTION_WIDTH / VIRTUAL_WIDTH

DEBUG = false

GAME_STATES = { mainMenu = "mainMenu", pause = "pause", inventory = "inventory", game = "game" }
GAME_STATE = GAME_STATES.mainMenu

-- Load
function love.load()
	initWindow()
	initMouse()
	initFonts()
	initHelpers()

	if GAME_STATE == GAME_STATES.mainMenu then
		loadMainMenu()
	elseif GAME_STATE == GAME.STATES.game then
		startGame()
	end
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
	debugFont = love.graphics.newFont('assets/fonts/font.ttf', 8)
	love.graphics.setFont(debugFont)
end

function initHelpers()
	keyhandler = Keyhandler()
	debugHelper = DebugHelper()
	cameraHelper = CameraHelper()
	tileHelper = TileHelper()
	menuHelper = MenuHelper()
end

function loadMainMenu()
	mouse = Mouse(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)
	mainMenu = menuHelper:getMainMenu()
	camera = Camera(0, 0)
end

function startGame()
	map = Map()
	map:loadMap('devmap', tileHelper:getDevTileSet())

	player = Player(map.playerSpawn.x, map.playerSpawn.y)
	mouse = Mouse(map.playerSpawn.x, map.playerSpawn.y)

	camera = Camera(player.position.x - (VIRTUAL_WIDTH / 2), player.position.y - (VIRTUAL_HEIGHT / 2))
end

-- Update mouse position stuff
function love.mousemoved(x, y, dx, dy)
	mouse:updatePosition(dx, dy)
end

-- update
function love.update(dt)
	if GAME_STATE == GAME_STATES.game then
		local focusPoint = cameraHelper:getCameraFocusPoint()
		camera:update(focusPoint.x - (VIRTUAL_WIDTH / 2), focusPoint.y - (VIRTUAL_HEIGHT / 2))
		keyhandler:updateGame()
		player:update(dt, map)
		debugHelper:update()
	elseif GAME_STATE == GAME_STATES.mainMenu then

	end
end

function love.draw()
	camera:set() -- CAMERA SET
	-- clear screen
	love.graphics.clear({ 0, 0, 0, 1 })

	if GAME_STATE == GAME_STATES.game then
		map:draw()

		player:draw()
		mouse:draw()

		camera:unset() -- CAMERA UNSET

		-- HUD STUFF (TODO)

		-- DEBUG
		drawDebug()
	elseif GAME_STATE == GAME_STATES.mainMenu then
		mainMenu:draw()
		mouse:draw()

		camera:unset()
	end
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