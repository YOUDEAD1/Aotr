-- إعدادات أساسية
local player = game.Players.LocalPlayer
local autoFarmActive = false

-- دالة إرسال إشعارات
local function sendNotification(title, text, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

-- البحث عن RemoteEvent للهجوم
local attackRemote
for _, v in pairs(game.ReplicatedStorage:GetChildren()) do
    if v:IsA("RemoteEvent") then
        print("RemoteEvent موجود:", v.Name)
        attackRemote = v
    end
end

-- دالة قتل العمالقة (Auto Farm)
local function autoFarm()
    sendNotification("Auto Farm", "بدء قتل العمالقة!", 5)
    print("تم تشغيل Auto Farm!")
    
    while autoFarmActive do
        local titansFolder = workspace:FindFirstChild("hitboxes")  -- البحث داخل hitboxes
        if titansFolder then
            for _, titan in pairs(titansFolder:GetChildren()) do
                if titan:IsA("Model") then
                    local humanoid = titan:FindFirstChild("Humanoid")
                    local rootPart = titan:FindFirstChild("HumanoidRootPart")
                    local nape = titan:FindFirstChild("Nape") -- نقطة الضعف

                    if humanoid and rootPart and nape and humanoid.Health > 0 then
                        print("تم العثور على عملاق:", titan.Name)

                        -- تحريك اللاعب خلف العنق
                        local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if playerRoot then
                            playerRoot.CFrame = nape.CFrame * CFrame.new(0, 0, 5) -- يتمركز خلف العنق
                            playerRoot.CFrame = CFrame.lookAt(playerRoot.Position, nape.Position)
                        end

                        -- إرسال الهجوم
                        if attackRemote then
                            attackRemote:FireServer(nape, 1000) -- إرسال الضرر للعنق
                            print("تم إرسال الهجوم على:", titan.Name)
                        else
                            print("لم يتم العثور على RemoteEvent للهجوم!")
                        end

                        task.wait(0.05) -- انتظار قبل الانتقال للهدف التالي
                    end
                end
            end
        else
            print("لم يتم العثور على مجلد hitboxes!")
        end
        task.wait(0.1)
    end
end

-- إنشاء زر التحكم
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", ScreenGui)
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0.5, -100, 0.5, -25)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local farmButton = Instance.new("TextButton", frame)
farmButton.Size = UDim2.new(1, 0, 1, 0)
farmButton.Text = "Auto Farm: OFF"
farmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
farmButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
farmButton.Font = Enum.Font.Gotham
farmButton.TextSize = 18

-- زر التشغيل/الإيقاف
farmButton.MouseButton1Click:Connect(function()
    autoFarmActive = not autoFarmActive
    farmButton.Text = "Auto Farm: " .. (autoFarmActive and "ON" or "OFF")
    if autoFarmActive then
        task.spawn(autoFarm)
    end
end)

sendNotification("AOT:R Script", "تم تحميل السكربت بنجاح!", 5)
