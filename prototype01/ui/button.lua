Button = Class{}

function Button:init(x, y, width, height, text, func)
	self.position = { x = x or 0, y = y or 0 }
	self.dimensions = { w = width or 1, h = height or 1 }
	self.hover = false
	self.text = text
	self.onClick = func

	-- helper vars
	self.position.maxX = self.position.x + self.dimensions.w
	self.position.maxY = self.position.y + self.dimensions.h
end

function Button:update(dt)
	-- get mouse position and check if mouse is hovering over button
	local mousePos = mouse.position

	self.hover = true

	-- X
	if mousePos.x > self.position.maxX then
		self.hover = false
	elseif mousePos.x < self.position.x then
		self.hover = false
	end

	-- Y
	if mousePos.y > self.position.maxY then
		self.hover = false
	elseif mousePos.y < self.position.y then
		self.hover = false
	end

	if self.hover then
		self:checkClick(mousePos)
	end
end

function Button:checkClick(mousePos)

end

function Button:draw()
	local r, g, b, a = love.graphics.getColor()

	if self.hover then
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.rectangle("line", self.position.x, self.position.y, self.dimensions.w, self.dimensions.h)
	else
		love.graphics.setColor(0.5, 0.5, 0.5, 1)
		love.graphics.rectangle("line", self.position.x, self.position.y, self.dimensions.w, self.dimensions.h)
	end

	love.graphics.setColor(r, g, b, a)
end