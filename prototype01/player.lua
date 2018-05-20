Player = Class{}

function Player:init(x, y)
	self.position = { x = x, y = y }
	self.delta = { x = 0, y = y }
	self.dimensions = { width = 8, height = 18 }

	self.speed = .9
	self.walking = false
	self.walkSpeed = .5

	self.weapons = {}
	table.insert(self.weapons, Weapon())
	self.activeWeapon = 1

	self.activeProjectiles = {}
end

function Player:shoot()
	if self.weapons[self.activeWeapon]:canShoot() then
		-- get rotation of projectile
		local playerPos = self:getScreenPosition()
		local mousePos = mouse:getMiddlePosition()
		local rot = math.atan2(mousePos.y - playerPos.y, mousePos.x - playerPos.x)

		-- get direction vector
		local direction = { x = mousePos.x - playerPos.x, y = mousePos.y - playerPos.y }

		-- Create projectile and add it to the table
		local weaponProj = self.weapons[self.activeWeapon].proj
		local projectile = Projectile(self.position.x, self.position.y, direction, rot, weaponProj.lifetime, weaponProj.type, weaponProj.texture, weaponProj.speed)

		table.insert(self.activeProjectiles, projectile)
		self.weapons[self.activeWeapon].shooting = true
	end
end

function Player:getScreenPosition(noCam)
	if noCam then
		return {
			x = self.position.x + (self.dimensions.width / 2),
			y = self.position.y + (self.dimensions.height / 2)
		}
	else
		return {
			x = self.position.x - camera.position.x + (self.dimensions.width / 2),
			y = self.position.y - camera.position.y + (self.dimensions.height / 2)
		}
	end
end

function Player:setDelta(dx, dy)
	self.delta.x, self.delta.y = dx, dy
end

function Player:resetDelta()
	self.delta = { x = 0, y = y }
end

function Player:update(dt)
	self:cleanProjectiles()

	-- PLAYER SPRITE STUFF
	if self.walking then
		self.position.x = self.position.x + (self.delta.x * self.walkSpeed)
		self.position.y = self.position.y + (self.delta.y * self.walkSpeed)
		mouse:updatePositionFromPlayerMovement(self.delta.x * self.walkSpeed, self.delta.y * self.walkSpeed)
	else
		self.position.x = self.position.x + (self.delta.x * self.speed)
		self.position.y = self.position.y + (self.delta.y * self.speed)
		mouse:updatePositionFromPlayerMovement(self.delta.x * self.speed, self.delta.y * self.speed)
	end

	-- PROJECTILES
	for i=1, #self.activeProjectiles, 1 do
		self.activeProjectiles[i]:update(dt)
	end

	-- WEAPONS
	for i=1, #self.weapons, 1 do
		self.weapons[i]:update(dt)
	end

	self:resetDelta()
end

function Player:cleanProjectiles()
	for i=#self.activeProjectiles, 1, -1 do
		if self.activeProjectiles[i].lifetime <= 0 then
			table.remove(self.activeProjectiles, i)
		end
	end
end

function Player:draw()
	love.graphics.rectangle('fill', self.position.x, self.position.y, self.dimensions.width, self.dimensions.height)

	for index, proj in pairs(self.activeProjectiles) do
		proj:draw()
	end
end

function Player:drawDebug()
	debugHelper:drawText('-PLAYER-')
	debugHelper:drawText('x: ' .. self.position.x)
	debugHelper:drawText('y: ' .. self.position.y)
	debugHelper:drawText('walking: ' .. tostring(self.walking))
	debugHelper:drawText('projectiles: ' .. #self.activeProjectiles)
end