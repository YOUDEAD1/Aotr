local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- التحقق من اللعبة
local NINJA_TIME_PLACE_ID = 8075399143 -- الـ Place ID الجديد لـ Ninja Time
if game.PlaceId ~= NINJA_TIME_PLACE_ID then
    warn("This script is only for Ninja Time! Current PlaceId: " .. game.PlaceId)
    return
end

-- متغيرات التحكم
local isRunning = false
local spinTask = nil

-- دوال السبينات
local function addSpins(spinType, amount)
    local success, playerData = pcall(function()
        return LocalPlayer:FindFirstChild("PlayerData") or LocalPlayer:WaitForChild("PlayerData", 5)
    end)
    if not success or not playerData then
        warn("Failed to find PlayerData. Trying RemoteEvent...")
        local success, remote = pcall(function()
            return ReplicatedStorage:WaitForChild("SpinSystem", 5) -- انتظار 5 ثوانٍ فقط
        end)
        if success and remote then
            local success, addSpinsRemote = pcall(function()
                return remote:WaitForChild("AddSpins", 5)
            end)
            if success and addSpinsRemote then
                pcall(function() addSpinsRemote:FireServer(spinType, amount) end)
                print("Requested " .. amount .. " " .. spinType .. " via RemoteEvent!")
            else
                warn("Could not find AddSpins in SpinSystem. Check game structure.")
            end
        else
            warn("Could not find SpinSystem. Check game structure.")
        end
        return
    end

    local success, spins = pcall(function()
        return playerData:FindFirstChild(spinType) -- ClanTokens, FamilyTokens, ElementTokens
    end)
    if success and spins and spins:IsA("IntValue") then
        pcall(function() spins.Value = spins.Value + amount end)
        print("Added " .. amount .. " " .. spinType .. " to your account!")
    else
        warn("Could not find or modify " .. spinType .. ". Check game structure.")
    end
end

-- وظيفة إضافة السبينات تلقائيًا
local function autoAddSpins()
    while isRunning do
        addSpins("ClanTokens", 10) -- إضافة 10 سبينات للكلان
        addSpins("FamilyTokens", 10) -- إضافة 10 سبينات للعائلة
        addSpins("ElementTokens", 10) -- إضافة 10 سبينات للعنصر
        task.wait(5) -- انتظار 5 ثواني بين كل عملية
    end
end

-- إنشاء واجهة بسيطة
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.5
MainFrame.ZIndex = 2

local ToggleButton = Instance.new("TextButton", MainFrame)
ToggleButton.Size = UDim2.new(1, 0, 1, 0)
ToggleButton.BackgroundColor3 = Color3.new(0, 1, 0)
ToggleButton.Text = "Toggle Auto Spins (Off)"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextScaled = true
ToggleButton.ZIndex = 3

ToggleButton.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        if not spinTask then
            spinTask = task.spawn(autoAddSpins)
        end
        ToggleButton.Text = "Toggle Auto Spins (On)"
        ToggleButton.BackgroundColor3 = Color3.new(1, 0, 0)
        print("Auto Spins Started!")
    else
        if spinTask then
            task.cancel(spinTask)
            spinTask = nil
        end
        ToggleButton.Text = "Toggle Auto Spins (Off)"
        ToggleButton.BackgroundColor3 = Color3.new(0, 1, 0)
        print("Auto Spins Stopped!")
    end
end)

-- إيقاف السكربت إذا خرج اللاعب
LocalPlayer.CharacterRemoving:Connect(function()
    if isRunning and spinTask then
        task.cancel(spinTask)
        isRunning = false
        print("Script stopped due to character removal.")
    end
end)

print("Ninja Time Auto Spins Script Loaded with Simple UI!")
