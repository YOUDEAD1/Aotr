-- تحميل مكتبة Solara UI (يجب أن تكون موجودة في اللعبة أو محمّلة مسبقًا)
local Solara = loadstring(game:HttpGet("https://raw.githubusercontent.com/3xternal/Solara/main/source.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- التحقق من اللعبة
if game.PlaceId ~= 15503329556 then -- تأكد من أنك في Ninja Time
    warn("This script is only for Ninja Time!")
    return
end

-- متغيرات التحكم
local isRunning = false
local spinTask = nil

-- دوال السبينات
local function addSpins(spinType, amount)
    local playerData = LocalPlayer:FindFirstChild("PlayerData") or LocalPlayer:WaitForChild("PlayerData")
    if playerData then
        local spins = playerData:FindFirstChild(spinType) -- ClanTokens, FamilyTokens, ElementTokens
        if spins and spins:IsA("IntValue") then
            spins.Value = spins.Value + amount
            print("Added " .. amount .. " " .. spinType .. " to your account!")
        else
            local remote = ReplicatedStorage:WaitForChild("SpinSystem"):WaitForChild("AddSpins")
            if remote then
                remote:FireServer(spinType, amount)
                print("Requested " .. amount .. " " .. spinType .. " via RemoteEvent!")
            end
        end
    end
end

-- وظيفة إضافة السبينات تلقائيًا
local function autoAddSpins()
    while isRunning do
        addSpins("ClanTokens", 10) -- إضافة 10 سبينات للكلان
        addSpins("FamilyTokens", 10) -- إضافة 10 سبينات للعائلة
        addSpins("ElementTokens", 10) -- إضافة 10 سبينات للعنصر
        task.wait(5) -- انتظار 5 ثواني بين كل عملية لتجنب الكشف
    end
end

-- إنشاء الواجهة باستخدام Solara
local Window = Solara:CreateWindow({
    Name = "Ninja Time Auto Spins",
    Theme = "Dark",
    Size = UDim2.new(0, 300, 0, 200),
    Position = UDim2.new(0.5, -150, 0.5, -100)
})

local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Auto Spins")

MainSection:NewButton("Toggle Auto Spins", "Start/Stop adding spins automatically", function()
    isRunning = not isRunning
    if isRunning then
        if not spinTask then
            spinTask = task.spawn(autoAddSpins) -- تشغيل المهمة في خلفية منفصلة
        end
        print("Auto Spins Started!")
    else
        if spinTask then
            task.cancel(spinTask)
            spinTask = nil
        end
        print("Auto Spins Stopped!")
    end
end)

MainSection:NewLabel("Status: " .. (isRunning and "Running" or "Stopped"))

-- إيقاف السكربت إذا خرج اللاعب
LocalPlayer.CharacterRemoving:Connect(function()
    if isRunning and spinTask then
        task.cancel(spinTask)
        isRunning = false
        print("Script stopped due to character removal.")
    end
end)

-- إغلاق الواجهة عند الخروج
Window:OnClose(function()
    if isRunning and spinTask then
        task.cancel(spinTask)
        isRunning = false
        print("Script stopped due to window close.")
    end
end)

print("Ninja Time Auto Spins Script Loaded with Solara UI!")
