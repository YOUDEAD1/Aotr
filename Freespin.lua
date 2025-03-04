local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- التحقق من اللعبة
local placeId = game.PlaceId
local success, gameInfo = pcall(function()
    return MarketplaceService:GetProductInfo(placeId)
end)

-- معلومات اللاعب
local playerName = LocalPlayer.Name
local playerUserId = LocalPlayer.UserId
local playerCharacter = nil
local playerPosition = "No character or HumanoidRootPart found"

local success, character = pcall(function()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(5)
end)
if success and character then
    local success, humanoidRoot = pcall(function()
        return character:FindFirstChild("HumanoidRootPart")
    end)
    if success and humanoidRoot then
        playerPosition = tostring(humanoidRoot.Position)
    end
    playerCharacter = character
end

-- محاولة الحصول على بيانات اللاعب (PlayerData) مع توقيت محدود
local playerData = nil
local success, data = pcall(function()
    return LocalPlayer:FindFirstChild("PlayerData") or LocalPlayer:WaitForChild("PlayerData", 5)
end)
if success and data then
    playerData = data
end

-- محاولة الحصول على SpinSystem مع توقيت محدود
local spinSystem = nil
local success, system = pcall(function()
    return ReplicatedStorage:WaitForChild("SpinSystem", 5)
end)
if success and system then
    spinSystem = system
end

-- طباعة المعلومات
print("=== Game and Player Information ===")
print("Place ID: " .. tostring(placeId))
if success then
    print("Game Name: " .. (gameInfo and gameInfo.Name or "Unknown"))
else
    print("Game Name: Could not fetch game name (Error: " .. tostring(gameInfo) .. ")")
end
print("Player Name: " .. playerName)
print("Player User ID: " .. tostring(playerUserId))
print("Player Position: " .. playerPosition)
print("Player Data Found: " .. (playerData and "Yes" or "No"))
if playerData then
    for _, child in pairs(playerData:GetChildren()) do
        print("Player Data - " .. child.Name .. ": " .. tostring(child.Value))
    end
end
print("SpinSystem Found: " .. (spinSystem and "Yes" or "No"))
if spinSystem then
    for _, child in pairs(spinSystem:GetChildren()) do
        print("SpinSystem - " .. child.Name .. ": " .. tostring(child.ClassName))
    end
end
print("==================================")
