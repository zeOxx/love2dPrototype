Weapon = Class{}

function Weapon:init(type)
	self.type = type or 1
	self.proj = {}

	self.shooting = false
	self.timeToShoot = 0

	if self.type == 1 then
		self:initPistol()
	end
end

function Weapon:initPistol()
	self.name = 'Pistol'
	self.fireRate = .2

	self.proj.lifetime = 2
	self.proj.type = 1
	self.proj.texture = love.graphics.newImage('assets/sprites/bullet.png')
	self.proj.speed = 3
end

function Weapon:canShoot()
	return not self.shooting
end

function Weapon:update(dt)
	if self.shooting and self.timeToShoot >= self.fireRate then
		self.shooting = false
		self.timeToShoot = 0
	elseif self.shooting and self.timeToShoot < self.fireRate then
		self.timeToShoot = self.timeToShoot + dt
	end
end