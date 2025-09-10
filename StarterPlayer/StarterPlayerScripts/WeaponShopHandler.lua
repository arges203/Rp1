local function createWeaponFrame(weaponName, data, parent)
	local shopGui = parent.Parent.Parent
	local template = shopGui.MainFrame.WeaponList.WeaponTemplate

	local frame = template:Clone()
	frame.Name = weaponName
	frame.Visible = true
	frame.Parent = parent

	-- Заполняем данные
	frame.WeaponName.Text = data.Name
	frame.BuyButton.Text = data.Price == 0 and "FREE" or "BUY " .. data.Price

	-- СРАЗУ подключаем кнопку при создании
	frame.BuyButton.MouseButton1Click:Connect(function()
		print("Покупка:", weaponName)
		game.ReplicatedStorage.EquipWeapon:FireServer(weaponName)
		shopGui:Destroy() -- закрываем магазин
	end)

	return frame
end
local Players = game:GetService("Players")
local remoteEvent = game.ReplicatedStorage.OpenWeaponShop
local equipEvent = game.ReplicatedStorage.EquipWeapon 
local gui = game.ReplicatedStorage.WeaponShopGUI
local weaponData = require(game.ReplicatedStorage.WeaponData)
local player = Players.LocalPlayer

-- createWeaponFrame остается тот же...

local function loadWeaponShop(shopGui)
    local weaponList = shopGui.MainFrame.WeaponList
    
    for _, child in pairs(weaponList:GetChildren()) do
        if child.Name ~= "WeaponTemplate" and child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    for weaponName, data in pairs(weaponData) do
        local frame = createWeaponFrame(weaponName, data, weaponList)
        
        -- ИСПРАВЬТЕ КНОПКУ:
        frame.BuyButton.MouseButton1Click:Connect(function()
            print("Покупка:", weaponName)
            equipEvent:FireServer(weaponName)  -- ДОБАВЬТЕ!
            shopGui:Destroy()  -- ДОБАВЬТЕ!
        end)
    end
end

remoteEvent.OnClientEvent:Connect(function()
    local existingShop = player.PlayerGui:FindFirstChild("WeaponShopGUI")
    if existingShop then return end
    
    local shopGui = gui:Clone()
    shopGui.Parent = player.PlayerGui
    loadWeaponShop(shopGui)  -- СОЗДАЕМ ОРУЖИЕ!
end)
