-- إعدادات أساسية
local player = game.Players.LocalPlayer
local autoFarmActive = false
local autoEscapeActive = false
local menuVisible = true

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
    sendNotification("Auto Farm", "جارٍ استهداف عنق العمالقة!", 5)
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, enemy in pairs(workspace:GetDescendants()) do
                local humanoid = enemy:FindFirstChild("Humanoid")
                local neckPart = enemy:FindFirstChild("Neck") or enemy:FindFirstChild("Head")
                if humanoid and neckPart and humanoid.Health > 0 and enemy ~= player.Character then
                    -- التحرك إلى خلف العنق بدقة
                    local behindNeckCFrame = neckPart.CFrame * CFrame.new(0, 0, 3) -- 3 وحدات خلف العنق
                    player.Character.HumanoidRootPart.CFrame = behindNeckCFrame
                    -- تفعيل السلاح بدقة
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

-- دالة للهروب من العملاق (QTE)
local function autoEscape()
    sendNotification("Auto Escape", "تم تفعيل الهروب التلقائي!", 5)
    while autoEscapeActive do
        -- الكشف عن واجهة QTE في AOTR
        local qteGui = player.PlayerGui:FindFirstChild("QTEGui") -- قد تحتاج لتعديل الاسم حسب اللعبة
        if qteGui then
            -- الأزرار المطلوبة (مثل W, S, A, D)
            local keys = {"W", "S", "A", "D"} -- عدّلها حسب الأزرار المطلوبة
            for _, key in pairs(keys) do
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode[key], false, game)
                task.wait(0.05)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode[key], false, game)
            end
        end
        task.wait(0.2)
    end
end

-- إنشاء واجهة القائمة مع مؤشر مخصص
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "AotRScriptMenu"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.5, -175, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 2
frame.Parent = ScreenGui
frame.Draggable = true
frame.Active = true

-- مؤشر مخصص
local customCursor = Instance.new("ImageLabel")
customCursor.Size = UDim2.new(0, 20, 0, 20)
customCursor.BackgroundTransparency = 1
customCursor.Image = "rbxassetid://7072706765"
customCursor.ZIndex = 10
customCursor.Parent = frame
customCursor.Visible = false

-- تحديث موقع المؤشر بدقة
local mouse = player:GetMouse()
mouse.Move:Connect(function()
    if menuVisible then
        local mousePosX = mouse.X
        local mousePosY = mouse.Y
        local framePos = frame.AbsolutePosition
        local frameSize = frame.AbsoluteSize
        if mousePosX >= framePos.X and mousePosX <= framePos.X + frameSize.X and
           mousePosY >= framePos.Y and mousePosY <= framePos.Y + frameSize.Y then
            customCursor.Visible = true
            customCursor.Position = UDim2.new(0, mousePosX - framePos.X - 10, 0, mousePosY - framePos.Y - 10)
        else
            customCursor.Visible = false
        end
    end
end)

-- عنوان القائمة
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 330, 0, 50)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.Text = "AotR Script"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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

-- Auto Escape Section
local escapeLabel = Instance.new("TextLabel")
escapeLabel.Size = UDim2.new(0, 200, 0, 40)
escapeLabel.Position = UDim2.new(0, 10, 0, 120)
escapeLabel.Text = "Auto Escape"
escapeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
escapeLabel.BackgroundTransparency = 1
escapeLabel.Font = Enum.Font.Gotham
escapeLabel.TextSize = 22
escapeLabel.Parent = frame

local escapeOnButton = Instance.new("TextButton")
escapeOnButton.Size = UDim2.new(0, 50, 0, 40)
escapeOnButton.Position = UDim2.new(0, 230, 0, 120)
escapeOnButton.Text = "ON"
escapeOnButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
escapeOnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
escapeOnButton.Font = Enum.Font.GothamBold
escapeOnButton.TextSize = 18
escapeOnButton.Parent = frame

local escapeOffButton = Instance.new("TextButton")
escapeOffButton.Size = UDim2.new(0, 50, 0, 40)
escapeOffButton.Position = UDim2.new(0, 290, 0, 120)
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
toggleButton.Position = UDim2.new(0, 10, 0, 190)
toggleButton.Text = "إخفاء القائمة"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 22
toggleButton.Parent = frame

toggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    frame.Visible = menuVisible
    toggleButton.Text = menuVisible and "إخفاء القائمة" or "إظهار القائمة"
    customCursor.Visible = false
end)

-- إشعار عند التحميل
sendNotification("AotR Script", "تم تحميل السكريبت بنجاح!", 5)
