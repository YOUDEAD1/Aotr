-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Aimbot & Hacks", "DarkTheme")

----------------------------------------------------------------
-- زر إخفاء/إظهار الواجهة بجانب "X" (زر دائم في CoreGui)
do
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomToggleUI"
    ScreenGui.Parent = game.CoreGui

    local HideButton = Instance.new("TextButton")
    HideButton.Name = "HideUIButton"
    HideButton.Size = UDim2.new(0, 80, 0, 30)
    HideButton.Position = UDim2.new(1, -90, 0, 10)  -- الزاوية العليا اليمنى
    HideButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
    HideButton.TextColor3 = Color3.fromRGB(255,255,255)
    HideButton.Text = "Hide UI"
    HideButton.Parent = ScreenGui

    HideButton.MouseButton1Click:Connect(function()
        Window:Toggle()
    end)
end

----------------------------------------------------------------
-- الخدمات والمتغيرات الأساسية
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- متغيرات الميزات
local Aimbot = {
    Enabled = false,
    Locked = nil,
    ESPEnabled = true,
    HitboxSize = 15,   -- حجم hitbox (يمكن التحكم به عبر الشريط)
    Hitboxes = {},     -- لتخزين hitbox الفعلي لكل عدو
    Highlights = {}    -- لتخزين مؤشرات ESP (Highlight)
}
local SpeedHack = 16       -- سرعة المشي
local WallHack = false     -- حالة اختراق الجدران
local FlyEnabled = false   -- حالة الطيران
local FlySpeed = 50        -- سرعة الطيران

----------------------------------------------------------------
-- تحديث شخصية اللاعب عند إعادة التحميل
local function onCharacterAdded(character)
    wait(1)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = SpeedHack
        if WallHack then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end
if LocalPlayer.Character then
    onCharacterAdded(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

----------------------------------------------------------------
-- إعداد تبويبات الواجهة باستخدام Kavo UI

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
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = SpeedHack
    end
end)

-- تبويب Wall Hack
local WallHackTab = Window:NewTab("Wall Hack")
local WallHackSection = WallHackTab:NewSection("Wall Hack Settings")
WallHackSection:NewToggle("Enable Wall Hack", "اختراق الجدران", function(state)
    WallHack = state
    if LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
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
        character.Humanoid.PlatformStand = state
        if not state then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = root:FindFirstChild("FlyVelocity")
                if bv then bv:Destroy() end
            end
        end
    end
end)
FlySection:NewSlider("Fly Speed", "تعديل سرعة الطيران", 100, 10, function(value)
    FlySpeed = value
end)

----------------------------------------------------------------
-- وظائف المساعدة

-- إنشاء hitbox فعلي (جزء فيزيائي) لكل عدو
local function UpdateHitboxes()
    -- إزالة hitbox القديمة
    for _, hitbox in ipairs(Aimbot.Hitboxes) do
        if hitbox and hitbox.Parent then
            hitbox:Destroy()
        end
    end
    Aimbot.Hitboxes = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local character = player.Character
            local head = character and character:FindFirstChild("Head")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if character and head and humanoid and humanoid.Health > 0 then
                local hitbox = Instance.new("Part")
                hitbox.Name = "EnemyHitbox"
                hitbox.Size = Vector3.new(Aimbot.HitboxSize, Aimbot.HitboxSize, Aimbot.HitboxSize)
                hitbox.Transparency = 0.7
                hitbox.CanCollide = false
                hitbox.Anchored = true
                hitbox.Material = Enum.Material.Neon
                hitbox.Color = Color3.new(1, 0, 0)
                hitbox.Parent = character  -- ربطه بالشخصية
                table.insert(Aimbot.Hitboxes, hitbox)
            end
        end
    end
end

-- تحديث مواقع hitbox مع حركة الرأس
local function UpdateHitboxPositions()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local character = player.Character
            local head = character and character:FindFirstChild("Head")
            local hitbox = character and character:FindFirstChild("EnemyHitbox")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if character and head and hitbox and humanoid and humanoid.Health > 0 then
                hitbox.Position = head.Position
            elseif hitbox then
                hitbox:Destroy()
            end
        end
    end
end

-- تحديث ESP باستخدام Highlight (مؤشر بصري)
local function UpdateESP()
    for _, hl in ipairs(Aimbot.Highlights) do
        if hl and hl.Parent then
            hl:Destroy()
        end
    end
    Aimbot.Highlights = {}
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local character = player.Character
            local head = character and character:FindFirstChild("Head")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if character and head and humanoid and humanoid.Health > 0 then
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

-- الحصول على أقرب عدو بناءً على موقع الماوس
local function GetClosestEnemy()
    local closestDistance = 90
    local closestEnemy = nil
    local mousePos = UserInputService:GetMouseLocation()
    for _, player in ipairs(Players:GetPlayers()) do
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

-- إطلاق شعاع على العدو باستخدام RaycastParams (whitelist) لتجاهل الجدران
local function ShootAtEnemy(target)
    local character = target.Character
    local head = character and character:FindFirstChild("Head")
    if not (character and head) then return end

    local rayOrigin = Camera.CFrame.Position
    local rayDirection = (head.Position - rayOrigin).unit * 500

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Whitelist
    rayParams.FilterDescendantsInstances = {character}  -- السماح فقط بأجزاء العدو
    rayParams.IgnoreWater = true

    local rayResult = workspace:Raycast(rayOrigin, rayDirection, rayParams)
    if rayResult and rayResult.Instance and rayResult.Instance:IsDescendantOf(character) then
        print("Target hit!")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:TakeDamage(50)
        end
    end
end

-- نظام الطيران: تحديث حركة اللاعب باستخدام BodyVelocity على الـ HumanoidRootPart
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
    if moveDir.Magnitude > 0 then
        moveDir = moveDir.Unit * FlySpeed
    end
    bv.Velocity = moveDir
end

----------------------------------------------------------------
-- الحلقة الرئيسية للتحديث
RunService.RenderStepped:Connect(function()
    local character = LocalPlayer.Character
    -- Aimbot: اختيار أقرب عدو وتعديل الكاميرا وإطلاق الشعاع
    if Aimbot.Enabled and character then
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

    -- تحديث مواقع hitbox و ESP
    UpdateHitboxPositions()
    if Aimbot.ESPEnabled then
        UpdateESP()
    end
    UpdateHitboxes()

    -- الطيران: تحديث حركة اللاعب إذا كان مفعلًا ومع التأكد من أن الشخصية على قيد الحياة
    if FlyEnabled and character and character:FindFirstChildOfClass("Humanoid") then
        if character:FindFirstChildOfClass("Humanoid").Health > 0 then
            FlyPlayer()
        else
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local bv = rootPart:FindFirstChild("FlyVelocity")
                if bv then bv:Destroy() end
            end
        end
    end
end)

----------------------------------------------------------------
print("✅ Script Loaded Successfully! Press RightShift to toggle UI.")
-- تفعيل تبديل الواجهة بزر RightShift أيضاً
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Window:Toggle()
    end
end)
