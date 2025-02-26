local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local autoFarmActive = false
local autoReplayActive = false
local autoEscapeActive = false

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

-- دالة لقتل العمالقة (Auto Farm معدلة)
local function autoFarm()
    sendNotification("Auto Farm", "بدء قتل العمالقة في AOT:R!", 5)
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- البحث عن العمالقة في Workspace
            for _, enemy in pairs(workspace:GetChildren()) do
                if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                    local humanoid = enemy:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health > 0 and enemy ~= player.Character then
                        -- التحرك نحو HumanoidRootPart للعملاق
                        local enemyRoot = enemy.HumanoidRootPart
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(enemyRoot.Position) * CFrame.new(0, 0, 5) -- خلف العملاق
                        player.Character.HumanoidRootPart.CFrame = CFrame.lookAt(player.Character.HumanoidRootPart.Position, enemyRoot.Position)

                        -- تفعيل السيف
                        local tool = player.Character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                            local attackRemote = game.ReplicatedStorage:FindFirstChild("Damage") or game.ReplicatedStorage:FindFirstChild("Attack")
                            if attackRemote then
                                attackRemote:FireServer(enemyRoot, 1000) -- إرسال الضرر
                            end
                        end
                        task.wait(0.05) -- تأخير بسيط للسماح بتسجيل الضربة
                    end
                end
            end
        else
            sendNotification("خطأ", "الشخصية غير موجودة، أعد المحاولة!", 5)
        end
        task.wait(0.1) -- تأخير لتجنب التحميل الزائد
    end
end

-- أزرار التحكم
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "AOTRScriptMenu"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 450)
frame.Position = UDim2.new(0.5, -175, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Parent = ScreenGui
frame.Draggable = true
frame.Active = true

local farmButton = Instance.new("TextButton")
farmButton.Size = UDim2.new(0, 200, 0, 50)
farmButton.Position = UDim2.new(0, 75, 0, 100)
farmButton.Text = "Auto Farm: OFF"
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
farmButton.Parent = frame

farmButton.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    farmButton.Text = "Auto Farm: " .. (autoFarmActive and "ON" or "OFF")
    if autoFarmActive then
        task.spawn(autoFarm)
    end
end)

sendNotification("AOT:R Script", "تم تحميل السكريبت بنجاح!", 5)
