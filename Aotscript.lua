-- سكريبت محسن لـ AOTR (إصلاح Tekkit Hub Loader)
-- التاريخ: 28 فبراير 2025

print("AOTR Script Loader Starting - Grok @ xAI")

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

-- دالة لتحميل وتشغيل السكريبت الرئيسي
local function runScript()
    local success, result = pcall(function()
        local scriptContent = game:HttpGet("https://raw.githubusercontent.com/zerunquist/TekkitAotr/refs/heads/main/main")
        if scriptContent then
            print("Successfully loaded script content from URL!")
            return loadstring(scriptContent)()
        else
            warn("Failed to load script content: Content is empty.")
            return nil
        end
    end)

    if success and result then
        print("Tekkit Hub script executed successfully!")
    else
        warn("Failed to load or execute Tekkit Hub script: " .. tostring(result))
        -- تشغيل سكريبت احتياطي بسيط
        print("Starting backup Auto-Farm script...")
        while wait(0.1) do
            local titansFolder = game.Workspace:FindFirstChild("Titans")
            if not titansFolder then
                warn("No Titans found in Workspace! Please ensure Titans are spawned.")
                continue
            end

            for _, titan in pairs(titansFolder:GetChildren()) do
                if titan:IsA("Model") and titan:FindFirstChild("Humanoid") and titan.Humanoid.Health > 0 then
                    print("Found Titan: " .. titan.Name)
                    local titanRoot = titan:FindFirstChild("HumanoidRootPart")
                    if not titanRoot then
                        wait(2)
                        titanRoot = titan:FindFirstChild("HumanoidRootPart")
                        if not titanRoot then
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

                    -- نقل اللاعب إلى الـ Titan
                    local successTeleport, teleportErr = pcall(function()
                        rootPart.CFrame = titanRoot.CFrame * CFrame.new(0, 5, -5)
                    end)
                    if successTeleport then
                        print("Teleported to Titan: " .. titan.Name)
                    else
                        warn("Failed to teleport to Titan: " .. tostring(teleportErr))
                        continue
                    end

                    -- هجوم مباشر
                    local attackEventNames = {"BladeHit", "SwingBlade", "Attack"}
                    local attacked = false
                    for _, eventName in ipairs(attackEventNames) do
                        local attackEvent = game:GetService("ReplicatedStorage"):FindFirstChild(eventName)
                        if attackEvent then
                            local success, err = pcall(function()
                                for _ = 1, 30 do
                                    attackEvent:FireServer(titan)
                                    wait(0.03)
                                end
                            end)
                            if success then
                                print("Successfully attacked Titan with event: " .. eventName)
                                attacked = true
                                break
                            else
                                warn("Failed to attack with event " .. eventName .. ": " .. tostring(err))
                            end
                        end
                    end

                    if not attacked then
                        local success, err = pcall(function()
                            titan.Humanoid:TakeDamage(1000)
                        end)
                        if success then
                            print("Successfully reduced Titan health with TakeDamage")
                        else
                            warn("Failed to reduce health: " .. tostring(err))
                        end
                    end
                end
            end
        end
    end
end

-- تشغيل السكريبت عند بدء اللعبة
runScript()

-- إعادة تشغيل السكريبت كل 5 ثوانٍ
while true do
    wait(5)
    print("Attempting to reload Tekkit Hub script...")
    runScript()
end
