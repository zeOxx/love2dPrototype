require '../Menu'
require '../ui/Button'

MenuHelper = Class{}

function MenuHelper:getMainMenu()
	local mainMenu = Menu()
	-- play button
	table.insert(mainMenu.buttons, Button(100, 100, 100, 100, "play", menuHelper.playGame))

	return mainMenu
end

function MenuHelper:playGame()
	startGame()
	GAME_STATE = GAME_STATES.game
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