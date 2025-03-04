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
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait(2)
end)
if success and character then
    local success, humanoidRoot = pcall(function()
        return character:FindFirstChild("HumanoidRootPart")
    end)
    if success and humanoidRoot then
        playerPosition = tostring(humanoidRoot.Position)
    end
end
print("Player Position: " .. playerPosition)

print("=== End of Basic Information ===")
