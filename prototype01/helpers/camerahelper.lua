CameraHelper = Class{}

function CameraHelper:init()
	-- EMPTY
end

function CameraHelper:getCameraFocusPoint()
	if GAME_STATE == GAME_STATES.game then
		local playerPos = player:getScreenPosition(true)
		local mousePos = mouse:getMiddlePosition(true)

		local middlePointX = (playerPos.x + mousePos.x) / 2
		local middlePointY = (playerPos.y + mousePos.y) / 2

		return { x = (playerPos.x + middlePointX) / 2, y = (playerPos.y + middlePointY) / 2 }
	elseif GAME_STATE == GAME_STATES.mainMenu then
		return { x = 0, y = 0 }
	end
end