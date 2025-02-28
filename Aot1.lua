-- تعريف المتغيرات الأساسية
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- مكتبة واجهة المستخدم (GUI Library) - هنا مثال بسيط بدون مكتبة خارجية
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "AOTScriptGui"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local KillButton = Instance.new("TextButton", Frame)
KillButton.Size = UDim2.new(0, 180, 0, 40)
KillButton.Position = UDim2.new(0, 10, 0, 10)
KillButton.Text = "Kill All Titans"
KillButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)

local TeleportToggle = Instance.new("TextButton", Frame)
TeleportToggle.Size = UDim2.new(0, 180, 0, 40)
TeleportToggle.Position = UDim2.new(0, 10, 0, 60)
TeleportToggle.Text = "Auto TP: OFF"
TeleportToggle.BackgroundColor3 = Color3.fromRGB(0, 100, 0)

-- متغيرات التحكم
local AutoTeleport = false
local MaxDistance = 500 -- أقصى مسافة لاستهداف العمالقة

-- دالة للعثور على أقرب عملاق
local function GetNearestTitan()
    local nearestTitan = nil
    local shortestDistance = MaxDistance

    -- ابحث في مجلد العمالقة (افترض أنه يسمى "Titans" في Workspace)
    for _, titan in pairs(Workspace:WaitForChild("Titans"):GetChildren()) do
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
        humanoid.Health = 0 -- تقليل الصحة إلى 0 لقتل العملاق
    end
end

-- زر قتل جميع العمالقة
KillButton.MouseButton1Click:Connect(function()
    for _, titan in pairs(Workspace:WaitForChild("Titans"):GetChildren()) do
        KillTitan(titan)
    end
    print("Killed all Titans!")
end)

-- زر تفعيل/تعطيل الانتقال التلقائي
TeleportToggle.MouseButton1Click:Connect(function()
    AutoTeleport = not AutoTeleport
    TeleportToggle.Text = "Auto TP: " .. (AutoTeleport and "ON" or "OFF")
    TeleportToggle.BackgroundColor3 = AutoTeleport and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 100, 0)
end)

-- حلقة الانتقال التلقائي
RunService.RenderStepped:Connect(function()
    if AutoTeleport and Character and HumanoidRootPart then
        local titan = GetNearestTitan()
        if titan then
            local titanRoot = titan:FindFirstChild("HumanoidRootPart")
            if titanRoot then
                -- الانتقال إلى نقطة خلف رقبة العملاق (Nape)
                local targetPosition = titanRoot.Position + Vector3.new(0, 5, -2) -- فوق وخلف العملاق
                HumanoidRootPart.CFrame = CFrame.new(targetPosition)
            end
        end
    end
end)

-- رسالة تأكيد
print("Attack on Titan Script Loaded!")
