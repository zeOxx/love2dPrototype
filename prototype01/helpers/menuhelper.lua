MenuHelper = Class{}

require '../Menu'
require '../ui/Button'

function MenuHelper:getMainMenu()
	local mainMenu = Menu()
	-- play button
	table.insert(mainMenu.buttons, Button(100, 100, 100, 100, "play"))

	return mainMenu
end