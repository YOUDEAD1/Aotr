-- إعدادات أساسية
local player = game.Players.LocalPlayer
local autoFarmActive = false
local autoMissionActive = false
local autoEscapeActive = false -- للهروب من العملاق
local menuVisible = true

-- دالة لإرسال إشعار
local function sendNotification(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Icon = "rbxassetid://1234567890",
            Duration = duration or 5
        })
    end)
end

-- دالة لقتل العمالقة (Auto Farm)
local function autoFarm()
    sendNotification("Auto Farm", "Targeting Titan necks!", 5)
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, enemy in pairs(workspace:GetDescendants()) do
                local humanoid = enemy:FindFirstChild("Humanoid")
                local neckPart = enemy:FindFirstChild("Neck") or enemy:FindFirstChild("Head")
                if humanoid and neckPart and humanoid.Health > 0 and enemy ~= player.Character then
                    -- منطقة "مربع كبير" خلف العنق
                    local behindNeckCFrame = neckPart.CFrame * CFrame.new(0, 0, 5) -- 5 وحدات خلف العنق
                    player.Character.HumanoidRootPart.CFrame = behindNeckCFrame
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
            end
        end
        task.wait(0.05)
    end
end

-- دالة للهروب من العملاق (W, S, A, D)
local function autoEscape()
    sendNotification("Auto Escape", "Escape feature activated!", 5)
    while autoEscapeActive do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            if humanoid.WalkSpeed == 0 or humanoid.Health < humanoid.MaxHealth then -- كشف الإمساك
                local keys = {"W", "S", "A", "D"}
                for _, key in pairs(keys) do
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode[key], false, game)
                    task.wait(0.05)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode[key], false, game)
                end
            end
        end
        task.wait(0.1)
    end
end

-- دالة لتشغيل المهام تلقائيًا (Auto Mission)
local function autoMission()
    sendNotification("Auto Mission", "Auto Mission has started!", 5)
    while autoMissionActive do
        local missionFolder = game.Workspace:FindFirstChild("Missions") or game.ReplicatedStorage:FindFirstChild("Missions")
        if missionFolder then
            for _, mission in pairs(missionFolder:GetChildren()) do
                local clickDetector = mission:FindFirstChild("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                end
            end
        end
        task.wait(1)
    end
end

-- إنشاء واجهة القائمة المحسنة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AotRScriptMenu"
ScreenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 450) -- قائمة أكبر وأجمل
frame.Position = UDim2.new(0.5, -175, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- أسود غامق أنيق
frame.BorderColor3 = Color3.fromRGB(255, 255, 255) -- حدود بيضاء
frame.BorderSizePixel = 2
frame.Parent = ScreenGui
frame.Draggable = true
frame.Active = true

-- تأثير الظل
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.7
shadow.ZIndex = -1
shadow.Parent = frame

-- عنوان القائمة
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 330, 0, 50)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.Text = "Aot Script by YOUDEAD1"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.BorderSizePixel = 0
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 28
titleLabel.Parent = frame

-- Auto Farm Section
local farmLabel = Instance.new("TextLabel")
farmLabel.Size = UDim2.new(0, 200, 0, 40)
farmLabel.Position = UDim2.new(0, 10, 0, 70)
farmLabel.Text = "Auto Farm"
farmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
farmLabel.BackgroundTransparency = 1
farmLabel.Font = Enum.Font.Gotham
farmLabel.TextSize = 22
farmLabel.Parent = frame

local farmOnButton = Instance.new("TextButton")
farmOnButton.Size = UDim2.new(0, 50, 0, 40)
farmOnButton.Position = UDim2.new(0, 230, 0, 70)
farmOnButton.Text = "ON"
farmOnButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
farmOnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmOnButton.Font = Enum.Font.GothamBold
farmOnButton.TextSize = 18
farmOnButton.Parent = frame

local farmOffButton = Instance.new("TextButton")
farmOffButton.Size = UDim2.new(0, 50, 0, 40)
farmOffButton.Position = UDim2.new(0, 290, 0, 70)
farmOffButton.Text = "OFF"
farmOffButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
farmOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmOffButton.Font = Enum.Font.GothamBold
farmOffButton.TextSize = 18
farmOffButton.Parent = frame

farmOnButton.MouseButton1Click:Connect(function()
    if not autoFarmActive then
        autoFarmActive = true
        task.spawn(autoFarm)
    end
end)

