-- تحميل مكتبة Kavo UI
loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local VIM = game:GetService("VirtualInputManager")

-- إنشاء نافذة جديدة
local Window = KavoUI.CreateLib("Game Script", "Grape")

-- تبويب Auto Farm
local AutoFarmTab = Window:NewTab("Auto Farm")
local ExpandNapeTab = Window:NewTab("Expand Nape")
local AutoEscapeTab = Window:NewTab("Auto Escape")
local AutoRepairTab = Window:NewTab("Auto Repair")
local CombatTab = Window:NewTab("Combat")

-- سكربت توسيع ناب
ExpandNapeTab:NewButton("Expand Nape", "Expand the Nape hitbox of Titans", function()
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

    local titansBasePart = workspace:FindFirstChild("Titans")
    if titansBasePart then
        processTitans(titansBasePart)
    end
end)

-- سكربت أوتو إيسكايب
AutoEscapeTab:NewToggle("Auto Escape", "Automatically escape", function(state)
    getgenv().autoescape = state
    while task.wait(0.3) do
        if not getgenv().autoescape then return end
        for _, v in pairs(Player.PlayerGui.Interface.Buttons:GetChildren()) do
            if v then
                VIM:SendKeyEvent(true, string.sub(tostring(v), 1, 1), false, game)
            end
        end
    end
end)

-- سكريبت أوتو إصلاح الأسلحة
AutoRepairTab:NewToggle("Auto Repair", "Automatically repair weapons", function(state)
    getgenv().autor = state
    while task.wait() do
        if not getgenv().autor then return end
        for _, v in pairs(Player.Character:GetChildren()) do
            if v.Name == "RightHand" or v.Name == "LeftHand" then
                for _, v2 in pairs(v:GetChildren()) do
                    if v2.Name == "Blade_1" then
                        if v2:GetAttribute("Broken") == true then
                            keypress(0x52) -- مفتاح R لإصلاح
                        end
                    end
                end
            end
        end
    end
end)

-- سكريبت القتال
CombatTab:NewToggle("Auto Combat", "Automatically attack Titans", function(state)
    getgenv().autocombat = state
    while task.wait(0.1) do
        if not getgenv().autocombat then return end
        local titan, closestdist = nil, math.huge
        for _, opposition in next, workspace.Titans:GetChildren() do
            if opposition:FindFirstChild("HumanoidRootPart") then
                local calcDist = (opposition.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                if calcDist <= 6000 then -- المسافة المحددة
                    if calcDist < closestdist then
                        titan = opposition
                        closestdist = calcDist
                    end
                end
            end
        end
        if titan then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(titan.HumanoidRootPart.Position) -- التحرك نحو العملاق
            -- إضافة الكود للهجوم على العملاق هنا
        end
    end
end)

print("Script Loaded Successfully")
