DebugHelper = Class{}

function DebugHelper:init()
	self.x = 5
	self.y = 5
	self.spaceBetweenY = 10
end

function DebugHelper:update()
	self.y = 5
	self.y = 5
	self.spaceBetweenY = 10
end

function DebugHelper:draw(text)
	love.graphics.print(text, self.x, self.y)
	self.y = self.y + self.spaceBetweenY
end