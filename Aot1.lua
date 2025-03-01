-- سكريبت واجهة المستخدم 
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

-- إعدادات الشاشة
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

frame.Parent = screenGui
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
frame.Position = UDim2.new(0.4164823, 0, 0.0479591824, 0)
frame.Size = UDim2.new(0, 340, 0, 329)
frame.Style = Enum.FrameStyle.RobloxRound

titleLabel.Name = "Title"
titleLabel.Parent = frame
titleLabel.BackgroundTransparency = 1
titleLabel.Position = UDim2.new(0.0207602102, 0, -0.00166114408, 0)
titleLabel.Size = UDim2.new(0, 312, 0, 50)
titleLabel.Text = "Tekkit AotR"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true

scrollingFrame.Parent = frame
scrollingFrame.Active = true
scrollingFrame.Position = UDim2.new(0.0415333472, 0, 0.162598208, 0)
scrollingFrame.Size = UDim2.new(0, 305, 0, 256)

teleportLabel.Name = "Teleport"
teleportLabel.Parent = scrollingFrame
teleportLabel.Text = "Nape Teleport"

titanFarmerLabel.Name = "Titan Farmer"
titanFarmerLabel.Parent = scrollingFrame
titanFarmerLabel.Text = "Titan Farmer"

tpButton.Name = "tpButton"
tpButton.Parent = scrollingFrame
tpButton.Position = UDim2.new(0.7, 0, 0.035, 0)
tpButton.Size = UDim2.new(0, 30, 0, 30)

tpButtonF.Name = "tpButtonF"
tpButtonF.Parent = scrollingFrame
tpButtonF.Position = UDim2.new(0.7, 0, 0.1, 0)
tpButtonF.Size = UDim2.new(0, 30, 0, 30)

refillButton.Name = "refill"
refillButton.Parent = scrollingFrame
refillButton.Position = UDim2.new(0.23, 0, 0.265, 0)
refillButton.Text = "Tp to Refill"

espLabel.Name = "esp"
espLabel.Parent = scrollingFrame
espLabel.Text = "Titan ESP"

tpButtonE.Name = "tpButtonE"
tpButtonE.Parent = scrollingFrame
tpButtonE.Position = UDim2.new(0.7, 0, 0.185, 0)
tpButtonE.Size = UDim2.new(0, 30, 0, 30)

frame.Draggable = true

-- إعدادات اللعبة
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local titanFarmerEnabled = false
local espEnabled = false

local function getPlayerPosition()
    local character = player.Character or player.CharacterAdded:Wait()
    return character:WaitForChild("HumanoidRootPart").Position
end

-- العثور على أقرب ناپ
local function findClosestNape()
    local closest = nil
    local minDist = 1250
    for _, nape in pairs(workspace.Nape:GetChildren()) do
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
    local closestNape = findClosestNape()
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
            local closestNape = findClosestNape()
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
    else
        tpButtonE.Text = "Start Titan ESP"
    end
end)

-- الضغط المستمر على زر الماوس الأيسر
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

-- تطبيق التعديلات على الناب
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
