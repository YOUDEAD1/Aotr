-- إعدادات أساسية
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local autoFarmActive = false
local autoReplayActive = false
local autoEscapeActive = false

-- دالة لإرسال إشعار
local function sendNotification(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

-- دالة لقتل العمالقة (Auto Farm)
local function autoFarm()
    sendNotification("Auto Farm", "بدء استهداف العمالقة!", 5)
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, enemy in pairs(workspace:GetDescendants()) do
                local humanoid = enemy:FindFirstChild("Humanoid")
                local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                if humanoid and rootPart and humanoid.Health > 0 and enemy ~= player.Character then
                    -- التحرك إلى موقع قريب من العملاق
                    player.Character.HumanoidRootPart.CFrame = rootPart.CFrame * CFrame.new(0, 0, -5)
                    -- تفعيل السيف
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        for _ = 1, 10 do
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

-- دالة للهروب من العملاق تلقائيًا بدون كيبورد
local function autoEscape()
    sendNotification("Auto Escape", "تفعيل الهروب التلقائي!", 5)
    while autoEscapeActive do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            -- التحقق من الإمساك (سرعة الحركة صفر)
            if humanoid.WalkSpeed == 0 then
                -- إعادة تموضع اللاعب بعيدًا عن العملاق
                local safePosition = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 20) -- 20 وحدة للخلف و10 للأعلى
                player.Character.HumanoidRootPart.CFrame = safePosition
                humanoid.WalkSpeed = 16 -- إعادة السرعة إلى الوضع الطبيعي (افتراضي)
            end
        end
        task.wait(0.2)
    end
end

-- دالة لإعادة اللعب تلقائيًا (Auto Replay)
local function autoReplay()
    sendNotification("Auto Replay", "بدء إعادة اللعب التلقائي!", 5)
    while autoReplayActive do
        local gameState = game.Workspace:FindFirstChild("GameState") -- قد تحتاج لتعديل الاسم حسب اللعبة
        if gameState and (gameState.Value == "Win" or gameState.Value == "Lose") then
            game:GetService("TeleportService"):Teleport(game.PlaceId, player)
        end
        task.wait(1)
    end
end

-- إنشاء واجهة القائمة مع مؤشر مخصص
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AotRScriptMenu"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 450)
frame.Position = UDim2.new(0.5, -175, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 2
frame.Parent = ScreenGui
frame.Draggable = true
frame.Active = true

-- مؤشر مخصص باللون الأبيض
local customCursor = Instance.new("ImageLabel")
customCursor.Size = UDim2.new(0, 20, 0, 20)
customCursor.BackgroundTransparency = 1
customCursor.Image = "rbxassetid://7072706765" -- دائرة بيضاء
customCursor.ImageColor3 = Color3.fromRGB(255, 255, 255)
customCursor.ZIndex = 10
customCursor.Parent = ScreenGui
customCursor.Visible = false

-- تحديث موقع المؤشر
mouse.Move:Connect(function()
    local mousePosX = mouse.X
    local mousePosY = mouse.Y
    local framePos = frame.AbsolutePosition
    local frameSize = frame.AbsoluteSize
    if mousePosX >= framePos.X and mousePosX <= framePos.X + frameSize.X and
       mousePosY >= framePos.Y and mousePosY <= framePos.Y + frameSize.Y then
        customCursor.Visible = true
        customCursor.Position = UDim2.new(0, mousePosX - 10, 0, mousePosY - 10)
    else
        customCursor.Visible = false
    end
end)

-- عنوان القائمة
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 330, 0, 50)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.Text = "Aot Script by YOUDEAD1"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 28
titleLabel.Parent = frame

-- زر Auto Farm
local farmButton = Instance.new("TextButton")
farmButton.Size = UDim2.new(0, 200, 0, 50)
farmButton.Position = UDim2.new(0, 75, 0, 100)
farmButton.Text = "Auto Farm: OFF"
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
farmButton.Font = Enum.Font.Gotham
farmButton.TextSize = 20
farmButton.Parent = frame

farmButton.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    farmButton.Text = "Auto Farm: " .. (autoFarmActive and "ON" or "OFF")
    if autoFarmActive then
        task.spawn(autoFarm)
    end
end)

-- زر Auto Escape
local escapeButton = Instance.new("TextButton")
escapeButton.Size = UDim2.new(0, 200, 0, 50)
escapeButton.Position = UDim2.new(0, 75, 0, 160)
escapeButton.Text = "Auto Escape: OFF"
escapeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
escapeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
escapeButton.Font = Enum.Font.Gotham
escapeButton.TextSize = 20
escapeButton.Parent = frame

escapeButton.MouseButton1Click:Connect(function()
    autoEscapeActive = not autoEscapeActive
    escapeButton.Text = "Auto Escape: " .. (autoEscapeActive and "ON" or "OFF")
    if autoEscapeActive then
        task.spawn(autoEscape)
    end
end)

-- زر Auto Replay
local replayButton = Instance.new("TextButton")
replayButton.Size = UDim2.new(0, 200, 0, 50)
replayButton.Position = UDim2.new(0, 75, 0, 220)
replayButton.Text = "Auto Replay: OFF"
replayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
replayButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
replayButton.Font = Enum.Font.Gotham
replayButton.TextSize = 20
replayButton.Parent = frame

replayButton.MouseButton1Click:Connect(function()
    autoReplayActive = not autoReplayActive
    replayButton.Text = "Auto Replay: " .. (autoReplayActive and "ON" or "OFF")
    if autoReplayActive then
        task.spawn(autoReplay)
    end
end)

-- زر إخفاء/إظهار القائمة
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0, 75, 0, 380)
toggleButton.Text = "إخفاء القائمة"
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 20
toggleButton.Parent = frame

local menuVisible = true
toggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    frame.Visible = menuVisible
    toggleButton.Text = menuVisible and "إخفاء القائمة" or "إظهار القائمة"
    customCursor.Visible = false
end)

-- إشعار عند تحميل السكريبت
sendNotification("Aot Script", "تم تحميل السكريبت بنجاح بواسطة YOUDEAD1!", 5)
