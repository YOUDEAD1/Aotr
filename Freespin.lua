local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- التحقق من اللعبة
local NINJA_TIME_PLACE_ID = 8075399143 -- Place ID لـ Ninja Time الفعلية (يمكن تعديله إذا كنت في Lobby)
if game.PlaceId ~= NINJA_TIME_PLACE_ID then
    warn("This script is only for Ninja Time! Current PlaceId: " .. game.PlaceId)
    return
end

-- متغيرات التحكم
local isRunning = false
local spinTask = nil

-- دوال السبينات
local function addSpins(spinType, amount)
    local playerName = LocalPlayer.Name
    local playerData = Workspace:WaitForChild("PlayerData", 5)
    if not playerData then
        warn("Failed to find PlayerData in Workspace. Check game structure.")
        return
    end

    local playerSpins = playerData:WaitForChild("PlayerSpins", 5)
    if not playerSpins then
        warn("Failed to find PlayerSpins in PlayerData. Check game structure.")
        return
    end

    local spinValue = nil
    if spinType == "ClanTokens" then
        spinValue = playerSpins:WaitForChild("ClanSpins", 5)
    elseif spinType == "ElementTokens" then
        spinValue = playerSpins:WaitForChild("ElementSpins", 5)
    elseif spinType == "FamilyTokens" then
        spinValue = playerSpins:WaitForChild("FamilySpins", 5)
    end

    if spinValue and spinValue:IsA("IntValue") then
        pcall(function()
            spinValue.Value = spinValue.Value + amount
        end)
        print("Added " .. amount .. " " .. spinType .. " to " .. playerName .. "'s account!")
    else
        warn("Could not find or modify " .. spinType .. " (ClanSpins/ElementSpins/FamilySpins). Check game structure.")
    end
end

-- وظيفة إضافة السبينات تلقائيًا
local function autoAddSpins()
    while isRunning do
        addSpins("ClanTokens", 10) -- إضافة 10 سبينات للكلان
        addSpins("ElementTokens", 10) -- إضافة 10 سبينات للعنصر
        addSpins("FamilyTokens", 10) -- إضافة 10 سبينات للعائلة
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
