-- تحميل مكتبة Kavo UI
loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- إنشاء نافذة جديدة
local Window = KavoUI.CreateLib("Game Script", "Grape")

-- تبويب Expand Nape
local ExpandNapeTab = Window:NewTab("Expand Nape")

-- سكربت توسيع ناب
ExpandNapeTab:NewButton("Expand Nape", "Expand the Nape hitbox of Titans", function()
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

    local titansBasePart = workspace:FindFirstChild("Titans")
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
end)

-- تبويب Auto Escape
local AutoEscapeTab = Window:NewTab("Auto Escape")

-- سكربت أوتو إيسكايب
AutoEscapeTab:NewToggle("Auto Escape", "Automatically escape", function(state)
    getgenv().autoescape = state
    while task.wait(0.3) do
        if not getgenv().autoescape then return end
        for _, v in pairs(Player.PlayerGui.Interface.Buttons:GetChildren()) do
            if v and v:IsA("GuiButton") then
                v:Click() -- محاكاة النقر على الزر
            end
        end
    end
end)

-- تبويب Auto Repair
local AutoRepairTab = Window:NewTab("Auto Repair")

-- سكريبت أوتو إصلاح الأسلحة
AutoRepairTab:NewToggle("Auto Repair", "Automatically repair weapons", function(state)
    getgenv().autor = state
    while task.wait(0.1) do
        if not getgenv().autor then return end
        for _, v in pairs(Player.Character:GetChildren()) do
            if v.Name == "RightHand" or v.Name == "LeftHand" then
                for _, v2 in pairs(v:GetChildren()) do
                    if v2.Name == "Blade_1" and v2:GetAttribute("Broken") == true then
                        v2:Repair() -- تأكد من وجود دالة الإصلاح المناسبة
                    end
                end
            end
        end
    end
end)

print("Script Loaded Successfully")
