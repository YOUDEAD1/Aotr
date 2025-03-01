-- التأكد من تحميل اللعبة
local player = game.Players.LocalPlayer
if not player.Character then
    player.CharacterAdded:Wait()
end

-- التأكد من تحميل Workspace
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- إعداد الـ GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ProCheatMenu"
gui.IgnoreGuiInset = true -- لضمان ظهور الـ GUI بشكل صحيح
gui.Parent = game.CoreGui

-- إعداد الإطار الرئيسي
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 250, 0, 400)
frame.Position = UDim2.new(0.5, -125, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false

-- عنوان القائمة
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Text = "Pro Cheat Menu"
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
local wallHackEnabled = false

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
end)

-- زر Wallhack Bullets
local wallHackButton = Instance.new("TextButton")
wallHackButton.Parent = frame
wallHackButton.Size = UDim2.new(0, 220, 0, 50)
wallHackButton.Position = UDim2.new(0, 15, 0, 120)
wallHackButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
wallHackButton.Text = "Wallhack Bullets: OFF"
wallHackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
wallHackButton.MouseButton1Click:Connect(function()
    wallHackEnabled = not wallHackEnabled
    wallHackButton.Text = "Wallhack Bullets: " .. (wallHackEnabled and "ON" or "OFF")
    wallHackButton.BackgroundColor3 = wallHackEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
    
    -- إعطاء السلاح عند التفعيل
    if wallHackEnabled and not player.Backpack:FindFirstChild("WallhackGun") then
        local tool = Instance.new("Tool")
        tool.Name = "WallhackGun"
        tool.RequiresHandle = false
        tool.Parent = player.Backpack
        tool.Activated:Connect(function()
            if wallHackEnabled and player.Character then
                local head = player.Character:FindFirstChild("Head")
                if not head then return end
                
                local rayOrigin = head.Position
                local rayDirection = player:GetMouse().Hit.lookVector * 1000
                local ray = Ray.new(rayOrigin, rayDirection)
                local ignoreList = {player.Character}
                
                -- تجاهل TrenchWall
                local trench = workspace:FindFirstChild("TRENCH")
                if trench then
                    for _, trenchWall in pairs(trench:GetChildren()) do
                        if trenchWall.Name == "TrenchWall" then
                            table.insert(ignoreList, trenchWall)
                        end
                    end
                end
                
                local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
                
                if hit and hit.Parent:FindFirstChild("Humanoid") then
                    hit.Parent.Humanoid:TakeDamage(50)
                end
            end
        end)
    end
end)

-- زر إعطاء سلاح من اللعبة
local weaponButton = Instance.new("TextButton")
weaponButton.Parent = frame
weaponButton.Size = UDim2.new(0, 220, 0, 50)
weaponButton.Position = UDim2.new(0, 15, 0, 180)
weaponButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
weaponButton.Text = "Get WW1 Rifle"
weaponButton.TextColor3 = Color3.fromRGB(255, 255, 255)
weaponButton.MouseButton1Click:Connect(function()
    local trench = workspace:FindFirstChild("TRENCH")
    if trench then
        local greatWar = trench:FindFirstChild("1914 - THE GREAT WAR")
        if greatWar then
            local rifle = greatWar:FindFirstChildWhichIsA("Tool")
            if rifle then
                local clonedRifle = rifle:Clone()
                clonedRifle.Parent = player.Backpack
                print("تم إعطاؤك سلاح WW1!")
            else
                print("لم يتم العثور على أي سلاح في 1914 - THE GREAT WAR!")
            end
        else
            print("لم يتم العثور على 1914 - THE GREAT WAR!")
        end
    else
        print("لم يتم العثور على TRENCH!")
    end
end)

-- زر زيادة السرعة
local speedButton = Instance.new("TextButton")
speedButton.Parent = frame
speedButton.Size = UDim2.new(0, 220, 0, 50)
speedButton.Position = UDim2.new(0, 15, 0, 240)
speedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedButton.Text = "Increase Speed"
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
speedButton.MouseButton1Click:Connect(function()
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 32
        print("تم زيادة سرعتك!")
    end
end)

-- منطق Aim Bot المحسن
local function getNearestEnemy()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    
    local closestEnemy = nil
    local closestDistance = math.huge
    
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Team ~= player.Team then
            local enemyChar = otherPlayer.Character
            if enemyChar and enemyChar:FindFirstChild("Humanoid") and enemyChar.Humanoid.Health > 0 then
                local distance = (character.HumanoidRootPart.Position - enemyChar.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance and distance < 50 then
                    closestDistance = distance
                    closestEnemy = enemyChar
                end
            end
        end
    end
    return closestEnemy
end

game:GetService("RunService").RenderStepped:Connect(function()
    if aimBotEnabled then
        local target = getNearestEnemy()
        if target and player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, target.HumanoidRootPart.Position)
            end
        end
    end
end)

print("Cheat Menu Loaded Successfully!")
