-- إعدادات أساسية
local player = game.Players.LocalPlayer
local autoFarmActive = false
local autoMissionActive = false
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
                    -- التحرك إلى خلف العنق
                    local behindNeckCFrame = neckPart.CFrame * CFrame.new(0, 0, 3) -- خلف العنق بـ 3 وحدات
                    player.Character.HumanoidRootPart.CFrame = behindNeckCFrame
                    -- تفعيل السلاح عند الوصول
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate() -- ضرب العنق
                    end
                end
            end
        end
        task.wait(0.05)
    end
end

-- دالة للهروب من العملاق (QTE)
local function autoEscape()
    while true do
        local gui = player.PlayerGui:GetChildren()
        for _, child in pairs(gui) do
            if child:IsA("ScreenGui") then
                for _, element in pairs(child:GetDescendants()) do
                    if element:IsA("TextLabel") or element:IsA("TextButton") then
                        local text = element.Text:lower()
                        if text:match("[qwerasdf]") then -- افتراض أن الحروف هي Q, W, E, R, A, S, D, F
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, text:upper(), false, game)
                            task.wait(0.1)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, text:upper(), false, game)
                        end
                    end
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

-- إنشاء واجهة القائمة الكبيرة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AotRScriptMenu"
ScreenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Parent = ScreenGui
frame.Draggable = true
frame.Active = true
frame.BorderSizePixel = 0

-- عنوان القائمة
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 280, 0, 40)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.Text = "Aot Script by YOUDEAD1"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 24
titleLabel.Parent = frame

-- Auto Farm Section
local farmLabel = Instance.new("TextLabel")
farmLabel.Size = UDim2.new(0, 180, 0, 40)
farmLabel.Position = UDim2.new(0, 10, 0, 60)
farmLabel.Text = "Auto Farm"
farmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
farmLabel.BackgroundTransparency = 1
farmLabel.Font = Enum.Font.SourceSansBold
farmLabel.TextSize = 20
farmLabel.Parent = frame

local farmOnButton = Instance.new("TextButton")
farmOnButton.Size = UDim2.new(0, 40, 0, 40)
farmOnButton.Position = UDim2.new(0, 200, 0, 60)
farmOnButton.Text = "ON"
farmOnButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
farmOnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmOnButton.Font = Enum.Font.SourceSansBold
farmOnButton.TextSize = 18
farmOnButton.Parent = frame

local farmOffButton = Instance.new("TextButton")
farmOffButton.Size = UDim2.new(0, 40, 0, 40)
farmOffButton.Position = UDim2.new(0, 250, 0, 60)
farmOffButton.Text = "OFF"
farmOffButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
farmOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmOffButton.Font = Enum.Font.SourceSansBold
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
missionLabel.Size = UDim2.new(0, 180, 0, 40)
missionLabel.Position = UDim2.new(0, 10, 0, 110)
missionLabel.Text = "Auto Mission"
missionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
missionLabel.BackgroundTransparency = 1
missionLabel.Font = Enum.Font.SourceSansBold
missionLabel.TextSize = 20
missionLabel.Parent = frame

local missionOnButton = Instance.new("TextButton")
missionOnButton.Size = UDim2.new(0, 40, 0, 40)
missionOnButton.Position = UDim2.new(0, 200, 0, 110)
missionOnButton.Text = "ON"
missionOnButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
missionOnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
missionOnButton.Font = Enum.Font.SourceSansBold
missionOnButton.TextSize = 18
missionOnButton.Parent = frame

local missionOffButton = Instance.new("TextButton")
missionOffButton.Size = UDim2.new(0, 40, 0, 40)
missionOffButton.Position = UDim2.new(0, 250, 0, 110)
missionOffButton.Text = "OFF"
missionOffButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
missionOffButton.TextColor3 = Color3.fromRGB(255, 255, 255)
missionOffButton.Font = Enum.Font.SourceSansBold
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

-- زر إخفاء/إظهار القائمة
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 280, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 340)
toggleButton.Text = "إخفاء القائمة"
toggleButton.Parent = frame
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 20

-- زر إظهار القائمة عند الإخفاء
local showButton = Instance.new("TextButton")
showButton.Size = UDim2.new(0, 50, 0, 50)
showButton.Position = UDim2.new(0, 0, 0, 0)
showButton.Text = ">"
showButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
showButton.TextColor3 = Color3.fromRGB(255, 255, 255)
showButton.Font = Enum.Font.SourceSansBold
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

-- تشغيل دالة الهروب تلقائيًا
task.spawn(autoEscape)

-- إشعار عند تحميل السكريبت
sendNotification("Aot Script", "Script loaded successfully by YOUDEAD1!", 5)
