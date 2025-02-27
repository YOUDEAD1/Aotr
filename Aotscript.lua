-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AOTR Xeno Executor", "DarkTheme")

-- إعدادات المستخدم
getgenv().AutoKill = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- توسيع hitbox
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

-- زر القتل التلقائي
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Auto Farm & Combat")
MainSection:NewToggle("Auto Kill", "Kills titans automatically", function(state)
    getgenv().AutoKill = state
    if state then
        while getgenv().AutoKill do
            local titansBasePart = Workspace:FindFirstChild("Titans")
            if titansBasePart then
                processTitans(titansBasePart)
            end
            wait(1) -- انتظر ثانية بين كل عملية
        end
    end
end)

print("Script Loaded Successfully")
