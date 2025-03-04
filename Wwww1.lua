local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local AimbotEnabled = false
local ESPEnabled = false
local FOVRadius = 100
local ESPInstances = {}

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 120)
MainFrame.Position = UDim2.new(0.5, -100, 0, 20)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.5
MainFrame.ZIndex = 2

local ToggleAimbotButton = Instance.new("TextButton", MainFrame)
ToggleAimbotButton.Size = UDim2.new(1, 0, 0.4, 0)
ToggleAimbotButton.BackgroundColor3 = Color3.new(1, 0, 0)
ToggleAimbotButton.Text = "Toggle Aimbot"
ToggleAimbotButton.TextColor3 = Color3.new(1, 1, 1)
ToggleAimbotButton.TextScaled = true
ToggleAimbotButton.ZIndex = 3

local ToggleESPButton = Instance.new("TextButton", MainFrame)
ToggleESPButton.Size = UDim2.new(1, 0, 0.4, 0)
ToggleESPButton.Position = UDim2.new(0, 0, 0.4, 0)
ToggleESPButton.BackgroundColor3 = Color3.new(0, 0, 1)
ToggleESPButton.Text = "Toggle ESP"
ToggleESPButton.TextColor3 = Color3.new(1, 1, 1)
ToggleESPButton.TextScaled = true
ToggleESPButton.ZIndex = 3

local CreditLabel = Instance.new("TextLabel", MainFrame)
CreditLabel.Size = UDim2.new(1, 0, 0.2, 0)
CreditLabel.Position = UDim2.new(0, 0, 0.8, 0)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "Made by Chris Carl Ebol Gaming | Press H to Toggle"
CreditLabel.TextColor3 = Color3.new(1, 1, 1)
CreditLabel.TextSize = 14
CreditLabel.ZIndex = 10

local function toggleAimbot()
    AimbotEnabled = not AimbotEnabled
    ToggleAimbotButton.Text = AimbotEnabled and "Aimbot On" or "Aimbot Off"
end

local function toggleESP()
    ESPEnabled = not ESPEnabled
    ToggleESPButton.Text = ESPEnabled and "ESP On" or "ESP Off"
    for _, highlight in pairs(ESPInstances) do
        highlight:Destroy()
    end
    ESPInstances = {}
    
    if ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                updateESPForPlayer(player)
            end
            player.CharacterAdded:Connect(function(character)
                if ESPEnabled and player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
                    task.wait(0.1) -- انتظار للتأكد من تحميل الشخصية
                    updateESPForPlayer(player)
                end
            end)
        end
    end
end

local function updateESPForPlayer(player)
    if player.Character and player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
        local highlight = Instance.new("Highlight", player.Character)
        highlight.Name = "ESP"
        highlight.FillColor = Color3.new(1, 0, 0)
        highlight.OutlineColor = Color3.new(0, 0, 0)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        ESPInstances[player] = highlight
        
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                if ESPInstances[player] then
                    ESPInstances[player]:Destroy()
                    ESPInstances[player] = nil
                end
            end)
        end
    end
end

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Team ~= LocalPlayer.Team then
            local characterPosition = player.Character.HumanoidRootPart.Position
            local screenPosition, onScreen = Camera:WorldToViewportPoint(characterPosition)
            if onScreen then
                local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPosition.X, screenPosition.Y)).Magnitude
                if distance < closestDistance and distance < FOVRadius then
                    closestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    return closestPlayer
end

local function aimAtClosestPlayer()
    if AimbotEnabled then
        local closestPlayer = getClosestPlayer()
        if closestPlayer and closestPlayer.Character then
            local targetPart = closestPlayer.Character:FindFirstChild("Head") or closestPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local targetPosition = targetPart.Position
                local direction = (targetPosition - Camera.CFrame.Position).unit
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + direction)
            end
        end
    end
end

ToggleAimbotButton.MouseButton1Click:Connect(toggleAimbot)
ToggleESPButton.MouseButton1Click:Connect(toggleESP)
RunService.RenderStepped:Connect(aimAtClosestPlayer)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.H then
        toggleESP()
        toggleAimbot()
    end
end)

local dragging = false
local dragStart = nil
local startPos = nil
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
