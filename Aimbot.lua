-- تعريف الخدمات
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- إعدادات السكريبت
local Aimbot = {
    Enabled = false,           -- حالة السكريبت
    Locked = nil,              -- الهدف المقفل
    Connections = {},          -- تخزين الاتصالات
    WallCheck = false          -- التحقق من الجدران (false = يمكن ضرب عدو وراء جدار)
    ESPEnabled = true,         -- تفعيل ESP
    Highlights = {}            -- تخزين تسليط الضوء
}

-- إنشاء GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AimbotGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 150, 0, 40)
Frame.Position = UDim2.new(0, 10, 0, 10) -- أعلى يسار
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 1, 0)
StatusLabel.Text = "Aimbot: OFF (P)"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StatusLabel.TextScaled = true
StatusLabel.Parent = Frame

-- دالة ESP لتسليط الضوء على الأعداء
local function UpdateESP()
    -- إزالة تسليط الضوء القديم
    for _, highlight in pairs(Aimbot.Highlights) do
        highlight:Destroy()
    end
    Aimbot.Highlights = {}

    -- إضافة تسليط الضوء للأعداء
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if character and humanoid and humanoid.Health > 0 then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 255, 255) -- لون أبيض
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Adornee = character
                highlight.Parent = character
                table.insert(Aimbot.Highlights, highlight)
            end
        end
    end
end

-- دالة للحصول على أقرب عدو
local function GetClosestEnemy()
    local closestDistance = 90 -- نطاق الرؤية
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

                -- إذا WallCheck مفعل، تحقق من الجدران
                if Aimbot.WallCheck then
                    local ray = Ray.new(Camera.CFrame.Position, (headPos - Camera.CFrame.Position).Unit * 1000)
                    local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character})
                    if hit and hit:IsDescendantOf(character) then
                        if distance < closestDistance and onScreen then
                            closestDistance = distance
                            closestEnemy = player
                        end
                    end
                else
                    -- تجاهل الجدران إذا كان WallCheck معطل
                    if distance < closestDistance and onScreen then
                        closestDistance = distance
                        closestEnemy = player
                    end
                -- لا تحقق من الجدران، استهدف مباشرة
                if distance < closestDistance and onScreen then
                    closestDistance = distance
                    closestEnemy = player
                end
            end
        end
    end
    return closestEnemy
end

-- تشغيل Aimbot
-- تشغيل Aimbot وESP
local function StartAimbot()
    -- تشغيل Aimbot
    Aimbot.Connections.RenderStepped = RunService.RenderStepped:Connect(function()
        if Aimbot.Enabled then
            local target = GetClosestEnemy() -- تحديث الهدف في كل إطار
            if target then
                local headPos = target.Character.Head.Position
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, headPos)
                Aimbot.Locked = target -- تحديث الهدف المقفل
                Aimbot.Locked = target
            else
                Aimbot.Locked = nil -- إلغاء القفل إذا لم يكن هناك هدف
                Aimbot.Locked = nil
            end
        end
    end)

    -- تشغيل ESP
    if Aimbot.ESPEnabled then
        Aimbot.Connections.ESPUpdate = RunService.RenderStepped:Connect(UpdateESP)
    end
end

-- إيقاف Aimbot
-- إيقاف Aimbot وESP
local function StopAimbot()
    Aimbot.Locked = nil
    if Aimbot.Connections.RenderStepped then
        Aimbot.Connections.RenderStepped:Disconnect()
    end
    if Aimbot.Connections.ESPUpdate then
        Aimbot.Connections.ESPUpdate:Disconnect()
    end
    -- إزالة تسليط الضوء عند الإيقاف
    for _, highlight in pairs(Aimbot.Highlights) do
        highlight:Destroy()
    end
    Aimbot.Highlights = {}
end

-- التحكم بمفتاح P
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.P then
        Aimbot.Enabled = not Aimbot.Enabled
        if Aimbot.Enabled then
            StartAimbot()
            StatusLabel.Text = "Aimbot: ON (P)"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            print("Aimbot Enabled")
        else
            StopAimbot()
            StatusLabel.Text = "Aimbot: OFF (P)"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            print("Aimbot Disabled")
        end
    end
end)

-- بدء السكريبت
print("Aimbot Loaded. Press P to toggle.")
