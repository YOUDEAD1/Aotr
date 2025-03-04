local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

-- التحقق من اللعبة
local placeId = game.PlaceId
local success, gameInfo = pcall(function()
    return MarketplaceService:GetProductInfo(placeId, Enum.InfoType.Asset)
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
local playerDataPaths = {"PlayerData", "Stats.PlayerData", "Data.PlayerData"}
for _, path in pairs(playerDataPaths) do
    local success, data = pcall(function()
        local parts = path:split(".")
        local current = LocalPlayer
        for _, part in pairs(parts) do
            current = current:WaitForChild(part, 2) or current:FindFirstChild(part)
            if not current then return nil end
        end
        return current
    end)
    if success and data then
        playerData = data
        break
    end
end

-- محاولة الحصول على SpinSystem مع توقيت محدود
local spinSystem = nil
local spinSystemPaths = {"SpinSystem", "Events.SpinSystem", "Systems.SpinSystem"}
for _, path in pairs(spinSystemPaths) do
    local success, system = pcall(function()
        local parts = path:split(".")
        local current = ReplicatedStorage
        for _, part in pairs(parts) do
            current = current:WaitForChild(part, 2) or current:FindFirstChild(part)
            if not current then return nil end
        end
        return current
    end)
    if success and system then
        spinSystem = system
        break
    end
end

-- محاولة الحصول على الكاميرا واللاعبين
local camera = nil
local success, cam = pcall(function()
    return workspace:WaitForChild("CurrentCamera", 2)
end)
if success and cam then
    camera = cam
end

local playerCount = #Players:GetPlayers()

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
print("Camera Found: " .. (camera and "Yes" or "No"))
if camera then
    print("Camera Position: " .. tostring(camera.CFrame.Position))
end
print("Total Players in Game: " .. tostring(playerCount))
print("==================================")
