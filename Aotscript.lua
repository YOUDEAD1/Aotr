-- سكريبت متكامل لـ AOTR (محسن لإصلاح الانتقال إلى الـ Titan)
-- التاريخ: 28 فبراير 2025

-- إعداد مكتبة واجهة المستخدم (UI Library)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AOTR Script - Powered by xAI", "Ocean")

-- تحقق من وجود اللاعب والشخصية
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- العثور على الشفرة الخاصة باللاعب (Blade)
local playerRig = character:FindFirstChild(player.Name .. "_RIG") or character:FindFirstChild("RIG_" .. player.Name)
local blade = nil
if playerRig then
    for i = 1, 7 do
        local possibleBlade = playerRig:FindFirstChild("Blade_" .. i)
        if possibleBlade then
            blade = possibleBlade
            break
        end
    end
end
if not blade then
    warn("Player blade not found! Some features may not work correctly.")
end

-- القسم الأول: Auto-Farm (محسن لقتل الـ Titans)
local AutoFarmTab = Window:NewTab("Auto Farm")
local AutoFarmSection = AutoFarmTab:NewSection("Auto Farm Controls")
local AutoFarmEnabled = false

AutoFarmSection:NewToggle("Enable Auto Farm", "Automatically kills Titans (entire body as weak point)", function(state)
    AutoFarmEnabled = state
    if AutoFarmEnabled then
        print("Auto Farm Enabled!")
        while AutoFarmEnabled and wait(0.1) do
            -- استهداف الـ Titans في Workspace.Titans
            local titansFolder = game.Workspace:FindFirstChild("Titans")
            if not titansFolder then
                warn("Titans folder not found in Workspace! Searching for alternative...")
                -- بحث بديل عن الـ Titans في Workspace
                for _, obj in pairs(game.Workspace:GetChildren()) do
                    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Name:lower():find("titan") then
                        titansFolder = obj.Parent
                        break
                    end
                end
                if not titansFolder then
                    warn("No Titans found in Workspace!")
                    continue
                end
            end

            for _, titan in pairs(titansFolder:GetChildren()) do
                if titan:IsA("Model") and titan:FindFirstChild("Humanoid") and titan.Humanoid.Health > 0 then
                    print("Found Titan: " .. titan.Name)

                    -- تحديد موقع الـ Titan
                    local titanRoot = titan:FindFirstChild("HumanoidRootPart")
                    if not titanRoot then
                        -- إذا لم يتم العثور على HumanoidRootPart، انتظر قليلاً ثم حاول مرة أخرى
                        wait(0.5)
                        titanRoot = titan:FindFirstChild("HumanoidRootPart")
                        if not titanRoot then
                            -- إذا لم يتم العثور عليه، استخدم أي جزء كمرجع
                            for _, part in pairs(titan:GetChildren()) do
                                if part:IsA("BasePart") then
                                    titanRoot = part
                                    break
                                end
                            end
                            if not titanRoot then
                                warn("No suitable part found for Titan: " .. titan.Name)
                                continue
                            end
                        end
                    end

                    -- تحديد حجم الـ Titan بناءً على ارتفاع المرجع (titanRoot)
                    local heightOffset = 5 -- القيمة الافتراضية للارتفاع
                    local titanHeight = titanRoot.Position.Y - game.Workspace.Baseplate.Position.Y
                    if titanHeight > 20 then -- Titan كبير
                        heightOffset = 13
                    elseif titanHeight > 10 then -- Titan متوسط
                        heightOffset = 8
                    else -- Titan صغير
                        heightOffset = 5
                    end

                    -- نقل اللاعب إلى موقع عام قرب الـ Titan
                    rootPart.CFrame = titanRoot.CFrame * CFrame.new(0, heightOffset, -5)
                    print("Teleported to Titan: " .. titan.Name)

                    -- العثور على Nape (لاستخدامه كمرجع للهجوم فقط، لكن أي ضربة ستُعتبر على العنق)
                    local hitboxes = titan:FindFirstChild("Hitboxes")
                    local nape = nil
                    if hitboxes then
                        for _, hit in pairs(hitboxes:GetChildren()) do
                            local hitName = hit.Name:lower()
                            if (hitName:find("nape") or hitName:find("neckhit")) and not hitName:find("fake") then
                                nape = hit
                                break
                            end
                        end
                        if not nape then
                            for _, hit in pairs(hitboxes:GetChildren()) do
                                local hitName = hit.Name:lower()
                                if hitName:find("hit") and not hitName:find("fake") and not hitName:find("head") then
                                    nape = hit
                                    break
                                end
                            end
                        end
                    end
                    if not nape then
                        nape = titan:FindFirstChild("Head") or titan:FindFirstChild("HumanoidRootPart")
                        if nape and nape.Name:lower():find("fake") then
                            nape = titan:FindFirstChild("HumanoidRootPart") -- تجنب الرأس المزيف
                        end
                        if not nape then
                            warn("No suitable hitbox found for Titan: " .. titan.Name)
                            nape = titanRoot -- استخدم titanRoot كبديل
                        end
                    end

                    -- محاكاة الهجوم (أي ضربة تُعتبر على العنق)
                    local success, err = pcall(function()
                        -- البحث عن حدث هجوم في ReplicatedStorage
                        local attackEvent = game:GetService("ReplicatedStorage"):FindFirstChild("Hit") or
                                            game:GetService("ReplicatedStorage"):FindFirstChild("DamageEvent") or
                                            game:GetService("ReplicatedStorage"):FindFirstChild("SwingBlade") or
                                            game:GetService("ReplicatedStorage"):FindFirstChild("Attack")
                        if attackEvent and blade then
                            for _ = 1, 20 do -- كرر الهجوم 20 مرة لضمان القتل
                                attackEvent:FireServer(titan, blade, nape) -- الهجوم يُحسب وكأنه على العنق
                                wait(0.05)
                            end
                        else
                            -- إذا لم يتم العثور على الحدث، قلل الصحة مباشرة
                            titan.Humanoid:TakeDamage(500) -- تقليل الصحة بمقدار كبير لضمان القتل
                        end
                    end)
                    if not success then
                        warn("Failed to attack Titan: " .. tostring(err))
                        -- طريقة احتياطية: تقليل الصحة مباشرة
                        local damageSuccess, damageErr = pcall(function()
                            titan.Humanoid:TakeDamage(500)
                        end)
                        if not damageSuccess then
                            warn("Failed to damage Titan directly: " .. tostring(damageErr))
                        end
                    else
                        print("Attacked Titan: " .. titan.Name .. " (Treated as Nape Hit)!")
                    end
                end
            end
        end
    else
        print("Auto Farm Disabled!")
    end
end)

