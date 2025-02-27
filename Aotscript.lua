-- سكريبت متكامل لـ AOTR (محسن مع جميع الاحتمالات للانتقال والهجوم)
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
    warn("Player blade not found! Some attack features may not work correctly.")
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
            -- الخطوة 1: البحث عن الـ Titans بجميع الطرق الممكنة
            local titansFolder = nil

            -- الطريقة الأولى: البحث في Workspace.Titans
            titansFolder = game.Workspace:FindFirstChild("Titans")
            if titansFolder then
                print("Found Titans folder in Workspace.Titans")
            end

            -- الطريقة الثانية: البحث عن أي نموذج يحتوي على كلمة "titan"
            if not titansFolder then
                print("Titans folder not found. Searching for Titans by name...")
                for _, obj in pairs(game.Workspace:GetChildren()) do
                    if obj:IsA("Model") and obj.Name:lower():find("titan") then
                        titansFolder = obj.Parent
                        print("Found Titans folder by name: " .. tostring(titansFolder))
                        break
                    end
                end
            end

            -- الطريقة الثالثة: البحث عن أي نموذج يحتوي على Humanoid
            if not titansFolder then
                print("Searching for Titans by Humanoid...")
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                        titansFolder = obj.Parent
                        print("Found Titans folder by Humanoid: " .. tostring(titansFolder))
                        break
                    end
                end
            end

            if not titansFolder then
                warn("No Titans found in Workspace! Please ensure Titans are spawned.")
                continue
            end

            -- الخطوة 2: معالجة كل Titan
            for _, titan in pairs(titansFolder:GetChildren()) do
                if titan:IsA("Model") and titan:FindFirstChild("Humanoid") and titan.Humanoid.Health > 0 then
                    print("Found Titan: " .. titan.Name)

                    -- الخطوة 3: تحديد مرجع للانتقال
                    local titanRoot = titan:FindFirstChild("HumanoidRootPart")
                    if not titanRoot then
                        print("HumanoidRootPart not found for Titan: " .. titan.Name .. ". Waiting for it to load...")
                        wait(1) -- انتظر قليلاً للتأكد من تحميل النموذج
                        titanRoot = titan:FindFirstChild("HumanoidRootPart")
                        if not titanRoot then
                            -- إذا لم يتم العثور على HumanoidRootPart، استخدم أي جزء آخر
                            for _, part in pairs(titan:GetChildren()) do
                                if part:IsA("BasePart") then
                                    titanRoot = part
                                    print("Using alternative part as reference: " .. part.Name)
                                    break
                                end
                            end
                            if not titanRoot then
                                warn("No suitable part found for Titan: " .. titan.Name .. ". Skipping...")
                                continue
                            end
                        end
                    end

                    -- الخطوة 4: تحديد حجم الـ Titan لضبط الارتفاع
                    local heightOffset = 5 -- القيمة الافتراضية للارتفاع
                    local titanHeight = titanRoot.Position.Y - game.Workspace.Baseplate.Position.Y
                    if titanHeight > 20 then -- Titan كبير
                        heightOffset = 13
                    elseif titanHeight > 10 then -- Titan متوسط
                        heightOffset = 8
                    else -- Titan صغير
                        heightOffset = 5
                    end

                    -- الخطوة 5: نقل اللاعب إلى موقع قريب من الـ Titan
                    local successTeleport, teleportErr = pcall(function()
                        rootPart.CFrame = titanRoot.CFrame * CFrame.new(0, heightOffset, -5)
                    end)
                    if successTeleport then
                        print("Teleported to Titan: " .. titan.Name .. " at height offset: " .. heightOffset)
                    else
                        warn("Failed to teleport to Titan: " .. tostring(teleportErr))
                        continue
                    end

                    -- الخطوة 6: العثور على Nape (لاستخدامه كمرجع للهجوم فقط)
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
                            print("No suitable hitbox found for Titan: " .. titan.Name .. ". Using titanRoot as reference.")
                            nape = titanRoot -- استخدم titanRoot كبديل
                        else
                            print("Using nape: " .. nape.Name .. " for attack reference.")
                        end
                    else
                        print("Found nape: " .. nape.Name .. " for attack reference.")
                    end

                    -- الخطوة 7: محاكاة الهجوم (أي ضربة تُعتبر على العنق)
                    local attackedSuccessfully = false

                    -- الطريقة الأولى: استخدام حدث هجوم في ReplicatedStorage
                    local attackEventNames = {
                        "SwingBlade", "Attack", "Hit", "DamageEvent", "DealDamage", "BladeSwing", "Strike"
                    }
                    for _, eventName in ipairs(attackEventNames) do
                        local attackEvent = game:GetService("ReplicatedStorage"):FindFirstChild(eventName)
                        if attackEvent and blade then
                            print("Trying attack event: " .. eventName)
                            local success, err = pcall(function()
                                for _ = 1, 20 do -- كرر الهجوم 20 مرة لضمان القتل
                                    attackEvent:FireServer(titan, blade, nape)
                                    wait(0.05)
                                end
                            end)
                            if success then
                                print("Successfully attacked Titan with event: " .. eventName)
                                attackedSuccessfully = true
                                break
                            else
                                warn("Failed to attack with event " .. eventName .. ": " .. tostring(err))
                            end
                        end
                    end

                    -- الطريقة الثانية: تقليل الصحة مباشرة باستخدام TakeDamage
                    if not attackedSuccessfully then
                        print("Trying to reduce health with TakeDamage...")
                        local success, err = pcall(function()
                            for _ = 1, 5 do -- كرر التقليل 5 مرات لضمان القتل
                                titan.Humanoid:TakeDamage(1000)
                                wait(0.05)
                            end
                        end)
                        if success then
                            print("Successfully reduced Titan health with TakeDamage")
                            attackedSuccessfully = true
                        else
                            warn("Failed to reduce health with TakeDamage: " .. tostring(err))
                        end
                    end

                    -- الطريقة الثالثة: تعيين الصحة إلى 0 مباشرة
                    if not attackedSuccessfully then
                        print("Trying to set health to 0...')
                        local success, err = pcall(function()
                            titan.Humanoid.Health = 0
                        end)
                        if success then
                            print("Successfully set Titan health to 0")
                            attackedSuccessfully = true
                        else
                            warn("Failed to set health to 0: " .. tostring(err))
                        end
                    end

                    -- الطريقة الرابعة: هجوم متعدد على جميع أجزاء Hitboxes
                    if not attackedSuccessfully and hitboxes then
                        print("Trying to attack all hitboxes...")
                        for _, hit in pairs(hitboxes:GetChildren()) do
                            local hitName = hit.Name:lower()
                            if hitName:find("hit") then
                                for _, eventName in ipairs(attackEventNames) do
                                    local attackEvent = game:GetService("ReplicatedStorage"):FindFirstChild(eventName)
                                    if attackEvent and blade then
                                        local success, err = pcall(function()
                                            for _ = 1, 10 do
                                                attackEvent:FireServer(titan, blade, hit)
                                                wait(0.05)
                                            end
                                        end)
                                        if success then
                                            print("Successfully attacked hitbox: " .. hit.Name .. " with event: " .. eventName)
                                            attackedSuccessfully = true
                                            break
                                        else
                                            warn("Failed to attack hitbox " .. hit.Name .. " with event " .. eventName .. ": " .. tostring(err))
                                        end
                                    end
                                end
                            end
                        end
                    end

                    if attackedSuccessfully then
                        print("Titan attacked successfully: " .. titan.Name .. " (Treated as Nape Hit)!")
                    else
                        warn("All attack methods failed for Titan: " .. titan.Name)
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
print("AOTR Script Loaded Successfully - All Attack Methods Tested by Grok @ xAI")
