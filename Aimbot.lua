-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Aimbot & Hacks", "DarkTheme")

-- إعداد زر إخفاء الواجهة بجانب "X" (زر خارجي يظهر دائماً)
do
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomToggleUI"
    ScreenGui.Parent = game.CoreGui

    local HideButton = Instance.new("TextButton")
    HideButton.Name = "HideUIButton"
    HideButton.Size = UDim2.new(0, 80, 0, 30)
    HideButton.Position = UDim2.new(1, -90, 0, 10)  -- قرب الزاوية العليا اليمنى
    HideButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
    HideButton.TextColor3 = Color3.fromRGB(255,255,255)
    HideButton.Text = "Hide UI"
    HideButton.Parent = ScreenGui

    HideButton.MouseButton1Click:Connect(function()
        Window:Toggle()
    end)
end

-- إعداد متغيرات الخدمات
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- إعداد متغيرات الحالة
local Aimbot = {
    Enabled = false,
    Locked = nil,
    ESPEnabled = true,
    HitboxSize = 15,  -- للتحكم بمستوى الدقة (يمكن تعديله)
    Highlights = {}   -- لتخزين مؤشرات ESP
}
local SpeedHack = 16      -- سرعة المشي
local WallHack = false    -- حالة اختراق الجدران
local FlyEnabled = false  -- حالة الطيران
local FlySpeed = 50       -- سرعة الطيران

-- تفعيل تبديل الواجهة بزر RightShift
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Window:Toggle()
    end
end)

--------------------------------------------------
-- تبويبات الواجهة (Kavo UI)
--------------------------------------------------

-- تبويب Aimbot
local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Settings")
AimbotSection:NewToggle("Enable Aimbot", "تشغيل/إيقاف Aimbot", function(state)
    Aimbot.Enabled = state
end)
AimbotSection:NewToggle("Enable ESP", "تشغيل/إيقاف ESP للأعداء", function(state)
    Aimbot.ESPEnabled = state
end)
AimbotSection:NewSlider("Hitbox Size", "حجم hitbox للأعداء", 30, 10, function(value)
    Aimbot.HitboxSize = value
end)

-- تبويب Speed Hack
local SpeedTab = Window:NewTab("Speed Hack")
local SpeedSection = SpeedTab:NewSection("Control Speed")
SpeedSection:NewSlider("Speed", "تعديل سرعة المشي", 200, 1, function(value)
    SpeedHack = value
    local character = LocalPlayer.Character
    if character and character:FindFirstChildOfClass("Humanoid") then
        character:FindFirstChildOfClass("Humanoid").WalkSpeed = SpeedHack
    end
end)

-- تبويب Wall Hack
local WallHackTab = Window:NewTab("Wall Hack")
local WallHackSection = WallHackTab:NewSection("Wall Hack Settings")
WallHackSection:NewToggle("Enable Wall Hack", "اختراق الجدران", function(state)
    WallHack = state
    local character = LocalPlayer.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state  -- عند التفعيل: CanCollide = false
            end
        end
    end
end)

-- تبويب Flight (الطيران)
local FlyTab = Window:NewTab("Flight")
local FlySection = FlyTab:NewSection("Flight Settings")
FlySection:NewToggle("Enable Flight", "تشغيل/إيقاف الطيران", function(state)
    FlyEnabled = state
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.PlatformStand = state  -- عند التفعيل، تعطيل الحركة الطبيعية
        -- عند إيقاف الطيران، إزالة الجسم الفيزيائي الخاص بالطيران إن وجد
        if not state and character:FindFirstChild("HumanoidRootPart") then
            local bv = character.HumanoidRootPart:FindFirstChild("FlyVelocity")
            if bv then bv:Destroy() end
        end
    end
end)
FlySection:NewSlider("Fly Speed", "تعديل سرعة الطيران", 100, 10, function(value)
    FlySpeed = value
end)

--------------------------------------------------
-- وظائف مساعدة
--------------------------------------------------

-- وظيفة تحديث ESP باستخدام Highlight (تعتمد على مكتبة Highlight المدمجة)
local function UpdateESP()
    -- حذف المؤشرات القديمة
    for _, obj in pairs(Aimbot.Highlights) do
        if obj and obj:IsA("Highlight") then
            obj:Destroy()
        end
    end
    Aimbot.Highlights = {}

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local head = character and character:FindFirstChild("Head")
            if character and humanoid and head and humanoid.Health > 0 then
                local hl = Instance.new("Highlight")
                hl.Adornee = character
                hl.FillColor = Color3.new(1, 0, 0)
                hl.OutlineColor = Color3.new(1, 1, 1)
                hl.FillTransparency = 0.5
                hl.OutlineTransparency = 0.8
                hl.Parent = character
                table.insert(Aimbot.Highlights, hl)
            end
        end
    end
end

-- وظيفة الحصول على أقرب عدو من الماوس
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

-- وظيفة لإطلاق الشعاع على العدو باستخدام RaycastParams (whitelist) بحيث يتم اعتبار ضرب الرأس حتى لو خلف جدران
local function ShootAtEnemy(target)
    local character = target.Character
    local head = character and character:FindFirstChild("Head")
    if not (character and head) then return end

    local rayOrigin = Camera.CFrame.Position
    local rayDirection = (head.Position - rayOrigin).unit * 500

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Whitelist
    -- نضع جميع أجزاء شخصية العدو في القائمة حتى يتم تجاهل أي جدران
    rayParams.FilterDescendantsInstances = {character}

    local rayResult = workspace:Raycast(rayOrigin, rayDirection, rayParams)
    if rayResult and rayResult.Instance and rayResult.Instance:IsDescendantOf(character) then
        print("Target hit!")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:TakeDamage(50)
        end
    end
end

-- وظيفة الطيران: إضافة/تحديث BodyVelocity للتحكم في حركة اللاعب أثناء الطيران
local function FlyPlayer()
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local bv = rootPart:FindFirstChild("FlyVelocity")
    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.MaxForce = Vector3.new(1e6,1e6,1e6)
        bv.Parent = rootPart
    end

    local moveDir = Vector3.new(0,0,0)
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        moveDir = moveDir + Camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        moveDir = moveDir - Camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        moveDir = moveDir - Camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        moveDir = moveDir + Camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveDir = moveDir + Vector3.new(0,1,0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.C) then
        moveDir = moveDir - Vector3.new(0,1,0)
    end
    bv.Velocity = moveDir.Unit * FlySpeed
end

--------------------------------------------------
-- الحلقة الرئيسية لتحديث الميزات
--------------------------------------------------

RunService.RenderStepped:Connect(function()
    -- Aimbot: إذا كان مفعل، يتم اختيار أقرب عدو وتصويب الكاميرا عليه وإطلاق الشعاع
    if Aimbot.Enabled then
        local target = GetClosestEnemy()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, headPos)
            Aimbot.Locked = target
            ShootAtEnemy(target)
        else
            Aimbot.Locked = nil
        end
    end

    -- تحديث ESP (يمكنك تقليل عدد التحديثات إذا حدث تباطؤ)
    if Aimbot.ESPEnabled then
        UpdateESP()
    end

    -- الطيران: إذا كان الطيران مفعل، يتم تحديث حركة اللاعب
    if FlyEnabled then
        FlyPlayer()
    end
end)

print("✅ Script Loaded Successfully! Press RightShift to toggle UI.")
