local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer  -- ← ЭТА СТРОКА НУЖНА!

-- Функция для добавления закрытия к любому GUI
local function addCloseFunction(gui)
	local mainFrame = gui:FindFirstChild("MainFrame")
	if not mainFrame then return end

	local closeButton = mainFrame:FindFirstChild("CloseButton")
	if not closeButton then return end

	-- Закрытие по кнопке
	closeButton.MouseButton1Click:Connect(function()
		gui:Destroy()
	end)

	-- Закрытие по ESC
	local escConnection
	escConnection = UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.Escape then
			gui:Destroy()
			escConnection:Disconnect()
		end
	end)

	-- Отключаем ESC при удалении GUI
	gui.AncestryChanged:Connect(function()
		if not gui.Parent then
			escConnection:Disconnect()
		end
	end)
end

-- Отслеживаем все новые GUI
player.PlayerGui.ChildAdded:Connect(function(child)
	if child:IsA("ScreenGui") then
		addCloseFunction(child)
	end
end)
