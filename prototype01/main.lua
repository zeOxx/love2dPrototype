-- LIBS
push = require 'libs/push'
Class = require 'libs/class'
inspect = require 'libs/inspect'
json = require 'libs/json'

-- Classes
require 'Camera'
require 'Player'
require 'Mouse'
require 'Keyhandler'
require 'Projectile'
require 'Weapon'
require 'Map'
require 'editor/Editor'

-- UI
require 'Hud'

-- Helpers
require 'helpers/Debughelper'
require 'helpers/Camerahelper'
require 'helpers/Tilehelper'
require 'helpers/Menuhelper'
require 'helpers/EditorHelper'
require 'helpers/GeneralHelper'

-- Globals
GAME_TITLE = 'Prototype01'
RESOLUTION_WIDTH = 1920
RESOLUTION_HEIGHT = 1080
VIRTUAL_WIDTH = 480
VIRTUAL_HEIGHT = 270

RATIO = RESOLUTION_WIDTH / VIRTUAL_WIDTH

DEBUG = false

GAME_STATES = {
	mainMenu = "mainMenu",
	pause = "pause",
	inventory = "inventory",
	game = "game",
	editor = "editor"
}
GAME_STATE = GAME_STATES.mainMenu

-- Load
function love.load()
	initWindow()
	initMouse()
	initFonts()
	initHelpers()

	if GAME_STATE == GAME_STATES.mainMenu then
		loadMainMenu()
	elseif GAME_STATE == GAME_STATES.game then
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
	editorHelper = EditorHelper()
	generalHelper = GeneralHelper()
end

function loadMainMenu()
	mouse = Mouse(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)
	mainMenu = menuHelper:getMainMenu()
	camera = Camera(0, 0)
end

function startGame()
	map = Map()
	map:loadMap('devmap')

	player = Player(map.playerSpawn.x, map.playerSpawn.y)
	mouse = Mouse(map.playerSpawn.x, map.playerSpawn.y)
	hud = Hud()

	camera = Camera(player.position.x - (VIRTUAL_WIDTH / 2), player.position.y - (VIRTUAL_HEIGHT / 2))
end

function startEditor()
	editor = Editor()
	mouse = Mouse(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)
end

-- update
function love.update(dt)
	if GAME_STATE == GAME_STATES.game then
		-- GAME
		local focusPoint = cameraHelper:getCameraFocusPoint()
		camera:update(focusPoint.x - (VIRTUAL_WIDTH / 2), focusPoint.y - (VIRTUAL_HEIGHT / 2))
		keyhandler:updateGame()
		player:update(dt, map)
		debugHelper:update()
	elseif GAME_STATE == GAME_STATES.mainMenu then
		-- MAIN MENU
		mainMenu:update(dt)
	elseif GAME_STATE == GAME_STATES.editor then
		editor:update(dt)
	end
end

function love.draw()
	if GAME_STATE == GAME_STATES.game then
		camera:set() -- CAMERA SET
		-- clear screen
		love.graphics.clear({ 0, 0, 0, 1 })

		map:draw()

		player:draw()
		mouse:draw()


		camera:unset() -- CAMERA UNSET

		-- HUD STUFF (TODO)
		hud:draw()

		-- DEBUG
		drawDebug()
	elseif GAME_STATE == GAME_STATES.mainMenu then
		camera:set() -- CAMERA SET
		-- clear screen
		love.graphics.clear({ 0, 0, 0, 1 })

		mainMenu:draw()
		mouse:draw()

		camera:unset()
	elseif GAME_STATE == GAME_STATES.editor then
		camera:set()

		editor:draw()
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