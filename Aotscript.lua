-- تعريف الخدمات
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- إعدادات السكريبت
local Aimbot = {
    Enabled = false,           -- حالة السكريبت
    Locked = nil,              -- الهدف المقفل
    Connections = {}           -- تخزين الاتصالات
}

-- إنشاء GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AimbotGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 150, 0, 40)
Frame.Position = UDim2.new(0, 10, 0, 10) -- أعلى يسار
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 1, 0)
StatusLabel.Text = "Aimbot: OFF (P)"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StatusLabel.TextScaled = true
StatusLabel.Parent = Frame

-- دالة للحصول على أقرب عدو
local function GetClosestEnemy()
    local closestDistance = 90 -- نطاق الرؤية
    local closestEnemy = nil
    local mousePos = UserInputService:GetMouseLocation()

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local character = player.Character
            local head = character and character:FindFirstChild("Head")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")

            if head and humanoid and humanoid.Health > 0 then
                local headPos = head.Position
                local screenPos, onScreen = Camera:WorldToViewportPoint(headPos)
                local distance = (mousePos - Vector2.new(screenPos.X, screenPos.Y)).Magnitude

                if distance < closestDistance and onScreen then
                    closestDistance = distance
                    closestEnemy = player
                end
            end
        end
    end
    return closestEnemy
end

-- تشغيل Aimbot
local function StartAimbot()
    Aimbot.Connections.RenderStepped = RunService.RenderStepped:Connect(function()
        if Aimbot.Enabled then
            Aimbot.Locked = GetClosestEnemy()
            if Aimbot.Locked then
                local headPos = Aimbot.Locked.Character.Head.Position
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, headPos)
            end
        end
    end)
end

-- إيقاف Aimbot
local function StopAimbot()
    Aimbot.Locked = nil
    if Aimbot.Connections.RenderStepped then
        Aimbot.Connections.RenderStepped:Disconnect()
    end
end

-- التحكم بمفتاح P
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        Aimbot.Enabled = not Aimbot.Enabled
        if Aimbot.Enabled then
            StartAimbot()
            StatusLabel.Text = "Aimbot: ON (P)"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            print("Aimbot Enabled")
        else
            StopAimbot()
            StatusLabel.Text = "Aimbot: OFF (P)"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            print("Aimbot Disabled")
        end
    end
end)

-- بدء السكريبت
print("Aimbot Loaded. Press P to toggle.")
