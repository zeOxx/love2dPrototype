Hud = Class{}

function Hud:init()
	self.healthContainerImage = love.graphics.newImage('assets/ui/lifeContainer.png')
	self.healthPipImage = love.graphics.newImage('assets/ui/lifePip.png')

	-- CONTAINER
	self.healthContainerQuads = {}
	for i=0, player.absoluteMaxHealth do
		self.healthContainerQuads[i] = love.graphics.newQuad(0, 0, self.healthContainerImage:getWidth(), self.healthContainerImage:getHeight(), self.healthContainerImage:getDimensions())
	end
	self.healthContainer = love.graphics.newSpriteBatch(self.healthContainerImage, 1)

	-- PIPS
	self.healthPipQuads = {}
	for i=0, player.absoluteMaxHealth do
		self.healthPipQuads[i] = love.graphics.newQuad(0, 0, self.healthPipImage:getWidth(), self.healthPipImage:getHeight(), self.healthPipImage:getDimensions())
	end
	self.healthPips = love.graphics.newSpriteBatch(self.healthPipImage, 1)

	self:updateHealthHud()
end

function Hud:updateHealthHud()
	self.healthContainer:clear()
	for i=1, player.maxHealth do
		local y = 10
		if i%2 ~= 0 then
			y = y + (self.healthContainerImage:getWidth() / 2)
		end

		self.healthContainer:add(self.healthContainerQuads[i], (i * (self.healthContainerImage:getWidth() / 2)) + 10, y)
	end
	self.healthContainer:flush()

	self.healthPips:clear()
	for i=1, player.health do
		local y = 10
		if i%2 ~= 0 then
			y = y + (self.healthContainerImage:getWidth() / 2)
		end

		self.healthPips:add(self.healthPipQuads[i], (i * (self.healthContainerImage:getWidth() / 2)) + 10, y)
	end
	self.healthPips:flush()
end

function Hud:draw()
	push:start()
	-- healthcontainers
	love.graphics.draw(self.healthContainer)
	love.graphics.draw(self.healthPips)
	push:finish()
end