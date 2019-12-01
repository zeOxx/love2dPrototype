TaskbarMenu = Class{}

function TaskbarMenu:init(items, x, taskbarHeight)
	self.menuitems = items
	self.x = x

	-- set dimensions based on amount of items
	self.margins = 2
	self.itemsize = self.menuitems[1].text:getHeight()
	self.itemspace = 3

	self.height = self.margins + (self.itemsize * #self.menuitems) + ((self.itemspace * #self.menuitems) - self.itemspace)
	self.width = 70 -- random value
	self.taskbarHeight = taskbarHeight

	for i = 1, #self.menuitems do
		local item = self.menuitems[i]

		local y = self.taskbarHeight + self.margins + ((self.itemsize * i) - self.itemsize) + ((self.itemspace * i) - self.itemspace)
		item:setPosition(x, y, self.width, self.itemsize, self.margins)
	end
end

function TaskbarMenu:update(dt)
	for i = 1, #self.menuitems do
		local item = self.menuitems[i]
		item:update(dt)
	end
end

function TaskbarMenu:draw()
	local x = self.x - self.margins
	love.graphics.setColor(0.9, 0.9, 0.9, 1)
	love.graphics.rectangle('fill', x, self.taskbarHeight, self.width, self.height)

	-- set x to include margins
	x = self.x + self.margins

	-- items
	for i = 1, #self.menuitems do
		local item = self.menuitems[i]
		item:draw()
	end
end