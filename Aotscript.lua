-- إعداد المتغيرات
local player = game.Players.LocalPlayer
local autoFarmActive = false
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", screenGui)
local startButton = Instance.new("TextButton", frame)
local stopButton = Instance.new("TextButton", frame)
local deleteButton = Instance.new("TextButton", frame)

-- إعداد إطار الواجهة
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- إعداد زر التشغيل
startButton.Size = UDim2.new(1, 0, 0, 50)
startButton.Position = UDim2.new(0, 0, 0, 0)
startButton.Text = "تشغيل Auto Farm"
startButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- إعداد زر الإيقاف
stopButton.Size = UDim2.new(1, 0, 0, 50)
stopButton.Position = UDim2.new(0, 0, 0, 60)
stopButton.Text = "إيقاف Auto Farm"
stopButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

-- إعداد زر الحذف
deleteButton.Size = UDim2.new(1, 0, 0, 50)
deleteButton.Position = UDim2.new(0, 0, 0, 120)
deleteButton.Text = "حذف السكريبت"
deleteButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)

-- وظيفة تشغيل Auto Farm
local function autoFarm()
    sendNotification("Auto Farm", "بدء قتل العمالقة في AOT:R!", 5)
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, enemy in pairs(workspace.Titans:GetChildren()) do
                local humanoid = enemy:FindFirstChild("Humanoid")
                local neck = enemy:FindFirstChild("Neck")
                if humanoid and neck and humanoid.Health > 0 and enemy ~= player.Character then
                    local playerRoot = player.Character.HumanoidRootPart
                    playerRoot.CFrame = neck.CFrame * CFrame.new(0, 0, 5)
                    playerRoot.CFrame = CFrame.lookAt(playerRoot.Position, neck.Position)

                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                        local attackRemote = game.ReplicatedStorage:FindFirstChild("Damage") or game.ReplicatedStorage:FindFirstChild("Attack")
                        if attackRemote then
                            attackRemote:FireServer(neck, 1000)
                        end
                    end
                    task.wait(0.05)
                end
            end
        else
            sendNotification("خطأ", "الشخصية غير موجودة، أعد المحاولة!", 5)
        end
        task.wait(0.1)
    end
end

-- تفعيل زر التشغيل
startButton.MouseButton1Click:Connect(function()
    autoFarmActive = true
    autoFarm()
end)

-- تفعيل زر الإيقاف
stopButton.MouseButton1Click:Connect(function()
    autoFarmActive = false
end)

-- تفعيل زر الحذف
deleteButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- إغلاق الواجهة عند الضغط على زر X
frame.CloseButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
