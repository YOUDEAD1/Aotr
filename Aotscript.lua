-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AOTR Xeno Executor", "DarkTheme")

-- إعداد المتغيرات
getgenv().AutoKill = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- وظيفة لتوسيع hitbox النحر
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

-- وظيفة لمعالجة Titans
local function processTitans()
    for _, titan in ipairs(Workspace.Titans:GetChildren()) do
        local hitboxesFolder = titan:FindFirstChild("Hitboxes")
        if hitboxesFolder then
            local hitFolder = hitboxesFolder:FindFirstChild("Hit")
            if hitFolder then
                expandNapeHitbox(hitFolder)
            end
        end
    end
end

-- زر Auto Kill
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Auto Farm & Combat")
MainSection:NewToggle("Auto Kill", "Automatically expand nape hitboxes", function(state)
    getgenv().AutoKill = state
    while getgenv().AutoKill do
        processTitans()
        wait(1) -- انتظر 1 ثانية بين كل عملية
    end
end)

print("Script Loaded Successfully")
