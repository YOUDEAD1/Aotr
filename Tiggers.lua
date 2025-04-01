-- تحميل مكتبة Kavo UI الخارجية
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Auto Farm GUI - Monkey Quest", "DarkTheme")

-- تعريف الخدمات
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- متغيرات التحكم
local AutoFarmEnabled = false
local SpeedEnabled = false
local FlyEnabled = false
local InfiniteJumpEnabled = false
local CustomSpeed = 16 -- القيمة الافتراضية للسرعة

-- قسم الأوامر في القائمة
local Tab = Window:NewTab("Main Features")
local Section = Tab:NewSection("Auto Farm & Abilities")

-- زر تفعيل/تعطيل Auto Farm
Section:NewToggle("Auto Farm Monkey Quest", "Toggle Auto Farm", function(state)
    AutoFarmEnabled = state
    if AutoFarmEnabled then
        while AutoFarmEnabled and wait(0.1) do
            -- التقاط Monkey Pet
            local MonkeyPet = ReplicatedStorage.Assets.Models.Pets["Monkey Pet"]
            if MonkeyPet then
                HumanoidRootPart.CFrame = MonkeyPet.CFrame
                wait(0.5)
            end

            -- الانتقال إلى Monke Child والتفاعل
            local MonkeChild = Workspace.QuestStuff.CollectQuests["Monke Child"]:GetChildren()[7]
            if MonkeChild then
                HumanoidRootPart.CFrame = MonkeChild.CFrame
                wait(0.3)
                -- محاكاة الضغط على E
                keypress(0x45) -- رمز مفتاح E
                wait(0.1)
                keyrelease(0x45)
                wait(0.5)
            end
        end
    end
end)

-- شريط تمرير لتعديل السرعة
Section:NewSlider("Walk Speed", "Adjust your speed", 500, 16, function(value)
    CustomSpeed = value -- تحديث القيمة بناءً على اختيارك
    if SpeedEnabled then
        Humanoid.WalkSpeed = CustomSpeed -- تطبيق السرعة المخصصة إذا كانت مفعلة
    end
end)

-- زر تفعيل/تعطيل السرعة المخصصة
Section:NewToggle("Custom Speed", "Toggle Custom Speed", function(state)
    SpeedEnabled = state
    if SpeedEnabled then
        Humanoid.WalkSpeed = CustomSpeed -- تطبيق السرعة المختارة
    else
        Humanoid.WalkSpeed = 16 -- العودة إلى السرعة الافتراضية
    end
end)

-- زر تفعيل/تعطيل الطيران
Section:NewToggle("Fly", "Toggle Flying", function(state)
    FlyEnabled = state
    if FlyEnabled then
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BodyVelocity.Parent = HumanoidRootPart
        
        local BodyGyro = Instance.new("BodyGyro")
        BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        BodyGyro.P = 10000
        BodyGyro.Parent = HumanoidRootPart
        
        while FlyEnabled and wait() do
            local Direction = Vector3.new()
            if LocalPlayer:GetMouse().KeyDown:lower() == "w" then
                Direction = Direction + (HumanoidRootPart.CFrame.LookVector * 50)
            end
            if LocalPlayer:GetMouse().KeyDown:lower() == "s" then
                Direction = Direction - (HumanoidRootPart.CFrame.LookVector * 50)
            end
            BodyVelocity.Velocity = Direction
            BodyGyro.CFrame = game.Workspace.CurrentCamera.CFrame
        end
        BodyVelocity:Destroy()
        BodyGyro:Destroy()
    end
end)

-- زر تفعيل/تعطيل القفز اللانهائي
Section:NewToggle("Infinite Jump", "Toggle Infinite Jump", function(state)
    InfiniteJumpEnabled = state
    if InfiniteJumpEnabled then
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if InfiniteJumpEnabled then
                Humanoid:ChangeState("Jumping")
            end
        end)
    end
end)

-- تحديث الموقع عند تغيير الشخصية
LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    Humanoid = Character:WaitForChild("Humanoid")
end)
