-- ️ تحميل Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AOTR Xeno Executor", "DarkTheme")

--  الصفحة الرئيسية
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Auto Farm & Combat")

-- ⚙️ الوظائف العامة
local getgenv = getgenv()
getgenv.AutoKill = false
getgenv.AutoEscape = false
getgenv.AutoReplaceBlade = false
getgenv.AutoGas = false
getgenv.SpeedBoost = false
getgenv.FOVChanger = false

local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

--  توسيع هيت بوكس نقطة النحر
local function findNape(hitFolder)
    return hitFolder:FindFirstChild("Nape")
end

local function expandNapeHitbox(hitFolder)
    local napeObject = findNape(hitFolder)
    if napeObject then
        napeObject.Size = Vector3.new(105, 120, 100)
        napeObject.Transparency = 0.96
        napeObject.Color = Color3.new(1, 1, 1)
        napeObject.Material = Enum.Material.Neon
        napeObject.CanCollide = false
        napeObject.Anchored = false
    end
end

local function processTitans(titansBasePart)
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

--  إضافة زر Auto Kill في GUI
MainSection:NewToggle("Auto Kill", "Kills titans automatically", function(state)
    getgenv.AutoKill = state
    if state then
        local titansBasePart = Workspace:FindFirstChild("Titans")
        task.spawn(function()
            while getgenv.AutoKill do
                processTitans(titansBasePart)
                task.wait(1)
            end
        end)
    end
end)

-- ‍♂️ أوتو إسكايب
MainSection:NewToggle("Auto Escape", "Auto presses QTE buttons", function(state)
    getgenv.AutoEscape = state
    task.spawn(function()
        while getgenv.AutoEscape do
            for _, v in pairs(LocalPlayer.PlayerGui.Interface.Buttons:GetChildren()) do
                if v and v:IsA("TextButton") then -- التحقق من نوع العنصر
                    VIM:SendKeyEvent(true, string.lower(v.Text), false, game) -- استخدام النص كحرف
                end
            end
            task.wait(0.3)
        end
    end)
end)

--  أوتو استبدال السيف
MainSection:NewToggle("Auto Replace Blade", "Replaces broken blade automatically", function(state)
    getgenv.AutoReplaceBlade = state
    task.spawn(function()
        while getgenv.AutoReplaceBlade do
            local character = LocalPlayer.Character
            if character then
                for _, v in pairs(character:GetChildren()) do
                    if v:IsA("Tool") then
                        for _, v2 in pairs(v:GetChildren()) do
                            if v2.Name == "Blade_1" and v2:GetAttribute("Broken") == true then
                                VIM:SendKeyEvent(true, "r", false, game) -- استخدام 'r'
                            end
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

-- ⛽ أوتو تعبئة الغاز
MainSection:NewToggle("Auto Gas Refill", "Refills gas automatically", function(state)
    getgenv.AutoGas = state
    task.spawn(function()
        while getgenv.AutoGas do
            local gasMeter = LocalPlayer.PlayerGui:FindFirstChild("GasMeter")
            if gasMeter and gasMeter.Value <= 20 then -- زيادة قيمة الغاز
                VIM:SendKeyEvent(true, "g", false, game) -- استخدام 'g'
            end
            task.wait(1)
        end
    end)
end)

-- ⚡ سبيد بوست
MainSection:NewToggle("Speed Boost", "Increases movement speed", function(state)
    getgenv.SpeedBoost = state
    task.spawn(function()
        while true do
            if getgenv.SpeedBoost then
                LocalPlayer.Character.Humanoid.WalkSpeed = 50
            else
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
            task.wait()
        end
    end)
end)

--  FOV Changer
MainSection:NewToggle("FOV Changer", "Expands camera field of view", function(state)
    getgenv.FOVChanger = state
    task.spawn(function()
        while true do
            if getgenv.FOVChanger then
                Workspace.CurrentCamera.FieldOfView = 120
            else
                Workspace.CurrentCamera.FieldOfView = 70
            end
            task.wait()
        end
    end)
end)

print("✅ AOTR Xeno GUI Loaded!")
