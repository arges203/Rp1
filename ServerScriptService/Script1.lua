local Players = game:GetService("Players")
local equipEvent = game.ReplicatedStorage:WaitForChild("EquipWeapon")

equipEvent.OnServerEvent:Connect(function(player, weaponName)
	print(player.Name .. " запросил оружие:", weaponName)

	-- Убираем старое оружие
	for _, tool in pairs(player.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			tool:Destroy()
		end
	end

	-- Убираем оружие из рук если есть
	if player.Character then
		for _, tool in pairs(player.Character:GetChildren()) do
			if tool:IsA("Tool") then
				tool:Destroy()
			end
		end
	end

	-- Даем новое оружие
	local weapon = game.ReplicatedStorage.Weapons:FindFirstChild(weaponName)
	if weapon then
		local newWeapon = weapon:Clone()
		newWeapon.Parent = player.Backpack
		print("Выдал", weaponName, "игроку", player.Name)
	else
		warn("Оружие не найдено:", weaponName)
	end
end)
