EditorHelper = Class{}

function EditorHelper:init()
	-- nothing yet
end

function EditorHelper:createNewLevel()
	-- spawn dialog to ask for level name and dimensions, then generate new level
end

function EditorHelper:openLevel()
	-- opens dialog where user can choose level
end

function EditorHelper:saveLevel()
	-- simply save
end

function EditorHelper:saveLevelAs()
	-- spawn dialog to ask for new level name, then save
end

function EditorHelper:exit()
	-- exits editor
end

function EditorHelper:getButton(x, y)
	for i = 1, #editor.taskbar.taskbarButtons do
		local button = editor.taskbar.taskbarButtons[i]

		if x > button.position.x and x < button.position.maxX then
			if y > button.position.y and y < button.position.maxY then
				return button
			end
		end
	end

	return nil
end