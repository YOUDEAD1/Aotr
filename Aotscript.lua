local player = game.Players.LocalPlayer
local autoFarmActive = false

local function sendNotification(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

local function autoFarm()
    sendNotification("Auto Farm", "بدء قتل العمالقة!", 5)
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, titan in pairs(workspace.Titans:GetChildren()) do
                local humanoid = titan:FindFirstChildOfClass("Humanoid")
                local rootPart = titan:FindFirstChild("HumanoidRootPart")
                local hitboxFolder = titan:FindFirstChild("Hitboxes")
                
                if humanoid and rootPart and hitboxFolder and humanoid.Health > 0 then
                    local playerRoot = player.Character.HumanoidRootPart
                    playerRoot.CFrame = rootPart.CFrame * CFrame.new(0, 0, 5)
                    playerRoot.CFrame = CFrame.lookAt(playerRoot.Position, rootPart.Position)

                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                        local attackRemote = game.ReplicatedStorage:FindFirstChild("Damage") or game.ReplicatedStorage:FindFirstChild("Attack")
                        if attackRemote then
                            attackRemote:FireServer(hitboxFolder, 1000)
                        end
                    end
                    task.wait(0.1)
                end
            end
        else
            sendNotification("خطأ", "لم يتم العثور على الشخصية!", 5)
        end
        task.wait(0.1)
    end
end

local function toggleAutoFarm()
    autoFarmActive = not autoFarmActive
    sendNotification("Auto Farm", autoFarmActive and "تشغيل" or "إيقاف", 3)
    if autoFarmActive then
        task.spawn(autoFarm)
    end
end

toggleAutoFarm()
