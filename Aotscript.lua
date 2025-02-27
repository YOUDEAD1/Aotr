local VIM = game:GetService("VirtualInputManager")
local workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Auto Escape (مُحسَّن)
getgenv().autoescape = true
task.spawn(function()
    while getgenv().autoescape do
        local buttons = LocalPlayer.PlayerGui:FindFirstChild("Interface") and LocalPlayer.PlayerGui.Interface:FindFirstChild("Buttons")
        if buttons then
            for _, v in pairs(buttons:GetChildren()) do
                if v and v:IsA("TextButton") then
                    VIM:SendKeyEvent(true, string.lower(v.Text), false, game)
                end
            end
        end
        task.wait(0.3)
    end
end)

-- Auto Replace Blade (مُحسَّن)
getgenv().autoreplaceblade = true
task.spawn(function()
    while getgenv().autoreplaceblade do
        local character = LocalPlayer.Character
        if character then
            for _, v in pairs(character:GetChildren()) do
                if v:IsA("Tool") then
                    for _, v2 in pairs(v:GetChildren()) do
                        if v2.Name == "Blade_1" and v2:GetAttribute("Broken") == true then
                            VIM:SendKeyEvent(true, "r", false, game)
                        end
                    end
                end
            end
        end
        task.wait(1)
    end
end)

-- Nape Attacker (مُحسَّن)
local function findNape(titan)
    local hitboxesFolder = titan:FindFirstChild("Hitboxes")
    if hitboxesFolder then
        local hitFolder = hitboxesFolder:FindFirstChild("Hit")
        if hitFolder then
            return hitFolder:FindFirstChild("Nape")
        end
    end
    return nil
end

local function attackNape(titan)
    local napeObject = findNape(titan)
    if napeObject then
        print("Attacking Nape of:", titan.Name)
        -- مثال بسيط: تغيير لون نقطة النحر (يمكن استبداله بهجوم فعلي)
        napeObject.Color = Color3.new(1, 0, 0)
        task.wait(1)
        napeObject.Color = Color3.new(1, 1, 1)
    else
        print("Nape not found for:", titan.Name)
    end
end

local function processTitans(titansBasePart)
    if titansBasePart then
        for _, titan in ipairs(titansBasePart:GetChildren()) do
            if titan:IsA("Model") then
                attackNape(titan)
            end
        end
    end
end

print("Combined Script Loaded")

task.spawn(function()
    while true do
        local titansBasePart = workspace:FindFirstChild("Titans")
        if titansBasePart then
            processTitans(titansBasePart)
        else
            print("Titans folder not found!")
        end
        task.wait(5)
    end
end)
