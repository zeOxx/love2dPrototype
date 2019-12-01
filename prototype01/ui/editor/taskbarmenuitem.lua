TaskbarMenuItem = Class{}

function TaskbarMenuItem:init(text, func, hotkey, shiftModifier)
	self.text = love.graphics.newText(love.graphics.getFont(), text)
	self.func = func
	self.hotkey = hotkey
	self.shiftModifier = shiftModifier or false
	self.position = {}

	self.hover = false
end

function TaskbarMenuItem:setPosition(x, y, width, height, margins)
	self.position = {
		x = x,
		y = y,
		width = width,
		height = height,
		margins = margins
	}
end

function TaskbarMenuItem:update(dt)
	-- get mouse position and check if mouse is hovering over button
	local mousePos = mouse.position

	self.hover = generalHelper:checkIntersect(self.position.x, self.position.width + self.position.x, self.position.y, self.position.y + self.position.height)
	-- if self.isClicked then
	-- 	self.menu:update(dt, self.position.x)
	-- end
end

function TaskbarMenuItem:draw()
	-- draw hover rectangle under text if hovering
	if self.hover then
		love.graphics.setColor(0.8, 0.8, 0.8, 1)
		love.graphics.rectangle(
			'fill',
			self.position.x - self.position.margins,
			self.position.y - self.position.margins,
			self.position.width,
			self.position.height + self.position.margins)
	end
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.draw(self.text, self.position.x, self.position.y)
end