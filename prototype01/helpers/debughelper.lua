DebugHelper = Class{}

function DebugHelper:init()
	self:resetValues()
end

function DebugHelper:update()
	self:resetValues()
end

function DebugHelper:resetValues()
	self.x = 5
	self.y = 5
	self.spaceBetweenY = 10
end

function DebugHelper:draw(text)
	love.graphics.print(text, self.x, self.y)
	self.y = self.y + self.spaceBetweenY
end