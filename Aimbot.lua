-- تحميل مكتبة Kavo UI (لا تحذف أي ميزة)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Aimbot & Hacks", "DarkTheme")

----------------------------------------------------------------
-- زر Toggle UI مستقل
----------------------------------------------------------------
local toggleUI = Instance.new("TextButton")
toggleUI.Name = "CustomToggleUIButton"
toggleUI.Size = UDim2.new(0, 100, 0, 40)
toggleUI.Position = UDim2.new(1, -110, 0, 10)
toggleUI.BackgroundColor3 = Color3.fromRGB(255, 80, 80)  -- أحمر فاتح
toggleUI.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleUI.Text = "Toggle UI"
toggleUI.Parent = game.CoreGui

local uiVisible = true
toggleUI.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    pcall(function()
        Window.Main.Visible = uiVisible
    end)
end)

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

-- إعدادات الميزات
local Aimbot = {
    Enabled = false,
    Locked = nil,
    ESPEnabled = true,      -- نستخدم Highlight لعرض الخصوم
    HitboxSize = 15         -- تحديد حجم الـHitbox
}
local SpeedHack = 16       -- سرعة المشي الافتراضية
local WallHack = false     -- اختراق الجدران (تغيير CanCollide)
local FlyEnabled = false   -- الطيران
local FlySpeed = 50        -- سرعة الطيران

-- الخيارات الإضافية
local BulletWallHack = false   -- خيار اختراق طلقة الجدران
local GodMode = false          -- خيار عدم الموت (القوة)

----------------------------------------------------------------
-- تبويبات الواجهة باستخدام Kavo UI
----------------------------------------------------------------

-- تبويب Aimbot
local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Settings")
AimbotSection:NewToggle("Enable Aimbot", "يعمل عند الضغط على زر الفأرة الأيمن", function(state)
    Aimbot.Enabled = state
end)
AimbotSection:NewToggle("Enable ESP", "عرض Highlight على خصومك", function(state)
    Aimbot.ESPEnabled = state
end)
AimbotSection:NewSlider("Hitbox Size", "حجم hitbox", 30, 10, function(value)
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
WallHackSection:NewToggle("Enable Wall Hack", "تعطيل التصادم في شخصيتك", function(state)
    WallHack = state
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state
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

-- تبويب Extra (الإضافات)
local ExtraTab = Window:NewTab("Extra")
local ExtraSection = ExtraTab:NewSection("Options")
ExtraSection:NewToggle("Bullet Wall Hack", "اختراق طلقة الجدران (تعتبر الطلقة ضاربة حتى مع وجود جدار)", function(state)
    BulletWallHack = state
end)
ExtraSection:NewToggle("God Mode", "لا تموت (قوة إضافية)", function(state)
    GodMode = state
end)

----------------------------------------------------------------
-- نظام ESP باستخدام Highlight المدمج
----------------------------------------------------------------
local function UpdateEnemyHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and IsEnemy(player) then
            local character = player.Character
            local hum = character:FindFirstChildOfClass("Humanoid")
            local hl = character:FindFirstChildOfClass("Highlight")
            if hum and hum.Health > 0 then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "EnemyHighlight"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)   -- لون أحمر فاتح
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.3
                    hl.OutlineTransparency = 0.1
                    hl.Parent = character
                end
            else
                if hl then hl:Destroy() end
            end
        end
    end
end

----------------------------------------------------------------
-- دوال Aimbot
----------------------------------------------------------------

-- الحصول على أقرب خصم بناءً على موقع الماوس (يستهدف الخصوم فقط)
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

-- إطلاق شعاع على العدو باستخدام RaycastParams بنمط Whitelist لتجاهل الجدران
local function ShootAtEnemy(target)
    if not (target and target.Character and target.Character:FindFirstChild("Head")) then return end
    local head = target.Character.Head
    local origin = Camera.CFrame.Position
    local direction = (head.Position - origin).Unit * 1000

    if BulletWallHack then
        -- إذا كان اختراق الرصاص للجدران مفعل، قم بتطبيق الضرر مباشرة
        local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            print("Bullet Wall Hack active: hit enemy!")
            humanoid:TakeDamage(50)
        end
    else
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Whitelist
        rayParams.FilterDescendantsInstances = {target.Character}
        rayParams.IgnoreWater = true

        local result = workspace:Raycast(origin, direction, rayParams)
        if result and result.Instance and result.Instance:IsDescendantOf(target.Character) then
            print("Aimbot locked on head!")
            local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                humanoid:TakeDamage(50)
            end
        end
    end
end

----------------------------------------------------------------
-- نظام الطيران: تحديث حركة اللاعب باستخدام BodyVelocity على الـ HumanoidRootPart
----------------------------------------------------------------
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
    local moveDir = Vector3.new(0, 0, 0)
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
        moveDir = moveDir + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        moveDir = moveDir - Vector3.new(0, 1, 0)
    end
    bv.Velocity = moveDir.Unit * FlySpeed
end

-- الاستماع لتغييرات في الشخصية
Character:WaitForChild("HumanoidRootPart")
RunService.Heartbeat:Connect(function()
    if FlyEnabled then
        FlyPlayer()
    end
    UpdateEnemyHighlights()
end)
