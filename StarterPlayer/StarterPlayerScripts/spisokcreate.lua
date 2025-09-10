local Players = game:GetService("Players")
local remoteEvent = game.ReplicatedStorage.OpenWeaponShop
local gui = game.ReplicatedStorage.WeaponShopGUI
local weaponData = require(game.ReplicatedStorage.WeaponData)
local player = Players.LocalPlayer

local function createWeaponFrame(weaponName, data, parent)
	local template = gui.MainFrame.WeaponList.WeaponTemplate
	local frame = template:Clone()
	frame.Name = weaponName
	frame.Visible = true
	frame.Parent = parent

	-- Заполняем данные
	frame.WeaponName.Text = data.Name
	frame.Price.Text = data.Price .. " " .. data.Currency

	-- Простая иконка из цвета оружия
	local weapon = game.ReplicatedStorage.Weapons[weaponName]
	if weapon and weapon.Handle then
		frame.WeaponIcon.BackgroundColor3 = weapon.Handle.Color
	end

	-- Кнопка покупки/экипировки
	if data.Price == 0 then
		frame.BuyButton.Text = "FREE"
		frame.BuyButton.BackgroundColor3 = Color3.new(0, 1, 0) -- зеленый
	else
		frame.BuyButton.Text = "BUY " .. data.Price
		frame.BuyButton.BackgroundColor3 = Color3.new(0, 0.5, 1) -- синий
	end

	return frame
end

local function loadWeaponShop(shopGui)
	local weaponList = shopGui.MainFrame.WeaponList

	-- Очищаем старые элементы
	for _, child in pairs(weaponList:GetChildren()) do
		if child.Name ~= "WeaponTemplate" and child:IsA("Frame") then
			child:Destroy()
		end
	end

	-- Добавляем все оружие
	for weaponName, data in pairs(weaponData) do
		local frame = createWeaponFrame(weaponName, data, weaponList)

		-- Подключаем функцию покупки
		frame.BuyButton.MouseButton1Click:Connect(function()
			print("Покупка:", weaponName)
			-- Тут будет логика покупки
		end)
	end
end

remoteEvent.OnClientEvent:Connect(function()
	local existingShop = player.PlayerGui:FindFirstChild("WeaponShopGUI")
	if existingShop then return end

	local shopGui = gui:Clone()
	shopGui.Parent = player.PlayerGui

	-- Загружаем оружие в магазин
	loadWeaponShop(shopGui)
end)
