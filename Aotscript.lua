-- سكريبت فائق التبسيط لـ AOTR (مستوحى من Tekkit Hub)
-- التاريخ: 28 فبراير 2025

print("AOTR Script Starting - Ultra Simple Version - Grok @ xAI")

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

-- وظيفة Auto-Farm مباشرة
print("Starting OP Autofarm...")
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
        for _, obj in pairs(game.Workspace:GetChildren()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
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

            -- الخطوة 4: نقل اللاعب إلى الـ Titan
            local successTeleport, teleportErr = pcall(function()
                rootPart.CFrame = titanRoot.CFrame * CFrame.new(0, 5, -5)
            end)
            if successTeleport then
                print("Teleported to Titan: " .. titan.Name)
            else
                warn("Failed to teleport to Titan: " .. tostring(teleportErr))
                continue
            end

            -- الخطوة 5: محاكاة الهجوم (أي ضربة تُعتبر على العنق)
            local attackedSuccessfully = false
            local attackEventNames = {
                "SwingBlade", "Attack", "Hit", "DamageEvent", "DealDamage", "BladeSwing", "Strike", "BladeHit"
            }
            for _, eventName in ipairs(attackEventNames) do
                local attackEvent = game:GetService("ReplicatedStorage"):FindFirstChild(eventName)
                if attackEvent then
                    print("Trying attack event: " .. eventName)
                    local success, err = pcall(function()
                        for _ = 1, 30 do -- كرر الهجوم 30 مرة
                            attackEvent:FireServer(titan)
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
end

print("AOTR Script Loaded Successfully - Ultra Simple Version by Grok @ xAI")
