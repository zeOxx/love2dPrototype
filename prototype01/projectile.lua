Projectile = Class{}

function Projectile:init(x, y, direction, rot, lifetime, type, texture, speed)
	self.position = { x = x or 0, y = y or 0 }
	self.direction = direction
	self.rotation = rot or 0
	self.lifetime = lifetime or 2
	self.type = type or 1
	self.texture = texture or love.graphics.newImage('assets/sprites/bullet.png')
	self.speed = speed or 6
	self.hit = false

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

function Projectile:update(dt, map)
	-- collision
	self:checkCollision(map)

	-- TEMPORARY
	self.position.x = self.position.x + self.direction.x * self.speed
	self.position.y = self.position.y + self.direction.y * self.speed
	self.lifetime = self.lifetime - dt
end

function Projectile:checkCollision(map)
	local nextX, nextY

	nextX = self.position.x + self.direction.x * self.speed
	nextY = self.position.y + self.direction.y * self.speed

	local tileSetDimensions = map.tileSet.dimensions
	local collision = false
	for i = 1, #map.tileCollisionMap do
		local collTile = map.tileCollisionMap[i]
		local tileCollision = true

		-- really dumb and basic collision detection
		if nextX > collTile.x + tileSetDimensions then
			tileCollision = false
		end
		if nextX < collTile.x then
			tileCollision = false
		end
		if nextY > collTile.y + tileSetDimensions then
			tileCollision = false
		end
		if nextY < collTile.y then
			tileCollision = false
		end

		if tileCollision then
			collision = true
			break
		end
	end
	if collision then
		self.hit = true
	end
end

function Projectile:draw()
	love.graphics.draw(self.texture, self.position.x, self.position.y, self.rotation)
end