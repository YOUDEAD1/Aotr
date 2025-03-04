local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

-- التحقق من اللعبة
local placeId = game.PlaceId
print("Place ID: " .. tostring(placeId))

-- محاولة الحصول على اسم اللعبة
local success, gameInfo = pcall(function()
    return MarketplaceService:GetProductInfo(placeId, Enum.InfoType.Asset)
end)
if success then
    print("Game Name: " .. (gameInfo and gameInfo.Name or "Unknown"))
else
    print("Game Name: Could not fetch (Error: " .. tostring(gameInfo) .. ")")
end

-- معلومات اللاعب
local playerName = LocalPlayer.Name
local playerUserId = LocalPlayer.UserId
print("Player Name: " .. playerName)
print("Player User ID: " .. tostring(playerUserId))

-- محاولة الحصول على موقع اللاعب
local playerCharacter = nil
local playerPosition = "No character or HumanoidRootPart found"
local success, character = pcall(function()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(5) -- زيادة الانتظار إلى 5 ثوانٍ
end)
if success and character then
    local humanoidRootPaths = {"HumanoidRootPart", "Torso", "RootPart"} -- مسارات بديلة
    local foundHumanoidRoot = nil
    for _, path in pairs(humanoidRootPaths) do
        local success, humanoidRoot = pcall(function()
            return character:FindFirstChild(path)
        end)
        if success and humanoidRoot then
            foundHumanoidRoot = humanoidRoot
            break
        end
    end
    if foundHumanoidRoot then
        playerPosition = tostring(foundHumanoidRoot.Position)
    end
    playerCharacter = character
end
print("Player Position: " .. playerPosition)

-- محاولة الحصول على بيانات اللاعب (PlayerData) مع مسارات بديلة
local playerData = nil
local playerDataPaths = {"PlayerData", "Stats.PlayerData", "Data.PlayerData", "Values.PlayerData"}
for _, path in pairs(playerDataPaths) do
    local success, data = pcall(function()
        local parts = path:split(".")
        local current = LocalPlayer
        for _, part in pairs(parts) do
            current = current:WaitForChild(part, 5) or current:FindFirstChild(part)
            if not current then return nil end
        end
        return current
    end)
    if success and data then
        playerData = data
        break
    end
end
print("Player Data Found: " .. (playerData and "Yes" or "No"))
if playerData then
    for _, child in pairs(playerData:GetChildren()) do
        print("Player Data - " .. child.Name .. ": " .. tostring(child.Value))
    end
end

-- محاولة الحصول على SpinSystem مع مسارات بديلة
local spinSystem = nil
local spinSystemPaths = {"SpinSystem", "Events.SpinSystem", "Systems.SpinSystem", "Remote.SpinSystem"}
for _, path in pairs(spinSystemPaths) do
    local success, system = pcall(function()
        local parts = path:split(".")
        local current = ReplicatedStorage
        for _, part in pairs(parts) do
            current = current:WaitForChild(part, 5) or current:FindFirstChild(part)
            if not current then return nil end
        end
        return current
    end)
    if success and system then
        spinSystem = system
        break
    end
end
print("SpinSystem Found: " .. (spinSystem and "Yes" or "No"))
if spinSystem then
    for _, child in pairs(spinSystem:GetChildren()) do
        print("SpinSystem - " .. child.Name .. ": " .. tostring(child.ClassName))
    end
end

-- محاولة الحصول على الكاميرا
local camera = nil
local success, cam = pcall(function()
    return workspace:WaitForChild("CurrentCamera", 5)
end)
if success and cam then
    camera = cam
    print("Camera Found: Yes")
    print("Camera Position: " .. tostring(camera.CFrame.Position))
else
    print("Camera Found: No")
end

-- عدد اللاعبين في اللعبة
local playerCount = #Players:GetPlayers()
print("Total Players in Game: " .. tostring(playerCount))

print("=== End of Detailed Information ===")
