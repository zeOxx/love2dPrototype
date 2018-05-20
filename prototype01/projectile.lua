Projectile = Class{}

function Projectile:init(x, y, direction, rot, lifetime, type, texture, speed)
	self.position = { x = x or 0, y = y or 0 }
	self.direction = direction
	self.rotation = rot or 0
	self.lifetime = lifetime or 2
	self.type = type or 1
	self.texture = texture or love.graphics.newImage('assets/sprites/bullet.png')
	self.speed = speed or 6

	-- normalize direction
	local length = math.sqrt(self.direction.x^2+self.direction.y^2)
	self.direction.x, self.direction.y = self.direction.x/length, self.direction.y/length
end

function Projectile:setPosition(x, y)
	self.position.x, self.position.y = x, y
end

function Projectile:setRotation(rot)
	self.rotation = rot
end

function Projectile:setSpeed(speed)
	self.speed = speed
end

function Projectile:update(dt)
	-- TEMPORARY
	self.position.x = self.position.x + self.direction.x * self.speed
	self.position.y = self.position.y + self.direction.y * self.speed
	self.lifetime = self.lifetime - dt
end

function Projectile:draw()
	love.graphics.draw(self.texture, self.position.x, self.position.y, self.rotation)
end