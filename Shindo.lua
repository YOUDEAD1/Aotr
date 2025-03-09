-- Shindo Life XP & Mastery Script by Grok 3 (xAI)
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local statz = ReplicatedStorage.statz

-- GUI Setup (واجهة المستخدم)
local screenGui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local xpButton = Instance.new("TextButton")
local masteryFrame = Instance.new("Frame")
local masteryButtons = {}
local prestigeFrame = Instance.new("Frame")
local prestigeButtons = {}

-- Configuration
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.Name = "ShindoCheatGUI"
mainFrame.Size = UDim2.new(0, 200, 0, 300)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- XP Button
xpButton.Size = UDim2.new(0, 180, 0, 50)
xpButton.Position = UDim2.new(0, 10, 0, 10)
xpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
xpButton.Text = "Add 50M XP"
xpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
xpButton.Parent = mainFrame

-- Mastery Frame
masteryFrame.Size = UDim2.new(0, 180, 0, 150)
masteryFrame.Position = UDim2.new(0, 10, 0, 70)
masteryFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
masteryFrame.BorderSizePixel = 0
masteryFrame.Parent = mainFrame

-- Prestige Frame
prestigeFrame.Size = UDim2.new(0, 180, 0, 70)
prestigeFrame.Position = UDim2.new(0, 10, 0, 230)
prestigeFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
prestigeFrame.BorderSizePixel = 0
prestigeFrame.Parent = mainFrame

-- Mastery Paths
local masteryPaths = {
    {name = "Chakra", path = statz.mastery.chakra},
    {name = "Health", path = statz.mastery.health},
    {name = "Ninjutsu", path = statz.mastery.ninjutsu},
    {name = "Taijutsu", path = statz.mastery.taijutsu},
    {name = "Points", path = statz.mastery.points}
}

-- Prestige Paths
local prestigePaths = {
    {name = "MaxLvlPres", path = statz.prestige.maxlvlpres},
    {name = "Number", path = statz.prestige.number},
    {name = "Rank", path = statz.prestige.rank}
}

-- Level Paths
local levelPaths = {
    {name = "Exp", path = statz.lvl.exp},
    {name = "Lvl", path = statz.lvl.lvl},
    {name = "MaxExp", path = statz.lvl.maxexp}
}

-- Function to Add Values
local function addValue(path, value)
    local success, err = pcall(function()
        path.Value = path.Value + value
    end)
    if not success then
        warn("Error updating " .. path.Name .. ": " .. err)
    end
end

-- XP Button Function
xpButton.MouseButton1Click:Connect(function()
    for _, path in pairs(levelPaths) do
        if path.name == "Exp" then
            addValue(path.path, 50000000) -- 50 million XP
        end
    end
    print("Added 50M XP to " .. player.Name)
end)

-- Mastery Buttons
local yOffset = 5
for i, mastery in pairs(masteryPaths) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 160, 0, 25)
    button.Position = UDim2.new(0, 10, 0, yOffset)
    button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    button.Text = "Add 10k " .. mastery.name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = masteryFrame
    table.insert(masteryButtons, button)

    button.MouseButton1Click:Connect(function()
        addValue(mastery.path, 10000) -- 10,000 points
        print("Added 10k to " .. mastery.name .. " for " .. player.Name)
    end)
    yOffset = yOffset + 30
end

-- Prestige Buttons
yOffset = 5
for i, prestige in pairs(prestigePaths) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 160, 0, 25)
    button.Position = UDim2.new(0, 10, 0, yOffset)
    button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    button.Text = "Add 10k " .. prestige.name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = prestigeFrame
    table.insert(prestigeButtons, button)

    button.MouseButton1Click:Connect(function()
        addValue(prestige.path, 10000) -- 10,000 points
        print("Added 10k to " .. prestige.name .. " for " .. player.Name)
    end)
    yOffset = yOffset + 30
end

-- Error Handling
spawn(function()
    while wait(1) do
        if not player or not statz then
            warn("Player or statz not found, script may fail!")
            break
        end
    end
end)
