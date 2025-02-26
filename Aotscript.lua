
local player = game.Players.LocalPlayer
local autoFarmActive = false

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

-- دالة لقتل العمالقة
local function autoFarm()
    sendNotification("Auto Farm", "بدء قتل العمالقة في AOT:R!", 5)
    while autoFarmActive do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, enemy in pairs(workspace.Titans:GetChildren()) do
                local humanoid = enemy:FindFirstChild("Humanoid")
                local neck = enemy:FindFirstChild("Neck") -- أو NeckRigAttachment
                if humanoid and neck and humanoid.Health > 0 and enemy ~= player.Character then
                    -- التحرك إلى موقع العنق وضبط الاتجاه لمواجهته
                    local playerRoot = player.Character.HumanoidRootPart
                    playerRoot.CFrame = neck.CFrame * CFrame.new(0, 0, 5) -- خلف العنق بمسافة 5 وحدات
                    playerRoot.CFrame = CFrame.lookAt(playerRoot.Position, neck.Position)

                    -- تفعيل السيف
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                        local attackRemote = game.ReplicatedStorage:FindFirstChild("Damage") or game.ReplicatedStorage:FindFirstChild("Attack")
                        if attackRemote then
                            attackRemote:FireServer(neck, 1000) -- افتراض ضرر عالٍ لضمان القتل
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

-- واجهة المستخدم
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "ScriptMenu"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Parent = ScreenGui
frame.Draggable = true

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0, 50, 0, 20)
toggleButton.Text = "Auto Farm: OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.Parent = frame

toggleButton.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    toggleButton.Text = "Auto Farm: " .. (autoFarmActive and "ON" or "OFF")
    if autoFarmActive then
        task.spawn(autoFarm)
    end
end)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 200, 0, 50)
closeButton.Position = UDim2.new(0, 50, 0, 100)
closeButton.Text = "حذف السكربت"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

sendNotification("AOT:R Script", "تم تحميل السكريبت بنجاح!", 5)
