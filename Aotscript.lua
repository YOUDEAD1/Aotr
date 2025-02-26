-- إعدادات أساسية
local player = game.Players.LocalPlayer
local autoFarmActive = false
local autoMissionActive = false
local autoEscapeActive = false
local speedBoostActive = false
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

-- دالة Auto Farm (قتل العمالقة في منطقة واسعة)
local function autoFarm()
    sendNotification("Auto Farm", "Targeting enemies in a wide area!", 5)
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, enemy in pairs(workspace:GetDescendants()) do
                local humanoid = enemy:FindFirstChild("Humanoid")
                local rootPart = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("Torso")
                if humanoid and rootPart and humanoid.Health > 0 and enemy ~= player.Character then
                    local distanceX = math.random(-10, 10)
                    local distanceZ = math.random(-10, 10)
                    local attackPosition = rootPart.CFrame * CFrame.new(distanceX, 0, distanceZ)
                    player.Character.HumanoidRootPart.CFrame = attackPosition
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        for _ = 1, 5 do
                            tool:Activate()
                            task.wait(0.01)
                        end
                    end
                end
            end
        end
        task.wait(0.05)
    end
end

-- دالة Auto Mission (تنفيذ المهام تلقائيًا)
local function autoMission()
    sendNotification("Auto Mission", "Starting missions automatically!", 5)
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

-- دالة Auto Escape (الهروب التلقائي)
local function autoEscape()
    sendNotification("Auto Escape", "Escape activated!", 5)
    while autoEscapeActive do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            local isGrabbed = humanoid.WalkSpeed == 0 or player.PlayerGui:FindFirstChild("QTEGui")
            if isGrabbed then
                local keys = {"W", "S", "A", "D"}
                for _, key in pairs(keys) do
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode[key], false, game)
                    task.wait(0.05)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode[key], false, game)
                end
            end
        end
        task.wait(0.2)
    end
end

-- دالة Speed Boost (زيادة السرعة)
local function speedBoost()
    sendNotification("Speed Boost", "Speed increased!", 5)
    while speedBoostActive do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 50 -- سرعة مخصصة
        end
        task.wait(0.1)
    end
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16 -- إعادة السرعة الافتراضية
    end
end

-- إنشاء واجهة القائمة المحسنة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "EpicScriptMenu"
ScreenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 550)
frame.Position = UDim2.new(0.5, -225, 0.5, -275)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.BorderSizePixel = 4
frame.Parent = ScreenGui
frame.Draggable = true
frame.Active = true

local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 15, 1, 15)
shadow.Position = UDim2.new(0, -7, 0, -7)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BackgroundTransparency = 0.6
shadow.ZIndex = -1
shadow.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 430, 0, 70)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.Text = "Epic Script by YOUDEAD1"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.BorderSizePixel = 0
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 36
titleLabel.Parent = frame

-- مؤشر مخصص للماوس
local cursor = Instance.new("ImageLabel")
cursor.Size = UDim2.new(0, 28, 0, 28)
cursor.BackgroundTransparency = 1
cursor.Image = "rbxassetid://1234567890" -- استبدل بمعرف صورة مخصصة
cursor.ZIndex = 10
cursor.Parent = ScreenGui

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = input.Position
        cursor.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)
    end
end)

-- قسم Auto Farm
local farmLabel = Instance.new("TextLabel")
farmLabel.Size = UDim2.new(0, 300, 0, 50)
farmLabel.Position = UDim2.new(0, 10, 0, 90)
farmLabel.Text = "Auto Farm"
farmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
farmLabel.BackgroundTransparency = 1
farmLabel.Font = Enum.Font.GothamBold
farmLabel.TextSize = 26
farmLabel.Parent = frame

local farmOnButton = Instance.new("TextButton")
farmOnButton.Size = UDim2.new(0, 70, 0, 40)
farmOnButton.Position = UDim2.new(0, 320, 0, 95)
farmOnButton.Text = "ON"
farmOnButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
farmOnButton.TextColor3 = Color3.fromRGB(0, 0, 0)
farmOnButton.Font = Enum.Font.GothamBold
farmOnButton.TextSize = 20
farmOnButton.Parent = frame

local farmOffButton = Instance.new("TextButton")
farmOffButton.Size = UDim2.new(0, 70, 0, 40)
farmOffButton.Position = UDim2.new(0, 400, 0, 95)
farmOffButton.Text = "OFF"
farmOffButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
farmOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmOffButton.Font = Enum.Font.GothamBold
farmOffButton.TextSize = 20
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

