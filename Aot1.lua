
-- سكريبت رقم 1
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local titleLabel = Instance.new("TextLabel")
local scrollingFrame = Instance.new("ScrollingFrame")
local teleportLabel = Instance.new("TextLabel")
local titanFarmerLabel = Instance.new("TextLabel")
local tpButton = Instance.new("TextButton")
local tpButtonF = Instance.new("TextButton")
local refillButton = Instance.new("TextButton")
local espLabel = Instance.new("TextLabel")
local tpButtonE = Instance.new("TextButton")
local enabledValue = Instance.new("BoolValue")

screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

frame.Parent = screenGui
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Position = UDim2.new(0.4164823, 0, 0.0479591824, 0)
frame.Size = UDim2.new(0, 340, 0, 329)
frame.Style = Enum.FrameStyle.RobloxRound

titleLabel.Name = "Title"
titleLabel.Parent = frame
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1.000
titleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.BorderSizePixel = 0
titleLabel.Position = UDim2.new(0.0207602102, 0, -0.00166114408, 0)
titleLabel.Size = UDim2.new(0, 312, 0, 50)
titleLabel.Font = Enum.Font.Unknown
titleLabel.Text = "Tekkit AotR"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.TextSize = 1.000
titleLabel.TextWrapped = true

scrollingFrame.Parent = frame
scrollingFrame.Active = true
scrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scrollingFrame.BackgroundTransparency = 1.000
scrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
scrollingFrame.BorderSizePixel = 0
scrollingFrame.Position = UDim2.new(0.0415333472, 0, 0.162598208, 0)
scrollingFrame.Size = UDim2.new(0, 305, 0, 256)
scrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

teleportLabel.Name = "Teleport"
teleportLabel.Parent = scrollingFrame
teleportLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
teleportLabel.BackgroundTransparency = 1.000
teleportLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
teleportLabel.BorderSizePixel = 0
teleportLabel.Position = UDim2.new(0.0799999982, 0, 0.0299999993, 0)
teleportLabel.Size = UDim2.new(0, 200, 0.0599999987, 0)
teleportLabel.Font = Enum.Font.Fondamento
teleportLabel.Text = "Nape Teleport"
teleportLabel.TextColor3 = Color3.fromRGB(148, 148, 148)
teleportLabel.TextSize = 25.000
teleportLabel.TextWrapped = true

titanFarmerLabel.Name = "Titan Farmer"
titanFarmerLabel.Parent = scrollingFrame
titanFarmerLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titanFarmerLabel.BackgroundTransparency = 1.000
titanFarmerLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
titanFarmerLabel.BorderSizePixel = 0
titanFarmerLabel.Position = UDim2.new(0.0804597735, 0, 0.104999997, 0)
titanFarmerLabel.Size = UDim2.new(0, 200, 0.0599999987, 0)
titanFarmerLabel.Font = Enum.Font.Unknown
titanFarmerLabel.Text = "Titan Farmer"
titanFarmerLabel.TextColor3 = Color3.fromRGB(148, 148, 148)
titanFarmerLabel.TextSize = 20.000
titanFarmerLabel.TextWrapped = true

tpButton.Name = "tpButton"
tpButton.Parent = scrollingFrame
tpButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tpButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
tpButton.BorderSizePixel = 2
tpButton.Position = UDim2.new(0.699999988, 0, 0.0350000001, 0)
tpButton.Size = UDim2.new(0, 30, 0, 30)
tpButton.Font = Enum.Font.SourceSans
tpButton.Text = ""
tpButton.TextColor3 = Color3.fromRGB(0, 0, 0)
tpButton.TextSize = 14.000

tpButtonF.Name = "tpButtonF"
tpButtonF.Parent = scrollingFrame
tpButtonF.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tpButtonF.BorderColor3 = Color3.fromRGB(0, 0, 0)
tpButtonF.BorderSizePixel = 2
tpButtonF.Position = UDim2.new(0.699999928, 0, 0.10900782, 0)
tpButtonF.Size = UDim2.new(0, 30, 0, 30)
tpButtonF.Font = Enum.Font.SourceSans
tpButtonF.Text = ""
tpButtonF.TextColor3 = Color3.fromRGB(0, 0, 0)
tpButtonF.TextSize = 14.000

refillButton.Name = "refill"
refillButton.Parent = scrollingFrame
refillButton.BackgroundColor3 = Color3.fromRGB(94, 94, 94)
refillButton.BackgroundTransparency = 0.800
refillButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
refillButton.BorderSizePixel = 0
refillButton.Position = UDim2.new(0.230000004, 0, 0.264999986, 0)
refillButton.Size = UDim2.new(0, 100, 0, 25)
refillButton.Font = Enum.Font.Unknown
refillButton.Text = "Tp to Refill"
refillButton.TextColor3 = Color3.fromRGB(148, 148, 148)
refillButton.TextScaled = true
refillButton.TextSize = 27.000
refillButton.TextWrapped = true

