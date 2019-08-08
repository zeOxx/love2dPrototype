Button = Class{}

function Button:init(x, y, width, height, text, func, clickSound, path, cornerSize, middleWidth)
	self.id = text
	self.position = { x = x or 0, y = y or 0 }
	self.dimensions = { w = width or 1, h = height or 1 }
	self.hover = false
	self.text = love.graphics.newText(love.graphics.getFont(), text)
	self.onClick = func
	self.clickSound = love.audio.newSource(clickSound or 'assets/audio/menu/btnClick.wav', "static")

	-- helper vars
	self.position.maxX = self.position.x + self.dimensions.w
	self.position.maxY = self.position.y + self.dimensions.h
	self.position.centerX = self.position.x + (self.dimensions.w / 2)
	self.position.centerY = self.position.y + (self.dimensions.h / 2)

	-- helper locals
	local scaleX = ((self.position.x + self.dimensions.w - cornerSize) - (self.position.x + cornerSize))/ middleWidth
	local scaleY = ((self.position.y + self.dimensions.h - cornerSize) - (self.position.y + cornerSize)) / middleWidth

	-- spritebatch creation
	local image = love.graphics.newImage(path)
	local texDimx, texDimy = image:getDimensions()

	self.batch = love.graphics.newSpriteBatch(image, image:getWidth() * image:getHeight())
	self.cornerSize = cornerSize
	self.middleWidth = middleWidth

	self.batch:add(love.graphics.newQuad(0, 0, cornerSize, cornerSize, texDimx, texDimy), self.position.x, self.position.y)
	self.batch:add(love.graphics.newQuad(cornerSize, 0, middleWidth, cornerSize, texDimx, texDimy), self.position.x + cornerSize, self.position.y, 0, scaleX, 1)
	self.batch:add(love.graphics.newQuad(cornerSize + middleWidth, 0, cornerSize, cornerSize, texDimx, texDimy), self.position.x + self.dimensions.w - cornerSize, self.position.y)
	self.batch:add(love.graphics.newQuad(0, cornerSize, cornerSize, middleWidth, texDimx, texDimy), self.position.x, self.position.y + cornerSize, 0, 1, scaleY)
	self.batch:add(love.graphics.newQuad(cornerSize, cornerSize, middleWidth, middleWidth, texDimx, texDimy), self.position.x + cornerSize, self.position.y + cornerSize, 0, scaleX, scaleY)
	self.batch:add(love.graphics.newQuad(cornerSize + middleWidth, cornerSize, cornerSize, middleWidth, texDimx, texDimy), self.position.x + self.dimensions.w - cornerSize, self.position.y + cornerSize, 0, 1, scaleY)
	self.batch:add(love.graphics.newQuad(0, cornerSize + middleWidth, cornerSize, cornerSize, texDimx, texDimy), self.position.x, self.position.y + self.dimensions.h - cornerSize)
	self.batch:add(love.graphics.newQuad(cornerSize, cornerSize + middleWidth, middleWidth, cornerSize, texDimx, texDimy), self.position.x + cornerSize, self.position.y + self.dimensions.h - cornerSize, 0, scaleX, 1)
	self.batch:add(love.graphics.newQuad(cornerSize + middleWidth, cornerSize + middleWidth, cornerSize, cornerSize, texDimx, texDimy), self.position.x + self.dimensions.w - cornerSize, self.position.y + self.dimensions.h - cornerSize)
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

	love.graphics.draw(self.batch)
	love.graphics.draw(self.text, self.position.centerX - (self.text:getWidth() / 2), self.position.centerY - (self.text:getHeight() / 2))

	love.graphics.setColor(r, g, b, a)
end