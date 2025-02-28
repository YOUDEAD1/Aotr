-- تأكد من أن الخدمات متوفرة
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- التحقق من وجود الشخصية
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- إنشاء واجهة المستخدم (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "AOTScriptGui"

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BorderSizePixel = 0

local KillButton = Instance.new("TextButton")
KillButton.Parent = Frame
KillButton.Size = UDim2.new(0, 180, 0, 40)
KillButton.Position = UDim2.new(0, 10, 0, 10)
KillButton.Text = "Kill All Titans"
KillButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
KillButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KillButton.Font = Enum.Font.SourceSans
KillButton.TextSize = 18

local TeleportToggle = Instance.new("TextButton")
TeleportToggle.Parent = Frame
TeleportToggle.Size = UDim2.new(0, 180, 0, 40)
TeleportToggle.Position = UDim2.new(0, 10, 0, 60)
TeleportToggle.Text = "Auto TP: OFF"
TeleportToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
TeleportToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportToggle.Font = Enum.Font.SourceSans
TeleportToggle.TextSize = 18

-- متغيرات التحكم
local AutoTeleport = false
local MaxDistance = 500 -- أقصى مسافة لاستهداف العمالقة

-- دالة للعثور على أقرب عملاق
local function GetNearestTitan()
    local nearestTitan = nil
    local shortestDistance = MaxDistance

    -- البحث في مجلد العمالقة (افتراضي: "Titans")
    local titansFolder = Workspace:FindFirstChild("Titans")
    if not titansFolder then
        warn("Titans folder not found! Check the game structure.")
        return nil
    end

    for _, titan in pairs(titansFolder:GetChildren()) do
        local titanRoot = titan:FindFirstChild("HumanoidRootPart")
        local titanHumanoid = titan:FindFirstChild("Humanoid")
        
        if titanRoot and titanHumanoid and titanHumanoid.Health > 0 then
            local distance = (HumanoidRootPart.Position - titanRoot.Position).Magnitude
            if distance < shortestDistance then
                nearestTitan = titan
                shortestDistance = distance
            end
        end
    end
    return nearestTitan
end

-- دالة لقتل عملاق
local function KillTitan(titan)
    local humanoid = titan:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health > 0 then
        humanoid.Health = 0 -- قتل العملاق بتقليل الصحة إلى 0
        print("Killed Titan: " .. titan.Name)
    end
end

-- حدث زر قتل جميع العمالقة
KillButton.MouseButton1Click:Connect(function()
    local titansFolder = Workspace:FindFirstChild("Titans")
    if titansFolder then
        for _, titan in pairs(titansFolder:GetChildren()) do
            KillTitan(titan)
        end
        print("All Titans killed!")
    else
        warn("No Titans folder found!")
    end
end)

-- حدث تفعيل/تعطيل الانتقال التلقائي
TeleportToggle.MouseButton1Click:Connect(function()
    AutoTeleport = not AutoTeleport
    TeleportToggle.Text = "Auto TP: " .. (AutoTeleport and "ON" or "OFF")
    TeleportToggle.BackgroundColor3 = AutoTeleport and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 100, 0)
    print("Auto Teleport: " .. (AutoTeleport and "Enabled" or "Disabled"))
end)

-- حلقة الانتقال التلقائي
RunService.RenderStepped:Connect(function()
    if AutoTeleport and Character and HumanoidRootPart then
        local titan = GetNearestTitan()
        if titan then
            local titanRoot = titan:FindFirstChild("HumanoidRootPart")
            if titanRoot then
                -- الانتقال خلف رقبة العملاق
                local targetPosition = titanRoot.Position + Vector3.new(0, 5, -2)
                HumanoidRootPart.CFrame = CFrame.new(targetPosition)
            end
        end
    end
end)

-- رسالة تأكيد التحميل
print("Attack on Titan Script loaded successfully for Xeno Executor!")
