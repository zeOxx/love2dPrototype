MenuHelper = Class{}

require '../ui/Button'
require '../Menu'

function MenuHelper:init()
	self.btnTemplates = {
		rounded = 'assets/templates/button/btnTemplate002.png',
		ornate = 'assets/templates/button/btnTemplate002.png'
	}
end

function MenuHelper:getMainMenu()
	local mainMenu = Menu()

	local btnWidth, btnHeight = 80, 20

	-- play button
	table.insert(mainMenu.buttons, Button((VIRTUAL_WIDTH / 2) - (btnWidth / 2), 100, btnWidth, btnHeight, "play", menuHelper.playGame, nil, self.btnTemplates.ornate, 7, 2))
	table.insert(mainMenu.buttons, Button((VIRTUAL_WIDTH / 2) - (btnWidth / 2), 130, btnWidth, btnHeight, "map editor", menuHelper.initMapEditor, nil, self.btnTemplates.ornate, 7, 2))
	table.insert(mainMenu.buttons, Button((VIRTUAL_WIDTH / 2) - (btnWidth / 2), 160, btnWidth, btnHeight, "exit", menuHelper.exitGame, nil, self.btnTemplates.ornate, 7, 2))

	return mainMenu
end

function MenuHelper:playGame()
	startGame()
	GAME_STATE = GAME_STATES.game
end

function MenuHelper:initMapEditor()
	startEditor()
	GAME_STATE = GAME_STATES.editor
end

function MenuHelper:exitGame()
	love.event.quit()
end

function MenuHelper:getButton(x, y)
	local menu = nil

	if GAME_STATE == GAME_STATES.mainMenu then
		menu = mainMenu
	end

	for i = 1, #menu.buttons do
		local button = menu.buttons[i]
		if x > button.position.x and x < button.position.maxX then
			if y > button.position.y and y < button.position.maxY then
				return button
			end
		end
	end

	return nil
end