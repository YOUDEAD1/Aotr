-- سكريبت محسن لـ AOTR (مع GUI مخصص وإصلاح التحكم)
-- التاريخ: 28 فبراير 2025

print("AOTR Script Starting - Custom GUI Enhanced - Grok @ xAI")

local VIM = game:GetService("VirtualInputManager")
local workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- تحقق من اللاعب والشخصية
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid", 5)
local rootPart = character:WaitForChild("HumanoidRootPart", 5)
local camera = workspace.CurrentCamera

if not humanoid or not rootPart then
    warn("Failed to find Humanoid or HumanoidRootPart.")
    return
end

-- متغيرات التحكم
local autoFarmEnabled = false
local attackSpeed = 0.03
local teleportOffset = Vector3.new(0, 5, -5)
getgenv().autoescape = false
getgenv().autor = false
local napeExpanderEnabled = false
local titanMarkersEnabled = false
local cameraLockEnabled = false

-- جدول السكربت الأول
local encodedTable = {
    "sb94mq1=", 8455876, "AJ54l+t=", "lw0MO3v=", 286080029, 4034956, "Wd0aXmykzv==",
    "4uPmxi==", "U9p3hYh=", 16456370330, "d07D97H=", 13816647, 4443058285, 7426775,
    "9/AJXd1=", "xrBbpqm=", 14, "ejp=", "tIi=", 35067303023060, "U+fNWRo=", "z2o=",
    "6RyYUPwKU+fKTPwqL9HiX8fpWBwezBvP48IZD+yt2QwZueoaUr4PT9wtL+nazDCKXrta2B5KU+fKT1YOT94KXq0phOkN2+ktWBwKXqwYW8MyDkjlGejns6j=",
    "PSvu/v==", "qJMWUXh=", 15948975, "9gXs3CM=", "GVx4Ii3=", 12141128, 15606895,
    "Colossal", "Armored", "Female", "Beast", "Jaw", "Attack", "Warhammer", "Cart"
}

local function decodeValue(value)
    if type(value) == "string" and value:find("=") then
        local base64Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        local data = value:gsub("[^" .. base64Alphabet .. "=]", "")
        local binaryString = data:gsub(".", function(char)
            if char == "=" then return "" end
            local charValue = base64Alphabet:find(char, 1, true) - 1
            local bits = ""
            for i = 6, 1, -1 do
                bits = bits .. ((charValue % 2^i - charValue % 2^(i-1) > 0) and "1" or "0")
            end
            return bits
        end)
        local decoded = binaryString:gsub("%d%d%d?%d?%d?%d?%d?%d?", function(byteString)
            if #byteString ~= 8 then return "" end
            local byteValue = 0
            for i = 1, 8 do
                byteValue = byteValue + ((byteString:sub(i, i) == "1") and 2^(8 - i) or 0)
            end
            return string.char(byteValue)
        end)
        return decoded ~= "" and decoded or value
    end
    return value
end

-- دوال Nape Expander
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

-- إعداد GUI مخصص
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.Name = "AOTR_ControlPanel"

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0.8, 0, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.Text = "AOTR Control Panel"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.BackgroundTransparency = 1
titleText.Font = Enum.Font.SourceSansBold
titleText.TextSize = 18
titleText.Parent = titleBar

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(0, 30, 0, 30)
hideButton.Position = UDim2.new(1, -30, 0, 0)
hideButton.Text = "-"
hideButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.Parent = titleBar

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -40)
contentFrame.Position = UDim2.new(0, 10, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = contentFrame

-- وظيفة الإخفاء/الإظهار
local isHidden = false
hideButton.MouseButton1Click:Connect(function()
    isHidden = not isHidden
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if isHidden then
        TweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -150, 1, 0)}):Play()
        hideButton.Text = "+"
    else
        TweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -150, 0.5, -200)}):Play()
        hideButton.Text = "-"
    end
end)

