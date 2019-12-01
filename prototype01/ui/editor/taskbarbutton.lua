TaskbarButton = Class{}

function TaskbarButton:init(text, menu, x, taskbarHeight)
	self.text = love.graphics.newText(love.graphics.getFont(), text)
	self.rawText = text
	self.menu = menu
	self.position = { x = x, y = 2, maxY = taskbarHeight }

	-- set maxX
	self.position.maxX = self.position.x + self.text:getWidth()

	self.hover = false
	self.isClicked = false
end

function TaskbarButton:click()
	self.isClicked = not self.isClicked
end

function TaskbarButton:update(dt)
	-- get mouse position and check if mouse is hovering over button
	local mousePos = mouse.position

	self.hover = generalHelper:checkIntersect(self.position.x, self.position.maxX, self.position.y, self.position.maxY)

	if self.isClicked then
		self.menu:update(dt)
	end
end

function TaskbarButton:draw()
	local r, g, b, a = love.graphics.getColor()

	if self.hover or self.isClicked then
		love.graphics.setColor(0.3, 0.3, 0.3, 1)
	else
		love.graphics.setColor(0, 0, 0, 1)
	end

	love.graphics.draw(self.text, self.position.x, self.position.y)


	if self.isClicked then
		self.menu:draw()
	end

	love.graphics.setColor(r, g, b, a)
end