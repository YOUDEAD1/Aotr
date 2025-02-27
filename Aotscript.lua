-- تحميل Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AOTR Xeno Executor", "DarkTheme")

-- الصفحة الرئيسية
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Auto Farm & Combat")

-- الوظائف العامة
getgenv().AutoKill = false
getgenv().AutoEscape = false
getgenv().AutoReplaceBlade = false
getgenv().AutoGas = false
getgenv().SpeedBoost = false
getgenv().FOVChanger = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- توسيع هيت بوكس نقطة النحر
local function expandNapeHitbox(hitFolder)
    local napeObject = hitFolder:FindFirstChild("Nape")
    if napeObject then
        napeObject.Size = Vector3.new(105, 120, 100)
        napeObject.Transparency = 0.96
        napeObject.Color = Color3.new(1, 1, 1)
        napeObject.Material = Enum.Material.Neon
        napeObject.CanCollide = false
        napeObject.Anchored = false
    end
end

local function processTitans()
    local titansBasePart = Workspace:FindFirstChild("Titans")
    if titansBasePart then
        for _, titan in ipairs(titansBasePart:GetChildren()) do
            local hitboxesFolder = titan:FindFirstChild("Hitboxes")
            if hitboxesFolder then
                local hitFolder = hitboxesFolder:FindFirstChild("Hit")
                if hitFolder then
                    expandNapeHitbox(hitFolder)
                end
            end
        end
    end
end

-- إضافة زر Auto Kill في GUI
MainSection:NewToggle("Auto Kill", "Kills titans automatically", function(state)
    getgenv().AutoKill = state
    while getgenv().AutoKill do
        processTitans()
        wait(1)
    end
end)

-- أوتو إسكايب
MainSection:NewToggle("Auto Escape", "Auto presses QTE buttons", function(state)
    getgenv().AutoEscape = state
    spawn(function()
        while getgenv().AutoEscape do
            for _, button in pairs(LocalPlayer.PlayerGui.Interface.Buttons:GetChildren()) do
                if button then
                    button:Click() -- افترض أن الزر يمكن النقر عليه
                end
            end
            wait(0.3)
        end
    end)
end)

-- أوتو استبدال السيف
MainSection:NewToggle("Auto Replace Blade", "Replaces broken blade automatically", function(state)
    getgenv().AutoReplaceBlade = state
    spawn(function()
        while getgenv().AutoReplaceBlade do
            for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") and tool:GetAttribute("Broken") then
                    keypress(0x52) -- مفتاح R
                end
            end
            wait(1)
        end
    end)
end)

-- أوتو تعبئة الغاز
MainSection:NewToggle("Auto Gas Refill", "Refills gas automatically", function(state)
    getgenv().AutoGas = state
    spawn(function()
        while getgenv().AutoGas do
            local gasMeter = LocalPlayer.PlayerGui:FindFirstChild("GasMeter")
            if gasMeter and gasMeter.Value <= 10 then
                keypress(0x47) -- مفتاح G
            end
            wait(1)
        end
    end)
end)

-- سبيد بوست
MainSection:NewToggle("Speed Boost", "Increases movement speed", function(state)
    getgenv().SpeedBoost = state
    spawn(function()
        while getgenv().SpeedBoost do
            LocalPlayer.Character.Humanoid.WalkSpeed = 50
            wait(1)
        end
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end)
end)

-- FOV Changer
MainSection:NewToggle("FOV Changer", "Expands camera field of view", function(state)
    getgenv().FOVChanger = state
    spawn(function()
        while getgenv().FOVChanger do
            Workspace.CurrentCamera.FieldOfView = 120
            wait(1)
        end
        Workspace.CurrentCamera.FieldOfView = 70
    end)
end)

print("✅ AOTR Xeno GUI Loaded!")