-- قسم Auto Mission
local missionLabel = Instance.new("TextLabel")
missionLabel.Size = UDim2.new(0, 300, 0, 50)
missionLabel.Position = UDim2.new(0, 10, 0, 150)
missionLabel.Text = "Auto Mission"
missionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
missionLabel.BackgroundTransparency = 1
missionLabel.Font = Enum.Font.GothamBold
missionLabel.TextSize = 26
missionLabel.Parent = frame

local missionOnButton = Instance.new("TextButton")
missionOnButton.Size = UDim2.new(0, 70, 0, 40)
missionOnButton.Position = UDim2.new(0, 320, 0, 155)
missionOnButton.Text = "ON"
missionOnButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
missionOnButton.TextColor3 = Color3.fromRGB(0, 0, 0)
missionOnButton.Font = Enum.Font.GothamBold
missionOnButton.TextSize = 20
missionOnButton.Parent = frame

local missionOffButton = Instance.new("TextButton")
missionOffButton.Size = UDim2.new(0, 70, 0, 40)
missionOffButton.Position = UDim2.new(0, 400, 0, 155)
missionOffButton.Text = "OFF"
missionOffButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
missionOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
missionOffButton.Font = Enum.Font.GothamBold
missionOffButton.TextSize = 20
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

-- قسم Auto Escape
local escapeLabel = Instance.new("TextLabel")
escapeLabel.Size = UDim2.new(0, 300, 0, 50)
escapeLabel.Position = UDim2.new(0, 10, 0, 210)
escapeLabel.Text = "Auto Escape"
escapeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
escapeLabel.BackgroundTransparency = 1
escapeLabel.Font = Enum.Font.GothamBold
escapeLabel.TextSize = 26
escapeLabel.Parent = frame

local escapeOnButton = Instance.new("TextButton")
escapeOnButton.Size = UDim2.new(0, 70, 0, 40)
escapeOnButton.Position = UDim2.new(0, 320, 0, 215)
escapeOnButton.Text = "ON"
escapeOnButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
escapeOnButton.TextColor3 = Color3.fromRGB(0, 0, 0)
escapeOnButton.Font = Enum.Font.GothamBold
escapeOnButton.TextSize = 20
escapeOnButton.Parent = frame

local escapeOffButton = Instance.new("TextButton")
escapeOffButton.Size = UDim2.new(0, 70, 0, 40)
escapeOffButton.Position = UDim2.new(0, 400, 0, 215)
escapeOffButton.Text = "OFF"
escapeOffButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
escapeOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
escapeOffButton.Font = Enum.Font.GothamBold
escapeOffButton.TextSize = 20
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

-- قسم Speed Boost
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 300, 0, 50)
speedLabel.Position = UDim2.new(0, 10, 0, 270)
speedLabel.Text = "Speed Boost"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 26
speedLabel.Parent = frame

local speedOnButton = Instance.new("TextButton")
speedOnButton.Size = UDim2.new(0, 70, 0, 40)
speedOnButton.Position = UDim2.new(0, 320, 0, 275)
speedOnButton.Text = "ON"
speedOnButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
speedOnButton.TextColor3 = Color3.fromRGB(0, 0, 0)
speedOnButton.Font = Enum.Font.GothamBold
speedOnButton.TextSize = 20
speedOnButton.Parent = frame

local speedOffButton = Instance.new("TextButton")
speedOffButton.Size = UDim2.new(0, 70, 0, 40)
speedOffButton.Position = UDim2.new(0, 400, 0, 275)
speedOffButton.Text = "OFF"
speedOffButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
speedOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedOffButton.Font = Enum.Font.GothamBold
speedOffButton.TextSize = 20
speedOffButton.Parent = frame

speedOnButton.MouseButton1Click:Connect(function()
    if not speedBoostActive then
        speedBoostActive = true
        task.spawn(speedBoost)
    end
end)

speedOffButton.MouseButton1Click:Connect(function()
    speedBoostActive = false
end)

-- زر إخفاء/إظهار القائمة
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 430, 0, 70)
toggleButton.Position = UDim2.new(0, 10, 0, 470)
toggleButton.Text = "إخفاء القائمة"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 28
toggleButton.Parent = frame

local showButton = Instance.new("TextButton")
showButton.Size = UDim2.new(0, 80, 0, 80)
showButton.Position = UDim2.new(0, 0, 0, 0)
showButton.Text = "MENU"
showButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
showButton.TextColor3 = Color3.fromRGB(255, 255, 255)
showButton.Font = Enum.Font.GothamBold
showButton.TextSize = 28
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

-- إشعار عند التحميل
sendNotification("Epic Script", "Script loaded successfully by YOUDEAD1!", 5)