espLabel.Name = "esp"
espLabel.Parent = scrollingFrame
espLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
espLabel.BackgroundTransparency = 1.000
espLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
espLabel.BorderSizePixel = 0
espLabel.Position = UDim2.new(0.0542302355, 0, 0.181999996, 0)
espLabel.Size = UDim2.new(0, 200, 0.0599999987, 0)
espLabel.Font = Enum.Font.Unknown
espLabel.Text = "Titan ESP"
espLabel.TextColor3 = Color3.fromRGB(148, 148, 148)
espLabel.TextSize = 23.000
espLabel.TextWrapped = true

tpButtonE.Name = "tpButtonE"
tpButtonE.Parent = scrollingFrame
tpButtonE.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tpButtonE.BorderColor3 = Color3.fromRGB(0, 0, 0)
tpButtonE.BorderSizePixel = 2
tpButtonE.Position = UDim2.new(0.699999988, 0, 0.185000002, 0)
tpButtonE.Size = UDim2.new(0, 30, 0, 30)
tpButtonE.Font = Enum.Font.SourceSans
tpButtonE.Text = ""
tpButtonE.TextColor3 = Color3.fromRGB(0, 0, 0)
tpButtonE.TextSize = 14.000

frame.Draggable = true
frame.Selectable = true
frame.Active = true

-- إعدادات اللعبة
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local napeLocation
local teleportEnabled = false
local maxTeleportDistance = 1250
local closestNape
local titanFarmerEnabled = false
local titanEspDistance = math.huge
local espEnabled = false
local highlights = {}

-- دالة للحصول على موقع HumanoidRootPart
local function getPlayerPosition()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("HumanoidRootPart").Position
end

-- دالة لتحديد ناب قريب
local function findClosestNape()
    local closest = nil
    local minDist = maxTeleportDistance
    for _, nape in pairs(Workspace.Nape:GetChildren()) do
        if nape:IsA("Model") and nape:FindFirstChild("HumanoidRootPart") then
            local dist = (getPlayerPosition() - nape.HumanoidRootPart.Position).Magnitude
            if dist < minDist then
                closest = nape
                minDist = dist
            end
        end
    end
    return closest
end

-- تفعيل النقل إلى الناب
tpButton.MouseButton1Click:Connect(function()
    closestNape = findClosestNape()
    if closestNape then
        player.Character:WaitForChild("HumanoidRootPart").CFrame = closestNape.HumanoidRootPart.CFrame
    end
end)

-- تشغيل Titan Farmer
tpButtonF.MouseButton1Click:Connect(function()
    titanFarmerEnabled = not titanFarmerEnabled
    if titanFarmerEnabled then
        tpButtonF.Text = "Stop Titan Farmer"
        while titanFarmerEnabled do
            closestNape = findClosestNape()
            if closestNape then
                player.Character:WaitForChild("HumanoidRootPart").CFrame = closestNape.HumanoidRootPart.CFrame
            end
            wait(1)
        end
    else
        tpButtonF.Text = "Start Titan Farmer"
    end
end)

-- تشغيل Titan ESP
tpButtonE.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        tpButtonE.Text = "Stop Titan ESP"
        while espEnabled do
            for _, nape in pairs(Workspace.Nape:GetChildren()) do
                if nape:IsA("Model") and nape:FindFirstChild("HumanoidRootPart") then
                    local dist = (getPlayerPosition() - nape.HumanoidRootPart.Position).Magnitude
                    if dist < titanEspDistance then
                        titanEspDistance = dist
                        highlights[nape] = true
                    end
                end
            end
            wait(1)
        end
    else
        tpButtonE.Text = "Start Titan ESP"
        highlights = {}
    end
end)

-- حفظ الإعدادات تلقائيًا
local playerData = player:WaitForChild("PlayerData")
local settings = playerData:FindFirstChild("Settings") or Instance.new("Folder")
settings.Name = "Settings"
settings.Parent = playerData

-- حفظ حالة Titan Farmer و Titan ESP
local function saveSettings()
    local titanFarmerValue = Instance.new("BoolValue")
    titanFarmerValue.Name = "TitanFarmerEnabled"
    titanFarmerValue.Value = titanFarmerEnabled
    titanFarmerValue.Parent = settings

    local espValue = Instance.new("BoolValue")
    espValue.Name = "EspEnabled"
    espValue.Value = espEnabled
    espValue.Parent = settings
end

-- الضغط الدائم على زر الماوس
local mouseDown = false

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        mouseDown = true
        -- اضغط على زر الماوس الأيسر بشكل مستمر
        while mouseDown do
            -- إضافة الأكواد المطلوبة عند الضغط المستمر
            wait(0.1)
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        mouseDown = false
    end
end)

-- دمج السكربتين
local workspace = game:GetService("Workspace")

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

print("Nape Expander Loaded")

local titansBasePart = workspace:FindFirstChild("Titans")
if titansBasePart then
    processTitans(titansBasePart)
end
