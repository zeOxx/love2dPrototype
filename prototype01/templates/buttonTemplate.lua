ButtonTemplate = Class{}

function ButtonTemplate:init(path, cornerSize, middleWidth)
	self.image = love.graphics.newImage(path)
	self.cornerSize = cornerSize
	self.middleWidth = middleWidth

	self.quads = {}

	table.insert(self.quads, love.graphics.newQuad(0, 0, self.cornerSize, self.cornerSize, self.image:getDimensions()))
	table.insert(self.quads, love.graphics.newQuad(self.cornerSize, 0, self.middleWidth, self.cornerSize, self.image:getDimensions()))
	table.insert(self.quads, love.graphics.newQuad(self.cornerSize + self.middleWidth, 0, self.cornerSize, self.cornerSize, self.image:getDimensions()))
	table.insert(self.quads, love.graphics.newQuad(0, self.cornerSize, self.cornerSize, self.middleWidth, self.image:getDimensions()))
	table.insert(self.quads, love.graphics.newQuad(self.cornerSize, self.cornerSize, self.middleWidth, self.middleWidth, self.image:getDimensions()))
	table.insert(self.quads, love.graphics.newQuad(self.cornerSize + self.middleWidth, self.cornerSize, self.cornerSize, self.middleWidth, self.image:getDimensions()))
	table.insert(self.quads, love.graphics.newQuad(0, self.cornerSize + self.middleWidth, self.cornerSize, self.cornerSize, self.image:getDimensions()))
	table.insert(self.quads, love.graphics.newQuad(self.cornerSize, self.cornerSize + self.middleWidth, self.middleWidth, self.cornerSize, self.image:getDimensions()))
	table.insert(self.quads, love.graphics.newQuad(self.cornerSize + self.middleWidth, self.cornerSize + self.middleWidth, self.cornerSize, self.cornerSize, self.image:getDimensions()))
end

function ButtonTemplate:draw(position, dimensions)
	local cornerSize = self.cornerSize
	local scaleX = ((position.x + dimensions.w - cornerSize) - (position.x + cornerSize))/ self.middleWidth
	local scaleY = ((position.y + dimensions.h - cornerSize) - (position.y + cornerSize)) / self.middleWidth

	love.graphics.draw(self.image, self.quads[1], position.x, position.y)
	love.graphics.draw(self.image, self.quads[2], position.x + cornerSize, position.y, 0, scaleX, 1)
	love.graphics.draw(self.image, self.quads[3], position.x + dimensions.w - cornerSize, position.y)
	love.graphics.draw(self.image, self.quads[4], position.x, position.y + cornerSize, 0, 1, scaleY)
	love.graphics.draw(self.image, self.quads[5], position.x + cornerSize, position.y + cornerSize, 0, scaleX, scaleY)
	love.graphics.draw(self.image, self.quads[6], position.x + dimensions.w - cornerSize, position.y + cornerSize, 0, 1, scaleY)
	love.graphics.draw(self.image, self.quads[7], position.x, position.y + dimensions.h - cornerSize)
	love.graphics.draw(self.image, self.quads[8], position.x + cornerSize, position.y + dimensions.h - cornerSize, 0, scaleX, 1)
	love.graphics.draw(self.image, self.quads[9], position.x + dimensions.w - cornerSize, position.y + dimensions.h - cornerSize)
end