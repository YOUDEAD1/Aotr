-- ⚔️ إعداد القائمة الرئيسية
local VIM = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

getgenv().AutoKill = true
getgenv().AutoEscape = true
getgenv().AutoReplaceBlade = true
getgenv().AutoGas = true
getgenv().SpeedBoost = false
getgenv().FOVChanger = true

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

-- ⚙️ تنفيذ توسيع الهت بوكس عند بدء التشغيل
local titansBasePart = Workspace:FindFirstChild("Titans")
if titansBasePart then
    processTitans(titansBasePart)
end

-- 🏃‍♂️ أوتو إسكايب (ضغط أزرار الهروب تلقائياً)
spawn(function()
    while task.wait(0.3) do
        if not getgenv().AutoEscape then return end
        for i, v in pairs(LocalPlayer.PlayerGui.Interface.Buttons:GetChildren()) do
            if v then
                VIM:SendKeyEvent(true, string.sub(tostring(v), 1, 1), false, game)
            end
        end
    end
end)

-- 🔪 أوتو استبدال السيف عند انكساره
spawn(function()
    while task.wait() do
        if not getgenv().AutoReplaceBlade then return end
        for _, v in pairs(LocalPlayer.Character["Rig_"..LocalPlayer.Name]:GetChildren()) do
            if v.Name == "RightHand" or v.Name == "LeftHand" then
                for _, v2 in pairs(v:GetChildren()) do
                    if v2.Name == "Blade_1" and v2:GetAttribute("Broken") == true then
                        keypress(0x52) -- زر R لاستبدال السيف
                    end
                end
            end
        end
    end
end)

-- ⛽ أوتو تعبئة الغاز
spawn(function()
    while task.wait(1) do
        if not getgenv().AutoGas then return end
        local gasMeter = LocalPlayer.PlayerGui:FindFirstChild("GasMeter")
        if gasMeter and gasMeter.Value <= 10 then
            keypress(0x47) -- زر G لتعبئة الغاز
        end
    end
end)

-- ⚡ سبيد بوست
spawn(function()
    while task.wait() do
        if getgenv().SpeedBoost then
            LocalPlayer.Character.Humanoid.WalkSpeed = 50
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- 🔭 أوتو تغيير FOV
spawn(function()
    while task.wait() do
        if getgenv().FOVChanger then
            Workspace.Camera.FieldOfView = 120
        else
            Workspace.Camera.FieldOfView = 70
        end
    end
end)

print("✅ AOTR Xeno Script Loaded!")
