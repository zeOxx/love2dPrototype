CameraHelper = Class{}

function CameraHelper:init()
	-- empty
end

function CameraHelper:getCameraFocusPoint()
	local playerPos = player:getScreenPosition(true)
	local mousePos = mouse:getMiddlePosition(true)

	local middlePointX = (playerPos.x + mousePos.x) / 2
	local middlePointY = (playerPos.y + mousePos.y) / 2

	return { x = (playerPos.x + middlePointX) / 2, y = (playerPos.y + middlePointY) / 2 }
end