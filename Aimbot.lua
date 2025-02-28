-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Aimbot & Hacks", "DarkTheme")

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
    HitboxSize = 7,  -- حجم المربع حول الأعداء
    Highlights = {}
}

local SpeedHack = 16  -- السرعة الافتراضية
local WallHack = false

-- واجهة Aimbot
local AimbotTab = Window:NewTab("Aimbot")
local AimbotSection = AimbotTab:NewSection("Settings")

AimbotSection:NewToggle("Enable Aimbot", "تفعيل/إيقاف Aimbot", function(state)
    Aimbot.Enabled = state
end)

AimbotSection:NewToggle("Enable ESP", "تفعيل/إيقاف رؤية الأعداء", function(state)
    Aimbot.ESPEnabled = state
end)

AimbotSection:NewSlider("Hitbox Size", "تحكم في حجم المربع حول الأعداء", 15, 5, function(value)
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

-- دالة ESP مع المربع الكبير (Hitbox)
local function UpdateESP()
    for _, highlight in pairs(Aimbot.Highlights) do
        highlight:Destroy()
    end
    Aimbot.Highlights = {}

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local head = character and character:FindFirstChild("Head")

            if character and humanoid and head and humanoid.Health > 0 then
                -- إنشاء المربع الكبير حول العدو
                local hitbox = Instance.new("Part")
                hitbox.Size = Vector3.new(Aimbot.HitboxSize, Aimbot.HitboxSize, Aimbot.HitboxSize)
                hitbox.Transparency = 0.7
                hitbox.CanCollide = false
                hitbox.Anchored = true
                hitbox.Color = Color3.fromRGB(255, 0, 0)
                hitbox.Material = Enum.Material.ForceField
                hitbox.Parent = character
                hitbox.Position = head.Position

                -- تحديث المربع مع حركة العدو
                RunService.RenderStepped:Connect(function()
                    if hitbox and head then
                        hitbox.Position = head.Position
                    end
                end)

                table.insert(Aimbot.Highlights, hitbox)
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

-- تشغيل Aimbot وESP
local function StartAimbot()
    RunService.RenderStepped:Connect(function()
        if Aimbot.Enabled then
            local target = GetClosestEnemy()
            if target then
                local headPos = target.Character.Head.Position
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, headPos)
                Aimbot.Locked = target
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

print("Script Loaded Successfully!")
