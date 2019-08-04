Button = Class{}

function Button:init(x, y, width, height, text, func, clickSound, template)
	self.position = { x = x or 0, y = y or 0 }
	self.dimensions = { w = width or 1, h = height or 1 }
	self.hover = false
	self.text = love.graphics.newText(love.graphics.getFont(), text)
	self.onClick = func
	self.clickSound = love.audio.newSource(clickSound or 'assets/audio/menu/btnClick.wav', "static")
	self.template = menuHelper.btnTemplates[template]

	-- helper vars
	self.position.maxX = self.position.x + self.dimensions.w
	self.position.maxY = self.position.y + self.dimensions.h
	self.position.centerX = self.position.x + (self.dimensions.w / 2)
	self.position.centerY = self.position.y + (self.dimensions.h / 2)
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
end

function Button:draw()
	local r, g, b, a = love.graphics.getColor()

	if self.hover then
		love.graphics.setColor(1, 1, 1, 1)
	else
		love.graphics.setColor(0.7, 0.7, 0.7, 1)
	end

	self.template:draw(self.position, self.dimensions)
	love.graphics.draw(self.text, self.position.centerX - (self.text:getWidth() / 2), self.position.centerY - (self.text:getHeight() / 2))

	love.graphics.setColor(r, g, b, a)
end