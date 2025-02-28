-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Aimbot & Hacks", "DarkTheme")

----------------------------------------------------------------
-- زر Toggle UI باللون الأحمر (يظهر دائماً في الزاوية العليا اليمنى)
----------------------------------------------------------------
do
    local sg = Instance.new("ScreenGui")
    sg.Name = "CustomToggleUI"
    sg.Parent = game.CoreGui

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "ToggleUIButton"
    toggleBtn.Size = UDim2.new(0, 100, 0, 40)
    toggleBtn.Position = UDim2.new(1, -110, 0, 10)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- لون أحمر
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

-- متغيرات الميزات
local AimbotEnabled = false
local HitboxSize = 15  -- يمكن التحكم به عبر الشريط
local WallHackEnabled = false

----------------------------------------------------------------
-- إعداد تبويبات الواجهة باستخدام Kavo UI
----------------------------------------------------------------

-- تبويب Aimbot
local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Settings")
AimbotSection:NewToggle("Enable Aimbot", "تشغيل/إيقاف Aimbot", function(state)
    AimbotEnabled = state
end)
AimbotSection:NewSlider("Hitbox Size", "حجم hitbox المستهدف", 30, 10, function(value)
    HitboxSize = value
end)

-- تبويب Wall Hack
local WallHackTab = Window:NewTab("Wall Hack")
local WallHackSection = WallHackTab:NewSection("Settings")
WallHackSection:NewToggle("Enable Wall Hack", "اختراق الجدران", function(state)
    WallHackEnabled = state
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state
            end
        end
    end
end)

----------------------------------------------------------------
-- دوال مساعدة
----------------------------------------------------------------

-- الحصول على أقرب عدو من موقع الماوس (يتم اختيار العدو الأقرب وليس عشوائي)
local function GetClosestEnemy()
    local closestDistance = math.huge
    local closestEnemy = nil
    local mousePos = UserInputService:GetMouseLocation()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
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

-- إنشاء hitbox على رأس العدو (جزء مرئي)
local function CreateHitbox(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character.Head
        local hitbox = head:FindFirstChild("AimbotHitbox")
        if not hitbox then
            hitbox = Instance.new("Part")
            hitbox.Name = "AimbotHitbox"
            hitbox.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
            hitbox.Transparency = 0.5
            hitbox.CanCollide = false
            hitbox.Anchored = true
            hitbox.Material = Enum.Material.Neon
            hitbox.Color = Color3.new(1, 0, 0)
            hitbox.Parent = head
        end
        hitbox.CFrame = head.CFrame
    end
end

-- إطلاق شعاع على العدو باستخدام RaycastParams بنمط Whitelist لتجاهل الجدران
local function ShootAtEnemy(player)
    if not (player and player.Character and player.Character:FindFirstChild("Head")) then return end
    local head = player.Character.Head
    local origin = Camera.CFrame.Position
    local direction = (head.Position - origin).Unit * 1000

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Whitelist
    rayParams.FilterDescendantsInstances = {player.Character}
    rayParams.IgnoreWater = true

    local result = workspace:Raycast(origin, direction, rayParams)
    if result and result.Instance and result.Instance:IsDescendantOf(player.Character) then
        print("Locked on enemy head!")
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:TakeDamage(50)
        end
    end
end

----------------------------------------------------------------
-- الحلقة الرئيسية للتحديث
----------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local target = GetClosestEnemy()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, headPos)
            CreateHitbox(target)
            ShootAtEnemy(target)
        end
    end
end)

----------------------------------------------------------------
print("✅ Script Loaded Successfully! Press RightShift to toggle UI.")
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Window:Toggle()
    end
end)
