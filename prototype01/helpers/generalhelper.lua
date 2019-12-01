GeneralHelper = Class{}

function GeneralHelper:init()

end

function GeneralHelper:checkIntersect(x, maxX, y, maxY)
	local mousePos = mouse.position
	local intersect = true

	if mousePos.x > maxX then
		intersect = false
	elseif mousePos.x < x then
		intersect = false
	end

	-- Y
	if mousePos.y > maxY then
		intersect = false
	elseif mousePos.y < y then
		intersect = false
	end

	return intersect
end