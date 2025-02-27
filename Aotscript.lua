-- تعريف الخدمات
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- إعدادات السكريبت
local Aimbot = {
    Settings = {
        Enabled = false,           -- حالة السكريبت (معطل افتراضيًا حتى تفعيله عبر GUI)
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
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Aimbot Control"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.BorderSizePixel = 0
Title.Parent = Frame

local EnableButton = Instance.new("TextButton")
EnableButton.Size = UDim2.new(0, 80, 0, 30)
EnableButton.Position = UDim2.new(0, 10, 0, 40)
EnableButton.Text = "Enable"
EnableButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
EnableButton.Parent = Frame

local DisableButton = Instance.new("TextButton")
DisableButton.Size = UDim2.new(0, 80, 0, 30)
DisableButton.Position = UDim2.new(0, 110, 0, 40)
DisableButton.Text = "Disable"
DisableButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DisableButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
DisableButton.Parent = Frame

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

-- ربط الأزرار بوظائف
EnableButton.MouseButton1Click:Connect(function()
    Aimbot.Settings.Enabled = true
    StartAimbot()
    print("Aimbot Enabled")
end)

DisableButton.MouseButton1Click:Connect(function()
    Aimbot.Settings.Enabled = false
    StopAimbot()
    print("Aimbot Disabled")
end)

-- تنظيف السكريبت عند الخروج
local function Exit()
    StopAimbot()
    ScreenGui:Destroy()
end

-- بدء السكريبت
print("Aimbot GUI Loaded. Use the buttons to control.")
return Aimbot
