-- 🛠️ تحميل Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AOTR Xeno Executor", "DarkTheme")

-- 🏹 الصفحة الرئيسية
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Auto Farm & Combat")

-- ⚙️ الوظائف العامة
getgenv().AutoKill = false
getgenv().AutoEscape = false
getgenv().AutoReplaceBlade = false
getgenv().AutoGas = false
getgenv().SpeedBoost = false
getgenv().FOVChanger = false

local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- 🎯 توسيع هيت بوكس نقطة النحر
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

-- 📌 إضافة زر Auto Kill في GUI
MainSection:NewToggle("Auto Kill", "Kills titans automatically", function(state)
    getgenv().AutoKill = state
    spawn(function()
        while getgenv().AutoKill do
            local titansBasePart = Workspace:FindFirstChild("Titans")
            if titansBasePart then
                local closestTitan, closestDistance = nil, math.huge
                for _, titan in ipairs(titansBasePart:GetChildren()) do
                    local hitboxesFolder = titan:FindFirstChild("Hitboxes")
                    if hitboxesFolder then
                        local hitFolder = hitboxesFolder:FindFirstChild("Hit")
                        if hitFolder then
                            local distance = (titan.PrimaryPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if distance < closestDistance then
                                closestTitan = titan
                                closestDistance = distance
                            end
                        end
                    end
                end

                if closestTitan then
                    -- التحرك نحو العملاق
                    LocalPlayer.Character:MoveTo(closestTitan.PrimaryPart.Position)
                    wait(1) -- الانتظار لبضع ثواني قبل محاولة الهجوم

                    -- فحص المسافة للهجوم
                    local attackDistance = 15 -- المسافة التي يجب أن تكون بها لضرب العملاق
                    local currentDistance = (closestTitan.PrimaryPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if currentDistance <= attackDistance then
                        VIM:SendKeyEvent(true, "e", false, game) -- زر الهجوم (استبدل "e" بزر الهجوم الصحيح إذا لزم الأمر)
                    end
                end
            end
            task.wait(0.5) -- الانتظار قبل البحث عن عملاق آخر
        end
    end)
end)

-- 🏃‍♂️ أوتو إسكايب
MainSection:NewToggle("Auto Escape", "Auto presses QTE buttons", function(state)
    getgenv().AutoEscape = state
    spawn(function()
        while task.wait(0.3) do
            if not getgenv().AutoEscape then return end
            for _, v in pairs(LocalPlayer.PlayerGui.Interface.Buttons:GetChildren()) do
                if v then
                    VIM:SendKeyEvent(true, string.sub(tostring(v), 1, 1), false, game)
                end
            end
        end
    end)
end)

-- 🔪 أوتو استبدال السيف
MainSection:NewToggle("Auto Replace Blade", "Replaces broken blade automatically", function(state)
    getgenv().AutoReplaceBlade = state
    spawn(function()
        while task.wait() do
            if not getgenv().AutoReplaceBlade then return end
            for _, v in pairs(LocalPlayer.Character["Rig_"..LocalPlayer.Name]:GetChildren()) do
                if v.Name == "RightHand" or v.Name == "LeftHand" then
                    for _, v2 in pairs(v:GetChildren()) do
                        if v2.Name == "Blade_1" and v2:GetAttribute("Broken") == true then
                            keypress(0x52) -- R Key
                        end
                    end
                end
            end
        end
    end)
end)

-- ⛽ أوتو تعبئة الغاز
MainSection:NewToggle("Auto Gas Refill", "Refills gas automatically", function(state)
    getgenv().AutoGas = state
    spawn(function()
        while task.wait(1) do
            if not getgenv().AutoGas then return end
            local gasMeter = LocalPlayer.PlayerGui:FindFirstChild("GasMeter")
            if gasMeter and gasMeter.Value <= 10 then
                keypress(0x47) -- G Key
            end
        end
    end)
end)

-- ⚡ سبيد بوست
MainSection:NewToggle("Speed Boost", "Increases movement speed", function(state)
    getgenv().SpeedBoost = state
    spawn(function()
        while task.wait() do
            if getgenv().SpeedBoost then
                LocalPlayer.Character.Humanoid.WalkSpeed = 50
            else
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end
    end)
end)

-- 🔭 FOV Changer
MainSection:NewToggle("FOV Changer", "Expands camera field of view", function(state)
    getgenv().FOVChanger = state
    spawn(function()
        while task.wait() do
            if getgenv().FOVChanger then
                Workspace.Camera.FieldOfView = 120
            else
                Workspace.Camera.FieldOfView = 70
            end
        end
    end)
end)

print("✅ AOTR Xeno GUI Loaded!")
