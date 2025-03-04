
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- التحقق من اللعبة
local NINJA_TIME_PLACE_ID = 8075399143 -- Place ID لـ Ninja Time الفعلية
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

    -- محاولة 1: استخدام Workspace.PlayerData_.Spins كمصدر رئيسي
    local playerData = Workspace:WaitForChild("PlayerData_", 10)
    if playerData then
        local spinsFolder = playerData:WaitForChild("Spins", 10)
        if spinsFolder then
            local spinValue = nil
            if spinType == "ClanTokens" then
                spinValue = spinsFolder:WaitForChild("ClanSpins", 10)
            elseif spinType == "ElementTokens" then
                spinValue = spinsFolder:WaitForChild("ElementSpins", 10)
            elseif spinType == "FamilyTokens" then
                spinValue = spinsFolder:WaitForChild("FamilySpins", 10)
            end

            if spinValue and spinValue:IsA("IntValue") then
                pcall(function()
                    spinValue.Value = spinValue.Value + amount
                end)
                print("Added " .. amount .. " " .. spinType .. " to " .. playerName .. "'s account via Workspace!")
                return -- نجحنا، لذا خرجنا
            end
        end
    end

    warn("Failed to find " .. spinType .. " in Workspace.PlayerData_.Spins. Trying GUI or ReplicatedStorage...")

    -- محاولة 2: استخدام PlayerGui.Interface.GachaSelectedFrame لـ ClanSpins وElementSpins
    if spinType == "ClanTokens" then
        local clanSpins = LocalPlayer.PlayerGui:WaitForChild("Interface", 10)
            :WaitForChild("GachaSelectedFrame", 10)
            :WaitForChild("ClanSpins", 10)
        if clanSpins and clanSpins:IsA("IntValue") then
            pcall(function()
                clanSpins.Value = clanSpins.Value + amount
            end)
            print("Added " .. amount .. " " .. spinType .. " to " .. playerName .. "'s account via PlayerGui!")
            return
        end
    elseif spinType == "ElementTokens" then
        local elementSpins = LocalPlayer.PlayerGui:WaitForChild("Interface", 10)
            :WaitForChild("GachaSelectedFrame", 10)
            :WaitForChild("ElementSpins", 10)
        if elementSpins and elementSpins:IsA("IntValue") then
            pcall(function()
                elementSpins.Value = elementSpins.Value + amount
            end)
            print("Added " .. amount .. " " .. spinType .. " to " .. playerName .. "'s account via PlayerGui!")
            return
        end
    end

    -- محاولة 3: استخدام ReplicatedStorage.Assets.Interface2.GachaSelectedFrame لـ FamilySpins
    if spinType == "FamilyTokens" then
        local familySpins = ReplicatedStorage:WaitForChild("Assets", 10)
            :WaitForChild("Interface2", 10)
            :WaitForChild("GachaSelectedFrame", 10)
            :WaitForChild("FamilySpins", 10)
        if familySpins and familySpins:IsA("IntValue") then
            pcall(function()
                familySpins.Value = familySpins.Value + amount
            end)
            print("Added " .. amount .. " " .. spinType .. " to " .. playerName .. "'s account via ReplicatedStorage!")
            return
        end
    end

    warn("Could not find or modify " .. spinType .. " (ClanSpins/ElementSpins/FamilySpins). Check game structure. Current names under Spins: ")
    if spinsFolder then
        for _, child in pairs(spinsFolder:GetChildren()) do
            warn("Found in Spins: " .. child.Name .. " (" .. child.ClassName .. ")")
        end
    end
    if LocalPlayer.PlayerGui:FindFirstChild("Interface") and LocalPlayer.PlayerGui.Interface:FindFirstChild("GachaSelectedFrame") then
        for _, child in pairs(LocalPlayer.PlayerGui.Interface.GachaSelectedFrame:GetChildren()) do
            warn("Found in PlayerGui.Interface.GachaSelectedFrame: " .. child.Name .. " (" .. child.ClassName .. ")")
        end
    end
    if ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Interface2") and ReplicatedStorage.Assets.Interface2:FindFirstChild("GachaSelectedFrame") then
        for _, child in pairs(ReplicatedStorage.Assets.Interface2.GachaSelectedFrame:GetChildren()) do
            warn("Found in ReplicatedStorage.Assets.Interface2.GachaSelectedFrame: " .. child.Name .. " (" .. child.ClassName .. ")")
        end
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
