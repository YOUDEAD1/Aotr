local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = game.Workspace.CurrentCamera
local gui = Instance.new("ScreenGui")
gui.Name = "ProCheatMenu"
gui.Parent = game.StarterGui

-- إعداد الإطار الرئيسي
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 250, 0, 350)
frame.Position = UDim2.new(0.5, -125, 0.5, -175)
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
local isAiming = false

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
    if wallHackEnabled and not player.Backpack:FindFirstChild("WallhackGun") then
        createWallhackGun()
    end
end)

-- التحكم بزر الماوس الأيمن
mouse.Button2Down:Connect(function()
    if aimBotEnabled then
        isAiming = true
        print("Aim Bot: بدأ التصويب")
    end
end)

mouse.Button2Up:Connect(function()
    isAiming = false
    print("Aim Bot: توقف التصويب")
end)

-- البحث عن أقرب عدو
local function getNearestEnemy()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        print("Aim Bot: الشخصية غير جاهزة")
        return nil
    end
    
    -- التحقق من أن اللاعب لديه فريق
    if not player.Team then
        print("Aim Bot: يرجى اختيار فريق أولاً (Entente أو Central)")
        return nil
    end
    
    local closestEnemy = nil
    local closestDistance = math.huge
    
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            if otherPlayer.Team and player.Team and otherPlayer.Team ~= player.Team then
                local enemyChar = otherPlayer.Character
                if enemyChar and enemyChar:FindFirstChild("Humanoid") and enemyChar.Humanoid.Health > 0 then
                    local distance = (character.HumanoidRootPart.Position - enemyChar.HumanoidRootPart.Position).Magnitude
                    if distance < closestDistance and distance < 100 then
                        closestDistance = distance
                        closestEnemy = enemyChar
                    end
                else
                    print("Aim Bot: العدو " .. otherPlayer.Name .. " ليس لديه شخصية أو ميت")
                end
            else
                print("Aim Bot: لم يتم تعيين فريق لـ " .. otherPlayer.Name)
            end
        end
    end
    return closestEnemy
end

-- منطق الـ Aim Bot
game:GetService("RunService").RenderStepped:Connect(function()
    if aimBotEnabled and isAiming and player.Character and player.Character:FindFirstChild("Humanoid") then
        local target = getNearestEnemy()
        if target and target:FindFirstChild("Head") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Head.Position)
            print("Aim Bot: يصوّب على " .. target.Name)
            
            -- إطلاق النار مباشرة
            local targetPos = target.Head.Position
            local bullet = Instance.new("Part")
            bullet.Size = Vector3.new(0.2, 0.2, 2)
            bullet.BrickColor = BrickColor.new("Bright yellow")
            bullet.CFrame = CFrame.new(player.Character.Head.Position, targetPos)
            bullet.Velocity = (targetPos - player.Character.Head.Position).Unit * 100
            bullet.Parent = game.Workspace
            game.Debris:AddItem(bullet, 2)
            
            bullet.Touched:Connect(function(hit)
                local humanoid = hit.Parent:FindFirstChild("Humanoid")
                if humanoid and hit.Parent ~= player.Character then
                    humanoid:TakeDamage(20)
                    bullet:Destroy()
                end
            end)
        else
            print("Aim Bot: لا يوجد عدو قريب")
        end
    end
end)

-- إنشاء بندقية خارقة للجدران
local function createWallhackGun()
    local tool = Instance.new("Tool")
    tool.Name = "WallhackGun"
    tool.RequiresHandle = false
    tool.Parent = player.Backpack
    
    tool.Activated:Connect(function()
        if wallHackEnabled then
            local ray = Ray.new(player.Character.Head.Position, mouse.Hit.lookVector * 1000)
            local ignoreList = {player.Character}
            local hit, position = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
            
            if hit and hit.Parent:FindFirstChild("Humanoid") then
                hit.Parent.Humanoid:TakeDamage(50)
            end
            
            local bullet = Instance.new("Part")
            bullet.Size = Vector3.new(0.2, 0.2, 2)
            bullet.BrickColor = BrickColor.new("Bright yellow")
            bullet.CFrame = CFrame.new(player.Character.Head.Position, mouse.Hit.Position)
            bullet.Parent = game.Workspace
            game.Debris:AddItem(bullet, 1)
        end
    end)
end