-- إضافة أزرار التحكم
local function createToggleButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Text = text .. ": OFF"
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.Parent = contentFrame
    local state = false
    button.MouseButton1Click:Connect(function()
        state = not state
        button.Text = text .. (state and ": ON" or ": OFF")
        callback(state)
    end)
    return button
end

local function createSlider(text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 60)
    frame.BackgroundTransparency = 1
    frame.Parent = contentFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Text = text .. ": " .. default
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 18
    label.Parent = frame

    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(1, 0, 0, 20)
    slider.Position = UDim2.new(0, 0, 0, 30)
    slider.Text = ""
    slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    slider.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    fill.Parent = slider

    slider.MouseButton1Down:Connect(function()
        local mouseConnection
        mouseConnection = UIS.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local relativeX = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                fill.Size = UDim2.new(relativeX, 0, 1, 0)
                local value = min + (relativeX * (max - min))
                label.Text = text .. ": " .. string.format("%.2f", value)
                callback(value)
            end
        end)
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                mouseConnection:Disconnect()
            end
        end)
    end)
end

local function createButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 18
    button.Parent = contentFrame
    button.MouseButton1Click:Connect(callback)
end

-- إعداد عناصر GUI
createToggleButton("Auto-Farm", function(state)
    autoFarmEnabled = state
    print("Auto-Farm " .. (state and "Enabled" or "Disabled"))
end)

createToggleButton("Auto-Escape", function(state)
    getgenv().autoescape = state
    print("Auto-Escape " .. (state and "Enabled" or "Disabled"))
end)

createToggleButton("Auto-R (Blade Reload)", function(state)
    getgenv().autor = state
    print("Auto-R " .. (state and "Enabled" or "Disabled"))
end)

createToggleButton("Nape Expander", function(state)
    napeExpanderEnabled = state
    print("Nape Expander " .. (state and "Enabled" or "Disabled"))
end)

createToggleButton("Titan Markers", function(state)
    titanMarkersEnabled = state
    print("Titan Markers " .. (state and "Enabled" or "Disabled"))
end)

createToggleButton("Camera Lock", function(state)
    cameraLockEnabled = state
    print("Camera Lock " .. (state and "Enabled" or "Disabled"))
end)

createSlider("Attack Speed", 0.01, 0.1, 0.03, function(value)
    attackSpeed = value
    print("Attack Speed set to: " .. value)
end)

createButton("Kill All Titans", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
            pcall(function()
                obj.Humanoid.Health = 0
            end)
        end
    end
    print("Attempted to kill all Titans!")
end)

-- Auto-Farm
spawn(function()
    while task.wait(0.1) do
        if not autoFarmEnabled then continue end
        local titansFolder = workspace:FindFirstChild("Titans")
        if not titansFolder then
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Model") and obj.Name:lower():find("titan") then
                    titansFolder = obj.Parent or obj
                    break
                end
            end
        end
        if not titansFolder then
            titansFolder = workspace
        end

        for _, titan in pairs(titansFolder:GetDescendants()) do
            if titan:IsA("Model") and titan:FindFirstChild("Humanoid") and titan.Humanoid.Health > 0 then
                local titanRoot = titan:FindFirstChild("HumanoidRootPart") or titan:FindFirstChildWhichIsA("BasePart")
                if not titanRoot then continue end

                pcall(function()
                    rootPart.CFrame = CFrame.new(titanRoot.Position + teleportOffset)
                end)

                local attacked = false
                local attackEventNames = {"BladeHit", "SwingBlade", "Attack", "Hit", "DamageEvent", "DealDamage", "BladeSwing", "Strike"}
                for _, eventName in ipairs(attackEventNames) do
                    local attackEvent = game:GetService("ReplicatedStorage"):FindFirstChild(eventName)
                    if attackEvent then
                        pcall(function()
                            for _ = 1, 30 do
                                attackEvent:FireServer(titan)
                                task.wait(attackSpeed)
                            end
                        end)
                        attacked = true
                        break
                    end
                end
                if not attacked then
                    pcall(function()
                        titan.Humanoid:TakeDamage(1000)
                    end)
                end
            end
        end
    end
end)

