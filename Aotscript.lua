-- سكريبت متكامل لـ AOTR (مع نصوص عشوائية مشابهة لما وجدته)
-- التاريخ: 27 فبراير 2025

-- إعداد مكتبة واجهة المستخدم (UI Library)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AOTR Script - Powered by xAI", "Ocean")

-- القسم الأول: Auto-Farm
local AutoFarmTab = Window:NewTab("Auto Farm")
local AutoFarmSection = AutoFarmTab:NewSection("Auto Farm Controls")
local AutoFarmEnabled = false

AutoFarmSection:NewToggle("Enable Auto Farm", "Automatically farms resources or kills Titans", function(state)
    AutoFarmEnabled = state
    if AutoFarmEnabled then
        print("Auto Farm Enabled!")
        while AutoFarmEnabled and wait(0.1) do
            for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                    game:GetService("ReplicatedStorage").Events.Attack:FireServer(enemy)
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
local DefaultSpeed = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed or 16

MovementSection:NewToggle("Super Speed", "Increases your movement speed", function(state)
    SpeedEnabled = state
    if SpeedEnabled then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = DefaultSpeed
    end
end)

MovementSection:NewToggle("Fly", "Enables flying", function(state)
    FlyEnabled = state
    if FlyEnabled then
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Velocity = Vector3.new(0, 50, 0)
        BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BodyVelocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

        local BodyGyro = Instance.new("BodyGyro")
        BodyGyro.D = 100
        BodyGyro.P = 3000
        BodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        BodyGyro.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

        while FlyEnabled and wait() do
            local direction = game.Players.LocalPlayer.Character.Humanoid.MoveDirection * 50
            BodyVelocity.Velocity = Vector3.new(direction.X, BodyVelocity.Velocity.Y, direction.Z)
        end
        BodyVelocity:Destroy()
        BodyGyro:Destroy()
    end
end)

-- القسم الثالث: العناصر البصرية (مع نصوص عشوائية)
local VisualsTab = Window:NewTab("Visuals")
local VisualsSection = VisualsTab:NewSection("Visual ESP")
local VisualsEnabled = false

-- جدول يحتوي على نصوص مشفرة مشابهة لما وجدته
local encodedTable = {
    "sb94mq1=", "AJ54l+t=", "lw0MO3v=", "Wd0aXmykzv==", "4uPmxi==", "U9p3hYh=",
    "d07D97H=", "9/AJXd1=", "xrBbpqm=", "U+fNWRo=", "z2o=", "PSvu/v==", "qJMWUXh=",
    "9gXs3CM=", "GVx4Ii3="
}

local function decodeValue(value)
    -- دالة فك تشفير مبسطة للحفاظ على النصوص العشوائية كما هي إذا لم تفك بنجاح
    if type(value) == "string" and value:find("=") then
        local success, decoded = pcall(function()
            local base64Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
            local data = value:gsub("[^" .. base64Alphabet .. "=]", "")
            local binaryString = data:gsub(".", function(char)
                if char == "=" then return "" end
                local charValue = base64Alphabet:find(char, 1, true) - 1
                local bits = ""
                for i = 6, 1, -1 do
                    bits = bits .. ((charValue % 2^i - charValue % 2^(i-1) > 0) and "1" or "0")
                end
                return bits
            end)
            local decoded = binaryString:gsub("%d%d%d?%d?%d?%d?%d?%d?", function(byteString)
                if #byteString ~= 8 then return "" end
                local byteValue = 0
                for i = 1, 8 do
                    byteValue = byteValue + ((byteString:sub(i, i) == "1") and 2^(8 - i) or 0)
                end
                return string.char(byteValue)
            end)
            return decoded ~= "" and decoded or value
        end)
        return success and decoded or value
    end
    return value
end

VisualsSection:NewToggle("Enable Visuals", "Shows ESP circle and random encoded text", function(state)
    VisualsEnabled = state
    if VisualsEnabled then
        spawn(function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = character:WaitForChild("HumanoidRootPart")

            local circle = Drawing.new("Circle")
            circle.Position = Vector2.new(rootPart.Position.X * 2, rootPart.Position.Z * 2)
            circle.Radius = 465
            circle.Color = Color3.new(1, 1, 1)
            circle.Thickness = 1
            circle.Transparency = 0.7
            circle.Visible = true

            local randomTexts = {}
            for i, value in ipairs(encodedTable) do
                randomTexts[i] = Drawing.new("Text")
                randomTexts[i].Size = 20
                randomTexts[i].Font = Drawing.Fonts.UI
                randomTexts[i].Position = Vector2.new(rootPart.Position.X + (i * 30), rootPart.Position.Z + 50)
                randomTexts[i].Text = decodeValue(value) -- عرض النصوص العشوائية
                randomTexts[i].Color = Color3.new(1, 0, 0)
                randomTexts[i].Visible = true
            end

            while VisualsEnabled and task.wait(0.1) do
                circle.Position = Vector2.new(rootPart.Position.X * 2, rootPart.Position.Z * 2)
                for i, text in pairs(randomTexts) do
                    text.Position = Vector2.new(rootPart.Position.X + (i * 30), rootPart.Position.Z + 50)
                end
            end

            circle:Destroy()
            for _, text in pairs(randomTexts) do
                text:Destroy()
            end
        end)
    end
end)

-- رسالة ترحيب
print("AOTR Script Loaded Successfully - Enhanced with Random Text by Grok @ xAI")
