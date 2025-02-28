-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Aimbot & Hacks", "DarkTheme")

----------------------------------------------------------------
-- زر Toggle UI باللون الأحمر يظهر دائمًا في الزاوية العليا اليمنى
----------------------------------------------------------------
do
    local sg = Instance.new("ScreenGui")
    sg.Name = "CustomToggleUI"
    sg.Parent = game.CoreGui

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "ToggleUIButton"
    toggleBtn.Size = UDim2.new(0, 100, 0, 40)
    toggleBtn.Position = UDim2.new(1, -110, 0, 10)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- أحمر
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Text = "Hide UI"
    toggleBtn.Parent = sg

    toggleBtn.MouseButton1Click:Connect(function()
        Window:Toggle()
    end)
end

----------------------------------------------------------------
-- الخدمات والمتغيرات الأساسية
----------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")

-- إعدادات السكربت
local Aimbot = {
    Enabled = false,
    Locked = nil,
    ESPEnabled = true,
    HitboxSize = 15,  -- حجم hitbox (يمكن التحكم به عبر الشريط)
    Highlights = {}   -- لتخزين hitbox لكل عدو
}

local SpeedHack = 16       -- سرعة المشي الافتراضية
local WallHack = false     -- حالة اختراق الجدران
local FlyEnabled = false   -- حالة الطيران
local FlySpeed = 50        -- سرعة الطيران

----------------------------------------------------------------
-- تبويبات الواجهة باستخدام Kavo UI
----------------------------------------------------------------

-- تبويب Aimbot
local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Settings")
AimbotSection:NewToggle("Enable Aimbot", "تشغيل/إيقاف Aimbot (يعمل عند الضغط على زر الفأرة الأيمن)", function(state)
    Aimbot.Enabled = state
end)
AimbotSection:NewToggle("Enable ESP", "تشغيل/إيقاف ESP (عرض hitbox على الرأس)", function(state)
    Aimbot.ESPEnabled = state
end)
AimbotSection:NewSlider("Hitbox Size", "حجم hitbox المرفق بالرأس", 30, 10, function(value)
    Aimbot.HitboxSize = value
end)

-- تبويب Speed Hack
local SpeedTab = Window:NewTab("Speed Hack")
local SpeedSection = SpeedTab:NewSection("Control Speed")
SpeedSection:NewSlider("Speed", "تعديل سرعة اللاعب", 200, 1, function(value)
    SpeedHack = value
    if Humanoid then
        Humanoid.WalkSpeed = SpeedHack
    end
end)

-- تبويب Wall Hack
local WallHackTab = Window:NewTab("Wall Hack")
local WallHackSection = WallHackTab:NewSection("Settings")
WallHackSection:NewToggle("Enable Wall Hack", "اختراق الجدران", function(state)
    WallHack = state
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
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
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = state
        if not state then
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bv = hrp:FindFirstChild("FlyVelocity")
                if bv then bv:Destroy() end
            end
        end
    end
end)
FlySection:NewSlider("Fly Speed", "تعديل سرعة الطيران", 100, 10, function(value)
    FlySpeed = value
end)

----------------------------------------------------------------
-- دوال مساعدة
----------------------------------------------------------------

-- دالة التحقق من أن اللاعب من خصوم فقط (إذا كانت فرق اللعب مُفعلة)
local function IsEnemy(player)
    if not (player and player.Team and LocalPlayer.Team) then
        return true
    end
    return player.Team ~= LocalPlayer.Team
end

-- الحصول على أقرب عدو بالنسبة لموقع الماوس (يستهدف خصوم فقط)
local function GetClosestEnemy()
    local closestDistance = math.huge
    local closestEnemy = nil
    local mousePos = UserInputService:GetMouseLocation()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and IsEnemy(player) then
            local head = player.Character.Head
            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if dist < closestDistance then
                    closestDistance = dist
                    closestEnemy = player
                end
            end
        end
    end
    return closestEnemy
end

-- إنشاء hitbox على رأس العدو (جزء مرئي) وتحديث موقعه
local function CreateHitbox(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character.Head
        local hitbox = head:FindFirstChild("AimbotHitbox")
        if not hitbox then
            hitbox = Instance.new("Part")
            hitbox.Name = "AimbotHitbox"
            hitbox.Size = Vector3.new(Aimbot.HitboxSize, Aimbot.HitboxSize, Aimbot.HitboxSize)
            hitbox.Transparency = 0.5
            hitbox.CanCollide = false
            hitbox.Anchored = true
            hitbox.Material = Enum.Material.Neon
            hitbox.Color = Color3.new(1, 0, 0)
            hitbox.Parent = workspace
        end
        hitbox.CFrame = head.CFrame
        return hitbox
    end
end

-- إطلاق شعاع على العدو باستخدام RaycastParams بنمط Whitelist لتجاهل الجدران
local function ShootAtEnemy(target)
    if not (target and target.Character and target.Character:FindFirstChild("Head")) then return end
    local head = target.Character.Head
    local origin = Camera.CFrame.Position
    local direction = (head.Position - origin).Unit * 1000

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Whitelist
    rayParams.FilterDescendantsInstances = {target.Character}
    rayParams.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, rayParams)
    if result and result.Instance and result.Instance:IsDescendantOf(target.Character) then
        print("Aimbot locked on head!")
        local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:TakeDamage(50)
        end
    end
end

-- دالة للطيران: تحديث حركة اللاعب باستخدام BodyVelocity على الـ HumanoidRootPart
local function FlyPlayer()
    if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local bv = hrp:FindFirstChild("FlyVelocity")
    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Parent = hrp
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
-- الحلقة الرئيسية للتحديث (RenderStepped)
----------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    -- Aimbot يعمل فقط عند الضغط على زر الفأرة الأيمن
    if Aimbot.Enabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
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

    -- تحديث ESP: إنشاء أو تحديث hitbox على رأس كل عدو (للخصوم فقط)
    if Aimbot.ESPEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and IsEnemy(player) then
                CreateHitbox(player)
            end
        end
    end

    -- تحديث حركة الطيران
    if FlyEnabled then
        FlyPlayer()
    end
end)

----------------------------------------------------------------
print("✅ Script Loaded Successfully! Press RightShift to toggle UI.")
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Window:Toggle()
    end
end)
