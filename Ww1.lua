-- التأكد من تحميل اللعبة واللاعب
local player = game.Players.LocalPlayer
if not player.Character then
    player.CharacterAdded:Wait()
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- إعداد الـ GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SimpleCheatMenu"
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

-- إعداد الإطار الرئيسي
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0.5, -125, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false

-- عنوان القائمة
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Text = "Simple Cheat Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 24

-- زر فتح/إغلاق القائمة
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = gui
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
toggleButton.Text = "Open Cheats"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- متغيرات التحكم
local aimBotEnabled = false

-- زر Aim Bot
local aimBotButton = Instance.new("TextButton")
aimBotButton.Parent = frame
aimBotButton.Size = UDim2.new(0, 220, 0, 50)
aimBotButton.Position = UDim2.new(0, 15, 0, 60)
aimBotButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
aimBotButton.Text = "Aim Bot: OFF"
aimBotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimBotButton.MouseButton1Click:Connect(function()
    aimBotEnabled = not aimBotEnabled
    aimBotButton.Text = "Aim Bot: " .. (aimBotEnabled and "ON" or "OFF")
    aimBotButton.BackgroundColor3 = aimBotEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
    if aimBotEnabled then
        print("Aim Bot Activated!")
    else
        print("Aim Bot Deactivated!")
    end
end)

-- منطق Aim Bot المحسن (باستخدام الماوس بدلاً من الكاميرا)
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function getNearestEnemy()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        print("Character or HumanoidRootPart not found!")
        return nil
    end
    
    local closestEnemy = nil
    local closestDistance = math.huge
    
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Team ~= player.Team then
            local enemyChar = otherPlayer.Character
            if enemyChar and enemyChar:FindFirstChild("Humanoid") and enemyChar.Humanoid.Health > 0 then
                local enemyHead = enemyChar:FindFirstChild("Head")
                if enemyHead then
                    local distance = (character.HumanoidRootPart.Position - enemyHead.Position).Magnitude
                    if distance < closestDistance and distance < 50 then
                        closestDistance = distance
                        closestEnemy = enemyChar
                    end
                else
                    print("No Head found for " .. otherPlayer.Name)
                end
            else
                print("No valid enemy character for " .. otherPlayer.Name)
            end
        end
    end
    
    if closestEnemy then
        print("Nearest enemy found: " .. closestEnemy.Name .. " at distance: " .. closestDistance)
    else
        print("No enemies found!")
    end
    return closestEnemy
end

RunService.RenderStepped:Connect(function()
    if aimBotEnabled then
        local target = getNearestEnemy()
        if target then
            local targetHead = target:FindFirstChild("Head")
            if targetHead then
                -- تحويل موقع العدو إلى شاشة اللاعب
                local screenPoint, onScreen = workspace.CurrentCamera:WorldToScreenPoint(targetHead.Position)
                if onScreen then
                    -- تحريك الماوس إلى موقع العدو
                    local mouse = player:GetMouse()
                    mouse.X = screenPoint.X
                    mouse.Y = screenPoint.Y
                    print("Aiming at " .. target.Name .. " at screen position: " .. screenPoint.X .. ", " .. screenPoint.Y)
                else
                    print("Target is off-screen!")
                end
            else
                print("Target head not found!")
            end
        end
    end
end)

print("Simple Cheat Menu Loaded Successfully!")
