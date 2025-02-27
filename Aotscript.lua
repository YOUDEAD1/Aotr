-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AOTR Xeno Executor", "DarkTheme")

-- إعداد المتغيرات
getgenv().AutoKill = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local VIM = game:GetService("VirtualInputManager")

-- توسيع hitbox النحر
local function expandNape(hitbox)
    local nape = hitbox:FindFirstChild("Nape")
    if nape then
        nape.Size = Vector3.new(105, 120, 100)
        nape.Transparency = 0.96
        nape.Color = Color3.new(1, 1, 1)
        nape.Material = Enum.Material.Neon
        nape.CanCollide = false
        nape.Anchored = false
    end
end

-- معالجة Titans
local function processTitans()
    for _, titan in ipairs(Workspace.Titans:GetChildren()) do
        local hitboxes = titan:FindFirstChild("Hitboxes")
        if hitboxes then
            local hitFolder = hitboxes:FindFirstChild("Hit")
            if hitFolder then
                expandNape(hitFolder)
                -- هنا يمكن إضافة الكود للهجوم على العملاق
            end
        end
    end
end

-- زر Auto Kill
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Auto Farm & Combat")
MainSection:NewToggle("Auto Kill", "توسيع hitboxes لعملاق", function(state)
    getgenv().AutoKill = state
    while getgenv().AutoKill do
        processTitans()
        wait(1) -- فترة الانتظار لتقليل التحميل
    end
end)

print("تم تحميل السكربت بنجاح")
