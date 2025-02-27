-- تعريف الخدمات
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- إعدادات السكريبت
local Aimbot = {
    Settings = {
        Enabled = false,           -- حالة السكريبت (معطل افتراضيًا)
        TeamCheck = true,          -- التحقق من الفريق
        AliveCheck = true,         -- التحقق من الحياة
        LockPart = "Head",         -- الجزء المستهدف
        Sensitivity = 0.05,        -- سرعة القفل
    },
    FOVSettings = {
        Enabled = true,
        Radius = 90,               -- نطاق الرؤية
    },
    Locked = nil,                  -- الهدف المقفل
    Running = false,               -- حالة التشغيل
    Connections = {}               -- تخزين الاتصالات
}

-- إنشاء واجهة المستخدم (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AimbotGUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 50)
Frame.Position = UDim2.new(0, 10, 0, 10) -- أعلى يسار (10 من اليسار، 10 من الأعلى)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 1, 0)
StatusLabel.Position = UDim2.new(0, 0, 0, 0)
StatusLabel.Text = "Aimbot: OFF (Press P to toggle)"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StatusLabel.BorderSizePixel = 0
StatusLabel.TextScaled = true
StatusLabel.Parent = Frame

-- دالة لتحويل Vector3 إلى Vector2
local function ConvertVector(Vector)
    return Vector2.new(Vector.X, Vector.Y)
end

-- إلغاء القفل
local function CancelLock()
    Aimbot.Locked = nil
end

-- الحصول على أقرب عدو
local function GetClosestPlayer()
    local Settings = Aimbot.Settings
    local LockPart = Settings.LockPart
    local RequiredDistance = Aimbot.FOVSettings.Radius
    Aimbot.Locked = nil

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local targetPart = character and character:FindFirstChild(LockPart)

            if character and humanoid and targetPart then
                -- التحقق من الفريق
                if Settings.TeamCheck and player.Team == LocalPlayer.Team then
                    continue
                end
                -- التحقق من الحياة
                if Settings.AliveCheck and humanoid.Health <= 0 then
                    continue
                end

                local partPosition = targetPart.Position
                local vector, onScreen = Camera:WorldToViewportPoint(partPosition)
                local distance = (ConvertVector(vector) - UserInputService:GetMouseLocation()).Magnitude

                if distance < RequiredDistance and onScreen then
                    RequiredDistance = distance
                    Aimbot.Locked = player
                end
            end
        end
    end
end

-- دالة تشغيل Aimbot
local function StartAimbot()
    if not Aimbot.Settings.Enabled then return end
    Aimbot.Running = true
    Aimbot.Connections.RenderStepped = RunService.RenderStepped:Connect(function()
        if Aimbot.Settings.Enabled and Aimbot.Running then
            GetClosestPlayer()
            if Aimbot.Locked then
                local targetPos = Aimbot.Locked.Character[Aimbot.Settings.LockPart].Position
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), Aimbot.Settings.Sensitivity)
            end
        end
    end)
end

-- دالة إيقاف Aimbot
local function StopAimbot()
    Aimbot.Running = false
    CancelLock()
    if Aimbot.Connections.RenderStepped then
        Aimbot.Connections.RenderStepped:Disconnect()
    end
end

-- التحكم بمفتاح P
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        Aimbot.Settings.Enabled = not Aimbot.Settings.Enabled
        if Aimbot.Settings.Enabled then
            StartAimbot()
            StatusLabel.Text = "Aimbot: ON (Press P to toggle)"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            print("Aimbot Enabled")
        else
            StopAimbot()
            StatusLabel.Text = "Aimbot: OFF (Press P to toggle)"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            print("Aimbot Disabled")
        end
    end
end)

-- تنظيف السكريبت عند الخروج
local function Exit()
    StopAimbot()
    ScreenGui:Destroy()
end

-- بدء السكريبت
print("Aimbot GUI Loaded. Press P to toggle.")
return Aimbot