-- Auto-Escape مع W، A، S، D عند الإمساك
spawn(function()
    local escapeKeys = {"W", "A", "S", "D"}
    while task.wait(0.05) do
        if not getgenv().autoescape then continue end
        local isGrabbed = humanoid.WalkSpeed <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Ragdoll
        
        if isGrabbed then
            for _, key in pairs(escapeKeys) do
                VIM:SendKeyEvent(true, key, false, game)
                task.wait(0.05)
                VIM:SendKeyEvent(false, key, false, game)
                task.wait(0.05)
            end
        end
    end
end)

-- Auto-R
spawn(function()
    while task.wait(0.1) do
        if not getgenv().autor then continue end
        local rig = character:FindFirstChild("Rig_" .. player.Name)
        if not rig then continue end
        for _, v in pairs(rig:GetChildren()) do
            if v.Name == "RightHand" or v.Name == "LeftHand" then
                for _, v2 in pairs(v:GetChildren()) do
                    if v2.Name == "Blade_1" and v2:GetAttribute("Broken") == true then
                        VIM:SendKeyEvent(true, "R", false, game)
                        task.wait(0.01)
                        VIM:SendKeyEvent(false, "R", false, game)
                    end
                end
            end
        end
    end
end)

-- Nape Expander
spawn(function()
    while task.wait(0.1) do
        if not napeExpanderEnabled then continue end
        local titansFolder = workspace:FindFirstChild("Titans") or workspace
        processTitans(titansFolder)
    end
end)

-- Titan Markers
spawn(function()
    local titanMarkers = {}
    while task.wait(0.1) do
        if not titanMarkersEnabled then
            for _, obj in pairs(titanMarkers) do obj:Destroy() end
            titanMarkers = {}
            continue
        end
        for _, obj in pairs(titanMarkers) do obj:Destroy() end
        titanMarkers = {}
        for i, value in ipairs(encodedTable) do
            if value == "Colossal" or value == "Armored" or value == "Female" or value == "Beast" or value == "Jaw" or value == "Attack" or value == "Warhammer" or value == "Cart" then
                titanMarkers[value] = Drawing.new("Circle")
                titanMarkers[value].Radius = 50
                titanMarkers[value].Position = Vector2.new(rootPart.Position.X + (i * 30), rootPart.Position.Z + 100)
                titanMarkers[value].Color = Color3.new(0, 1, 0)
                titanMarkers[value].Thickness = 2
                titanMarkers[value].Visible = true
            end
        end
    end
end)

-- Camera Lock
spawn(function()
    local range = 6000
    local settings = {x = 5, y = 2, z = -0.3}
    while task.wait() do
        if not cameraLockEnabled then continue end
        if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then continue end
        local titan, closestDist = nil, nil
        local titansFolder = workspace:FindFirstChild("Titans") or workspace
        for _, opposition in pairs(titansFolder:GetDescendants()) do
            local titanRoot = opposition:FindFirstChild("HumanoidRootPart")
            if titanRoot then
                local calcDist = (titanRoot.Position - rootPart.Position).Magnitude
                if calcDist <= range then
                    if not titan or calcDist < closestDist then
                        titan = opposition
                        closestDist = calcDist
                    end
                end
            end
        end
        if titan then
            local align = CFrame.new(rootPart.Position + Vector3.new(settings.x, settings.y, settings.z), titan:FindFirstChild("Fake") and titan.Fake:FindFirstChild("Head") and titan.Fake.Head.Position + Vector3.new(0, -2.4, 0) or titan:FindFirstChild("HumanoidRootPart").Position)
            camera.CFrame = align
            camera.CameraSubject = character
            camera.CameraType = Enum.CameraType.Attach
            camera.FieldOfView = 120
        end
    end
end)

print("AOTR Script Loaded Successfully with Custom GUI - Grok @ xAI")
