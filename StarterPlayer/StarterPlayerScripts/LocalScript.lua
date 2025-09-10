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
