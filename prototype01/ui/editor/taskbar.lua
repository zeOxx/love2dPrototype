Taskbar = Class{}

require '../ui/editor/taskbarbutton'
require '../ui/editor/taskbarmenu'
require '../ui/editor/taskbarmenuitem'

function Taskbar:init()
	self.height = 10

	self.taskbarButtons = {}

	-- File button
	-- first set up menu items and menu for file button, then create file button last
	local fileMenu = TaskbarMenu({
		TaskbarMenuItem('New', editorHelper.createNewLevel, 'N'),
		TaskbarMenuItem('Open', editorHelper.openLevel, 'O'),
		TaskbarMenuItem('Save', editorHelper.saveLevel, 'S'),
		TaskbarMenuItem('Save as..', editorHelper.saveLevelAs, 'S', true),
		TaskbarMenuItem('Exit', editorHelper.exit, 'E')
	}, 2, self.height)
	table.insert(self.taskbarButtons, TaskbarButton('File', fileMenu, 2, self.height))
end

function Taskbar:getClickedButton()
	for i = 1, #editor.taskbar.taskbarButtons do
		local button = editor.taskbar.taskbarButtons[i]

		if button.isClicked then
			return button
		end
	end
	return nil
end

function Taskbar:update(dt)
	for i=#self.taskbarButtons, 1, -1 do
		local button = self.taskbarButtons[i]
		button:update(dt)
	end
end

function Taskbar:draw()
	love.graphics.setColor(0.95, 0.95, 0.95, 1)
	love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, self.height)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.line(0, self.height + 1, VIRTUAL_WIDTH, self.height + 1)

	-- buttons
	for i = 1, #self.taskbarButtons do
		local button = self.taskbarButtons[i]

		button:draw()
	end
end