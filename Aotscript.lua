-- سكريبت محسن لـ AOTR (مستوحى من Tekkit Hub)
-- التاريخ: 28 فبراير 2025

print("AOTR Script Starting - Inspired by Tekkit Hub - Grok @ xAI")

-- تحقق من وجود اللاعب والشخصية
local player = game.Players.LocalPlayer
local character = player.Character
if not character then
    print("Waiting for character to load...")
    character = player.CharacterAdded:Wait()
end
local humanoid = character:WaitForChild("Humanoid", 5)
local rootPart = character:WaitForChild("HumanoidRootPart", 5)

if not humanoid or not rootPart then
    warn("Failed to find Humanoid or HumanoidRootPart. Script cannot continue.")
    return
end
print("Character loaded successfully!")

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

-- وظيفة Auto-Farm (محاكاة OP Autofarm)
print("OP Autofarm Starting...")
while wait(0.1) do
    -- الخطوة 1: البحث عن الـ Titans
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
                wait(2)
                titanRoot = titan:FindFirstChild("HumanoidRootPart")
                if not titanRoot then
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
            local heightOffset = 5
            local titanHeight = titanRoot.Position.Y - game.Workspace.Baseplate.Position.Y
            if titanHeight > 20 then -- Titan كبير
                heightOffset = 13
            elseif titanHeight > 10 then -- Titan متوسط
                heightOffset = 8
            else -- Titan صغير
                heightOffset = 5
            end

            -- الخطوة 5: نقل اللاعب إلى الـ Titan
            local successTeleport, teleportErr = pcall(function()
                rootPart.CFrame = titanRoot.CFrame * CFrame.new(0, heightOffset, -5)
            end)
            if successTeleport then
                print("Teleported to Titan: " .. titan.Name .. " at height offset: " .. heightOffset)
            else
                warn("Failed to teleport to Titan: " .. tostring(teleportErr))
                continue
            end

            -- الخطوة 6: محاكاة Nape Extend (أي ضربة تُعتبر على العنق)
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
                    nape = titan:FindFirstChild("HumanoidRootPart")
                end
                if not nape then
                    print("No suitable hitbox found for Titan: " .. titan.Name .. ". Using titanRoot as reference.")
                    nape = titanRoot
                else
                    print("Using nape: " .. nape.Name .. " for attack reference.")
                end
            else
                print("Found nape: " .. nape.Name .. " for attack reference.")
            end

            -- الخطوة 7: محاكاة الهجوم (OP Autofarm)
            local attackedSuccessfully = false
            local attackEventNames = {
                "SwingBlade", "Attack", "Hit", "DamageEvent", "DealDamage", "BladeSwing", "Strike", "BladeHit"
            }
            for _, eventName in ipairs(attackEventNames) do
                local attackEvent = game:GetService("ReplicatedStorage"):FindFirstChild(eventName)
                if attackEvent and blade then
                    print("Trying attack event: " .. eventName)
                    local success, err = pcall(function()
                        for _ = 1, 30 do -- كرر الهجوم 30 مرة لضمان القتل
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

            -- الطريقة الاحتياطية: تقليل الصحة مباشرة
            if not attackedSuccessfully then
                print("Trying to reduce health with TakeDamage...")
                local success, err = pcall(function()
                    for _ = 1, 5 do
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

            -- الطريقة الاحتياطية الثانية: تعيين الصحة إلى 0
            if not attackedSuccessfully then
                print("Trying to set health to 0...")
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

            if attackedSuccessfully then
                print("Titan killed successfully: " .. titan.Name .. " (Treated as Nape Hit)!")
            else
                warn("All attack methods failed for Titan: " .. titan.Name)
            end
        end
    end

    -- الخطوة 8: إعادة تعبئة الشفرات (Blade Refill)
    if playerRig and blade then
        local bladeHealth = blade:FindFirstChild("Health") or blade:FindFirstChild("Durability")
        if bladeHealth and bladeHealth:IsA("IntValue") and bladeHealth.Value < 100 then
            print("Refilling blade durability...")
            local success, err = pcall(function()
                bladeHealth.Value = 100
            end)
            if success then
                print("Blade durability refilled!")
            else
                warn("Failed to refill blade durability: " .. tostring(err))
            end
        end
    end

    -- الخطوة 9: منع الإمساك (Auto Grab)
    local antiGrabEvent = game:GetService("ReplicatedStorage"):FindFirstChild("GrabEvent") or
                          game:GetService("ReplicatedStorage"):FindFirstChild("OnGrab")
    if antiGrabEvent then
        print("Attempting to prevent grabbing...")
        local success, err = pcall(function()
            antiGrabEvent:FireServer(false) -- محاولة إلغاء الإمساك
        end)
        if success then
            print("Grab prevention activated!")
        else
            warn("Failed to prevent grabbing: " .. tostring(err))
        end
    end
end

print("AOTR Script Loaded Successfully - Tekkit Hub Inspired by Grok @ xAI")
