local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- الحصول على معلومات اللعبة
local placeId = game.PlaceId
local gameInfo, gameInfoError = pcall(function()
    return MarketplaceService:GetProductInfo(placeId)
end)

-- معلومات اللاعب
local playerName = LocalPlayer.Name
local playerUserId = LocalPlayer.UserId
local playerCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local playerPosition = playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart") and playerCharacter.HumanoidRootPart.Position or "No character or HumanoidRootPart found"

-- محاولة الحصول على بيانات اللاعب (مثل PlayerData إذا موجودة)
local playerData = nil
local success, data = pcall(function()
    return LocalPlayer:FindFirstChild("PlayerData") or LocalPlayer:WaitForChild("PlayerData", 5)
end)
if success and data then
    playerData = data
end

-- محاولة الحصول على SpinSystem إذا موجود
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
if gameInfoError then
    print("Game Name: Could not fetch game name (Error: " .. tostring(gameInfoError) .. ")")
else
    print("Game Name: " .. (gameInfo and gameInfo.Name or "Unknown"))
end
print("Player Name: " .. playerName)
print("Player User ID: " .. tostring(playerUserId))
print("Player Position: " .. tostring(playerPosition))
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
