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
            Icon = "rbxassetid://1234567890", -- استبدل الـ ID برمز إذا أردت
            Duration = duration or 5
        })
    end)
end

-- دالة لقتل العمالقة (Auto Farm)
local function autoFarm()
    sendNotification("Auto Farm", "Auto Farm has started!", 5) -- إشعار عند التشغيل
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, enemy in pairs(workspace:GetDescendants()) do
                local humanoid = enemy:FindFirstChild("Humanoid")
                local rootPart = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("Torso")
                if humanoid and rootPart and humanoid.Health > 0 and enemy ~= player.Character then
                    -- التحرك إلى العدو
                    player.Character.HumanoidRootPart.CFrame = rootPart.CFrame * CFrame.new(0, 0, -5) -- مسافة قريبة من العدو
                    -- تفعيل السلاح
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate() -- محاكاة الهجوم
                    end
                end
            end
        end
        task.wait(0.1) -- تأخير لتحسين الأداء
    end
end

-- دالة لتشغيل المهام تلقائيًا (Auto Mission)
local function autoMission()
    sendNotification("Auto Mission", "Auto Mission has started!", 5) -- إشعار عند التشغيل
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

-- إنشاء واجهة القائمة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AotRScriptMenu"
ScreenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0.5, -100, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = ScreenGui
frame.Draggable = true
frame.Active = true
frame.BorderSizePixel = 0

-- زر Auto Farm
local farmButton = Instance.new("TextButton")
farmButton.Size = UDim2.new(0, 180, 0, 50)
farmButton.Position = UDim2.new(0, 10, 0, 10)
farmButton.Text = "تشغيل Auto Farm"
farmButton.Parent = frame
farmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.Font = Enum.Font.SourceSansBold
farmButton.TextSize = 20

farmButton.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    farmButton.Text = autoFarmActive and "توقيف Auto Farm" or "تشغيل Auto Farm"
    farmButton.BackgroundColor3 = autoFarmActive and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
    if autoFarmActive then
        task.spawn(autoFarm)
    end
end)

-- زر Auto Mission
local missionButton = Instance.new("TextButton")
missionButton.Size = UDim2.new(0, 180, 0, 50)
missionButton.Position = UDim2.new(0, 10, 0, 70)
missionButton.Text = "تشغيل Auto Mission"
missionButton.Parent = frame
missionButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
missionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
missionButton.Font = Enum.Font.SourceSansBold
missionButton.TextSize = 20

missionButton.MouseButton1Click:Connect(function()
    autoMissionActive = not autoMissionActive
    missionButton.Text = autoMissionActive and "توقيف Auto Mission" or "تشغيل Auto Mission"
    missionButton.BackgroundColor3 = autoMissionActive and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
    if autoMissionActive then
        task.spawn(autoMission)
    end
end)

-- زر إخفاء/إظهار القائمة
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 180, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 130)
toggleButton.Text = "إخفاء القائمة"
toggleButton.Parent = frame
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 20

toggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    frame.Visible = menuVisible
    toggleButton.Text = menuVisible and "إخفاء القائمة" or "إظهار القائمة"
end)

-- إشعار عند تحميل السكريبت
sendNotification("Aot Script", "Script loaded successfully by YOUDEAD1!", 5)
