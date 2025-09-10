local Players = game:GetService("Players")
local remoteEvent = game.ReplicatedStorage.OpenWeaponShop
local gui = game.ReplicatedStorage.WeaponShopGUI
local player = Players.LocalPlayer

remoteEvent.OnClientEvent:Connect(function()
	print("Получил сигнал открыть магазин!")

	-- Проверяем есть ли уже магазин
	local existingShop = player.PlayerGui:FindFirstChild("WeaponShopGUI")
	if existingShop then 
		print("Магазин уже открыт!")
		return 
	end

	-- Клонируем и показываем GUI
	local shopGui = gui:Clone()
	shopGui.Parent = player.PlayerGui
	print("Магазин открыт!")
end)
