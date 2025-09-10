-- Универсальная система кулдаунов для всех GUI
local Players = game:GetService("Players")
local cooldowns = {}

-- Создаем универсальный RemoteEvent
local guiClosedEvent = Instance.new("RemoteEvent")
guiClosedEvent.Name = "GUIClosedEvent"
guiClosedEvent.Parent = game.ReplicatedStorage

-- Функция проверки кулдауна (для всех скриптов)
local function isOnCooldown(player, guiType)
	return cooldowns[player] and cooldowns[player][guiType] ~= nil
end

-- Функция установки кулдауна
local function setCooldown(player, guiType, time)
	if not cooldowns[player] then
		cooldowns[player] = {}
	end

	cooldowns[player][guiType] = true
	spawn(function()
		wait(time)
		if cooldowns[player] then
			cooldowns[player][guiType] = nil
		end
	end)
end

-- Обработка закрытия любого GUI
guiClosedEvent.OnServerEvent:Connect(function(player, guiType, cooldownTime)
	setCooldown(player, guiType, cooldownTime or 5) -- по умолчанию 5 сек
end)

-- Публичная функция для других скриптов
_G.IsGUIOnCooldown = isOnCooldown
