require 'ui/Health'

Hud = Class{}

function Hud:init()
	self.healthContainerImage = love.graphics.newImage('assets/ui/lifeContainer.png')

	self.healthContainerQuads = {}
	-- absolute max health is 10, so we just loop
	for i=0, 10 do
		self.healthContainerQuads[i] = love.graphics.newQuad(0, 0, self.healthContainerImage:getWidth(), self.healthContainerImage:getHeight(), self.healthContainerImage:getDimensions())
	end

	self.healthContainer = love.graphics.newSpriteBatch(self.healthContainerImage, 1)

	self:updateHealthContainers()
end

function Hud:updateHealthContainers()
	self.healthContainer:clear()

	for i=0, player.maxHealth-1 do
		self.healthContainer:add(self.healthContainerQuads[i], i * self.healthContainerImage:getWidth(), 20)
	end

	self.healthContainer:flush()
end

function Hud:draw()
	-- healthcontainers
	love.graphics.draw(self.healthContainer)
end