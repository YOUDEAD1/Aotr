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

-- دالة لقتل العمالقة (Auto Farm معدلة)
local function autoFarm()
    sendNotification("Auto Farm", "بدء قتل العمالقة في AOT:R!", 5)
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- البحث عن العمالقة في Workspace
            for _, enemy in pairs(workspace:GetChildren()) do
                local humanoid = enemy:FindFirstChild("Humanoid")
                local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                local nape = enemy:FindFirstChild("Nape") -- مؤخرة العنق كنقطة الضعف
                if humanoid and rootPart and nape and humanoid.Health > 0 and enemy ~= player.Character then
                    -- التحرك مباشرة إلى مؤخرة العنق
                    player.Character.HumanoidRootPart.CFrame = nape.CFrame * CFrame.new(0, 0, 2) -- وضع اللاعب خلف العنق
                    -- تفعيل السيف
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                        -- محاكاة الضربة على مؤخرة العنق
                        local attackRemote = game.ReplicatedStorage:FindFirstChild("Damage") or game.ReplicatedStorage:FindFirstChild("Attack")
                        if attackRemote then
                            -- إرسال موقع العنق مع ضرر كافٍ للقتل
                            attackRemote:FireServer(nape.Position, 1000) -- افتراض ضرر عالٍ لضمان القتل
                        end
                    end
                    task.wait(0.05) -- تأخير بسيط بين الهجمات
                end
            end
        else
            sendNotification("خطأ", "الشخصية غير موجودة، أعد المحاولة!", 5)
        end
        task.wait(0.1) -- تأخير لتجنب التحميل الزائد
    end
end

-- دالة للهروب تلقائيًا من العملاق
local function autoEscape()
    sendNotification("Auto Escape", "تفعيل الهروب التلقائي في AOT:R!", 5)
    while autoEscapeActive do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            if player.Character.Humanoid.WalkSpeed == 0 then
                player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, 40)
                player.Character.Humanoid.WalkSpeed = 16
                sendNotification("Escape", "تم الهروب من العملاق!", 3)
            end
        end
        task.wait(0.5)
    end
end

-- دالة لإعادة اللعب تلقائيًا
local function autoReplay()
    sendNotification("Auto Replay", "بدء إعادة اللعب التلقائي في AOT:R!", 5)
    while autoReplayActive do
        local endGui = player.PlayerGui:FindFirstChild("MissionEndMenu")
        if endGui then
            local retryButton = endGui:FindFirstChild("Retry") or endGui:FindFirstChild("PlayAgain")
            if retryButton then
                if retryButton:IsA("TextButton") then
                    retryButton:Activate()
                end
                local clickEvent = retryButton:FindFirstChildOfClass("RemoteEvent")
                if clickEvent then
                    clickEvent:FireServer()
                end
            else
                game:GetService("TeleportService"):Teleport(game.PlaceId, player)
            end
            task.wait(2)
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

local customCursor = Instance.new("ImageLabel")
customCursor.Size = UDim2.new(0, 20, 0, 20)
customCursor.BackgroundTransparency = 1
customCursor.Image = "rbxassetid://7072706765"
customCursor.ImageColor3 = Color3.fromRGB(255, 255, 255)
customCursor.ZIndex = 10
customCursor.Parent = ScreenGui
customCursor.Visible = false

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

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 330, 0, 50)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.Text = "AOT:R Script by YOUDEAD1"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 28
titleLabel.Parent = frame

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

sendNotification("AOT:R Script", "تم تحميل السكريبت بنجاح بواسطة YOUDEAD1!", 5)