farmOffButton.MouseButton1Click:Connect(function()
    autoFarmActive = false
end)

-- Auto Mission Section
local missionLabel = Instance.new("TextLabel")
missionLabel.Size = UDim2.new(0, 200, 0, 40)
missionLabel.Position = UDim2.new(0, 10, 0, 120)
missionLabel.Text = "Auto Mission"
missionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
missionLabel.BackgroundTransparency = 1
missionLabel.Font = Enum.Font.Gotham
missionLabel.TextSize = 22
missionLabel.Parent = frame

local missionOnButton = Instance.new("TextButton")
missionOnButton.Size = UDim2.new(0, 50, 0, 40)
missionOnButton.Position = UDim2.new(0, 230, 0, 120)
missionOnButton.Text = "ON"
missionOnButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
missionOnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
missionOnButton.Font = Enum.Font.GothamBold
missionOnButton.TextSize = 18
missionOnButton.Parent = frame

local missionOffButton = Instance.new("TextButton")
missionOffButton.Size = UDim2.new(0, 50, 0, 40)
missionOffButton.Position = UDim2.new(0, 290, 0, 120)
missionOffButton.Text = "OFF"
missionOffButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
missionOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
missionOffButton.Font = Enum.Font.GothamBold
missionOffButton.TextSize = 18
missionOffButton.Parent = frame

missionOnButton.MouseButton1Click:Connect(function()
    if not autoMissionActive then
        autoMissionActive = true
        task.spawn(autoMission)
    end
end)

missionOffButton.MouseButton1Click:Connect(function()
    autoMissionActive = false
end)

-- Auto Escape Section (جديد)
local escapeLabel = Instance.new("TextLabel")
escapeLabel.Size = UDim2.new(0, 200, 0, 40)
escapeLabel.Position = UDim2.new(0, 10, 0, 170)
escapeLabel.Text = "Auto Escape"
escapeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
escapeLabel.BackgroundTransparency = 1
escapeLabel.Font = Enum.Font.Gotham
escapeLabel.TextSize = 22
escapeLabel.Parent = frame

local escapeOnButton = Instance.new("TextButton")
escapeOnButton.Size = UDim2.new(0, 50, 0, 40)
escapeOnButton.Position = UDim2.new(0, 230, 0, 170)
escapeOnButton.Text = "ON"
escapeOnButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
escapeOnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
escapeOnButton.Font = Enum.Font.GothamBold
escapeOnButton.TextSize = 18
escapeOnButton.Parent = frame

local escapeOffButton = Instance.new("TextButton")
escapeOffButton.Size = UDim2.new(0, 50, 0, 40)
escapeOffButton.Position = UDim2.new(0, 290, 0, 170)
escapeOffButton.Text = "OFF"
escapeOffButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
escapeOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
escapeOffButton.Font = Enum.Font.GothamBold
escapeOffButton.TextSize = 18
escapeOffButton.Parent = frame

escapeOnButton.MouseButton1Click:Connect(function()
    if not autoEscapeActive then
        autoEscapeActive = true
        task.spawn(autoEscape)
    end
end)

escapeOffButton.MouseButton1Click:Connect(function()
    autoEscapeActive = false
end)

-- زر إخفاء/إظهار القائمة
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 330, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 390)
toggleButton.Text = "إخفاء القائمة"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- أصفر ذهبي
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 22
toggleButton.Parent = frame

-- زر إظهار القائمة عند الإخفاء
local showButton = Instance.new("TextButton")
showButton.Size = UDim2.new(0, 60, 0, 60)
showButton.Position = UDim2.new(0, 0, 0, 0)
showButton.Text = "MENU"
showButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
showButton.TextColor3 = Color3.fromRGB(255, 255, 255)
showButton.Font = Enum.Font.GothamBold
showButton.TextSize = 20
showButton.Parent = ScreenGui
showButton.Visible = false

toggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    frame.Visible = menuVisible
    showButton.Visible = not menuVisible
    toggleButton.Text = menuVisible and "إخفاء القائمة" or "إظهار القائمة"
end)

showButton.MouseButton1Click:Connect(function()
    menuVisible = true
    frame.Visible = true
    showButton.Visible = false
end)

-- إشعار عند تحميل السكريبت
sendNotification("Aot Script", "Script loaded successfully by YOUDEAD1!", 5)
