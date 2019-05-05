Menu = Class{}

function Menu:init()
	self.buttons = {}
end

function Menu:update(dt)

end

function Menu:draw()
	-- buttons
	for i = 1, #self.buttons do
		local button = self.buttons[i]

		button:draw()
	end
end