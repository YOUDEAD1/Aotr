-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Aimbot & Hacks", "DarkTheme")

-- إظهار وإخفاء القائمة بزر RightShift
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Window:Toggle()
    end
end)

-- إضافة زر لإخفاء وإظهار القائمة
local ToggleButtonTab = Window:NewTab("Toggle")
local ToggleButtonSection = ToggleButtonTab:NewSection("Control UI")

ToggleButtonSection:NewButton("Hide/Show UI", "إخفاء/إظهار واجهة المستخدم", function()
    Window:Toggle()  -- هذا يقوم بإخفاء أو إظهار الواجهة عندما يتم الضغط على الزر
end)

-- تعريف الخدمات
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

-- إعدادات السكربت
local Aimbot = {
    Enabled = false,
    Locked = nil,
    ESPEnabled = true,
    HitboxSize = 15,  -- تكبير حجم المربع حول العدو
    Highlights = {}   -- لتخزين الأعداء الذين تم تسليط الضوء عليهم
}

local SpeedHack = 16  -- السرعة الافتراضية
local WallHack = false
local FlyEnabled = false  -- لتفعيل الطيران

-- واجهة Aimbot
local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Settings")

AimbotSection:NewToggle("Enable Aimbot", "تفعيل/إيقاف Aimbot", function(state)
    Aimbot.Enabled = state
end)

AimbotSection:NewToggle("Enable ESP", "تفعيل/إيقاف رؤية الأعداء", function(state)
    Aimbot.ESPEnabled = state
end)

AimbotSection:NewSlider("Hitbox Size", "تحكم في حجم المربع حول الأعداء", 30, 10, function(value)
    Aimbot.HitboxSize = value
end)

-- واجهة السرعة
local SpeedTab = Window:NewTab("Speed Hack")
local SpeedSection = SpeedTab:NewSection("Control Speed")

SpeedSection:NewSlider("Speed", "تحكم في سرعة اللاعب", 200, 1, function(value)
    SpeedHack = value
    if Humanoid then
        Humanoid.WalkSpeed = SpeedHack
    end
end)

-- واجهة اختراق الجدران
local WallHackTab = Window:NewTab("Wall Hack")
local WallHackSection = WallHackTab:NewSection("Wall Hack Settings")

WallHackSection:NewToggle("Enable Wall Hack", "تفعيل/إيقاف اختراق الجدران", function(state)
    WallHack = state
    if WallHack then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    else
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
    end
end)

-- واجهة الطيران
local FlyTab = Window:NewTab("Flight")
local FlySection = FlyTab:NewSection("Flight Settings")

FlySection:NewToggle("Enable Flight", "تفعيل/إيقاف الطيران", function(state)
    FlyEnabled = state
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if FlyEnabled then
            if humanoid then
                humanoid.PlatformStand = true  -- تعطيل الحركة العادية
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
                bodyVelocity.Velocity = Vector3.new(0, 50, 0)  -- تعديل الارتفاع
                bodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart")
            end
        else
            if humanoid then
                humanoid.PlatformStand = false  -- استعادة الحركة العادية
                local bodyVelocity = character:FindFirstChild("HumanoidRootPart"):FindFirstChildOfClass("BodyVelocity")
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
            end
        end
    end
end)

-- دالة ESP مع المربع الكبير (Hitbox)
local function UpdateESP()
    -- حذف أي Highlights موجودة سابقًا
    for _, highlight in pairs(Aimbot.Highlights) do
        highlight:Destroy()
    end
    Aimbot.Highlights = {}

    -- المرور على جميع اللاعبين
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local head = character and character:FindFirstChild("Head")

            if character and humanoid and head and humanoid.Health > 0 then
                -- إنشاء Highlight للأعداء
                local highlight = Instance.new("Highlight")
                highlight.Adornee = character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)  -- تغيير اللون إلى الأحمر
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)  -- لون الإطار الأبيض
                highlight.FillTransparency = 0.5  -- شفافية ملء اللون
                highlight.OutlineTransparency = 0.8  -- شفافية الإطار
                highlight.Parent = character

                -- إضافة إلى قائمة Highlights
                table.insert(Aimbot.Highlights, highlight)
            end
        end
    end
end

-- دالة للحصول على أقرب عدو
local function GetClosestEnemy()
    local closestDistance = 90
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

-- دالة لإطلاق الشعاع على العدو مع تجاهل الجدران
local function ShootAtEnemy(target)
    local rayOrigin = Camera.CFrame.Position
    local rayDirection = (target.Character.Head.Position - rayOrigin).unit * 500

    -- تحديد الكائنات التي سيتم تجاهلها (الجدران)
    local ignoreList = {LocalPlayer.Character, target.Character}

    -- استخدام Raycasting مع تجاهل الجدران
    local hitPart, hitPosition = workspace:FindPartOnRayWithIgnoreList(Ray.new(rayOrigin, rayDirection), ignoreList)

    if hitPart and hitPart.Parent == target.Character then
        -- هنا يمكنك إضافة الكود لإصابة العدو أو تأثير الهجوم
        print("Target hit!")
    end
end

-- تشغيل Aimbot وESP
local function StartAimbot()
    RunService.RenderStepped:Connect(function()
        if Aimbot.Enabled then
            local target = GetClosestEnemy()
            if target then
                local headPos = target.Character.Head.Position
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, headPos)
                Aimbot.Locked = target
                -- إطلاق الشعاع تجاه العدو
                ShootAtEnemy(target)
            else
                Aimbot.Locked = nil
            end
        end
    end)

    if Aimbot.ESPEnabled then
        RunService.RenderStepped:Connect(UpdateESP)
    end
end

StartAimbot()

print("✅ Script Loaded Successfully! Press RightShift to toggle UI.")
