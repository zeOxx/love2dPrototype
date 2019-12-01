Editor = Class{}

require '../ui/editor/taskbar'

function Editor:init()
	self.levelName = "untitled"
	self.levelDimensions = { x = 20, y = 20 }
	self.tileSet = tileHelper.tileSets['dev']

	self.taskbar = Taskbar()
end

function Editor:update(dt)
	self.taskbar:update(dt)
end

function Editor:draw()
	love.graphics.clear({ 0, 0, 0, 1 })
	self.taskbar:draw()
end