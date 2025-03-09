-- Shindo Life Super Hack Script by Grok 3 (xAI)
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local statz = ReplicatedStorage:WaitForChild("statz", 10)

if not statz then
    warn("statz not found, script aborted!")
    return
end

local levelPaths = {
    {name = "Exp", path = statz.lvl.exp},
    {name = "Lvl", path = statz.lvl.lvl},
    {name = "MaxExp", path = statz.lvl.maxexp}
}

local masteryPaths = {
    {name = "Chakra", path = statz:mastery.chakra},
    {name = "Health", path = statz:mastery.health},
    {name = "Ninjutsu", path = statz:mastery.ninjutsu},
    {name = "Taijutsu", path = statz:mastery.taijutsu},
    {name = "Points", path = statz:mastery.points}
}

local prestigePaths = {
    {name = "MaxLvlPres", path = statz.prestige.maxlvlpres},
    {name = "Number", path = statz.prestige.number},
    {name = "Rank", path = statz.prestige.rank}
}

local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldNewIndex = mt.__newindex
mt.__newindex = newcclosure(function(t, k, v)
    if checkcaller() and typeof(v) == "number" then
        return true
    end
    return oldNewIndex(t, k, v)
end)

local function modifyValue(path, value)
    local success, err = pcall(function()
        if path and path.Value ~= nil then
            path.Value = path.Value + value
        end
    end)
    if not success then
        warn("Modify failed: " .. err)
    end
end

local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.Name = "ShindoHackGUI"
mainFrame.Size = UDim2.new(0, 250, 0, 450)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local function createButton(text, yPos, action)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 230, 0, 40)
    button.Position = UDim2.new(0, 10, 0, yPos)
    button.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = mainFrame
    button.MouseButton1Click:Connect(action)
    return button
end

createButton("Add 50M XP", 10, function()
    for _, path in pairs(levelPaths) do
        if path.name == "Exp" then
            modifyValue(path.path, 50000000)
        end
    end
end)

local yOffset = 60
for _, mastery in pairs(masteryPaths) do
    createButton("Add 10k " .. mastery.name, yOffset, function()
        modifyValue(mastery.path, 10000)
    end)
    yOffset = yOffset + 45
end

yOffset = 315
for _, prestige in pairs(prestigePaths) do
    createButton("Add 10k " .. prestige.name, yOffset, function()
        modifyValue(prestige.path, 10000)
    end)
    yOffset = yOffset + 45
end

spawn(function()
    while wait(2.5) do
        pcall(function()
            local antiCheat = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AntiCheatCheck", 1)
            if antiCheat then
                antiCheat:FireServer(true)
            end
        end)
    end
end)

print("Shindo Hack GUI Loaded for " .. player.Name)