-- القسم الثاني: السرعة والطيران
local MovementTab = Window:NewTab("Movement")
local MovementSection = MovementTab:NewSection("Speed & Fly")
local SpeedEnabled = false
local FlyEnabled = false
local DefaultSpeed = humanoid.WalkSpeed or 16

MovementSection:NewToggle("Super Speed", "Increases your movement speed", function(state)
    SpeedEnabled = state
    if SpeedEnabled then
        local success, err = pcall(function()
            humanoid.WalkSpeed = 100
        end)
        if not success then
            warn("Failed to set WalkSpeed: " .. tostring(err))
            -- طريقة بديلة باستخدام CFrame
            spawn(function()
                while SpeedEnabled and wait() do
                    if humanoid.MoveDirection.Magnitude > 0 then
                        rootPart.CFrame = rootPart.CFrame + humanoid.MoveDirection * 5
                    end
                end
            end)
        else
            print("Super Speed Enabled!")
        end
    else
        humanoid.WalkSpeed = DefaultSpeed
        print("Super Speed Disabled!")
    end
end)

MovementSection:NewToggle("Fly", "Enables flying", function(state)
    FlyEnabled = state
    if FlyEnabled then
        local success, err = pcall(function()
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.Velocity = Vector3.new(0, 50, 0)
            BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyVelocity.Parent = rootPart

            local BodyGyro = Instance.new("BodyGyro")
            BodyGyro.D = 100
            BodyGyro.P = 3000
            BodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
            BodyGyro.Parent = rootPart

            while FlyEnabled and wait() do
                local direction = humanoid.MoveDirection * 50
                BodyVelocity.Velocity = Vector3.new(direction.X, BodyVelocity.Velocity.Y, direction.Z)
            end
            BodyVelocity:Destroy()
            BodyGyro:Destroy()
        end)
        if not success then
            warn("Failed to enable Fly: " .. tostring(err))
            -- طريقة بديلة باستخدام CFrame
            spawn(function()
                while FlyEnabled and wait() do
                    rootPart.CFrame = rootPart.CFrame * CFrame.new(humanoid.MoveDirection * 5 + Vector3.new(0, 2, 0))
                end
            end)
        else
            print("Fly Enabled!")
        end
    end
end)

-- القسم الثالث: العناصر البصرية (باستخدام BillboardGui)
local VisualsTab = Window:NewTab("Visuals")
local VisualsSection = VisualsTab:NewSection("Visual ESP")
local VisualsEnabled = false

local encodedTable = {
    "sb94mq1=", "AJ54l+t=", "lw0MO3v=", "Wd0aXmykzv==", "4uPmxi==", "U9p3hYh=",
    "d07D97H=", "9/AJXd1=", "xrBbpqm=", "U+fNWRo=", "z2o=", "PSvu/v==", "qJMWUXh=",
    "9gXs3CM=", "GVx4Ii3="
}

VisualsSection:NewToggle("Enable Visuals", "Shows random text above player", function(state)
    VisualsEnabled = state
    if VisualsEnabled then
        local success, err = pcall(function()
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Size = UDim2.new(0, 200, 0, 50)
            billboardGui.StudsOffset = Vector3.new(0, 5, 0)
            billboardGui.AlwaysOnTop = true
            billboardGui.Parent = rootPart

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.new(1, 0, 0)
            textLabel.TextScaled = true
            textLabel.Parent = billboardGui

            spawn(function()
                while VisualsEnabled and wait(1) do
                    local randomText = encodedTable[math.random(1, #encodedTable)]
                    textLabel.Text = randomText
                end
            end)

            spawn(function()
                while VisualsEnabled and wait() do end
                billboardGui:Destroy()
            end)
        end)
        if not success then
            warn("Failed to enable Visuals: " .. tostring(err))
        else
            print("Visuals Enabled!")
        end
    end
end)

-- رسالة ترحيب
print("AOTR Script Loaded Successfully - Fixed Teleport Issue by Grok @ xAI")
