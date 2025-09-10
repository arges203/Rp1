-- spisokcreate.lua (переименуйте в WeaponShopHandler.lua)
local Players = game:GetService("Players")
local remoteEvent = game.ReplicatedStorage.OpenWeaponShop
local equipEvent = game.ReplicatedStorage.EquipWeapon  -- ДОБАВЬТЕ!
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
