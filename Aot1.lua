-- إعداد واجهة المستخدم
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
    local rootPart = character:WaitForChild("HumanoidRootPart")
    if rootPart and rootPart:IsA("BasePart") then
        local position = rootPart.Position
        print("HumanoidRootPart Location:", position)
        return position
    else
        warn("HumanoidRootPart not found for LocalPlayer.")
        return nil
    end
end

-- دالة للعثور على أقرب Nape
local function findClosestNape()
    local titansFolder = Workspace:FindFirstChild("Titans")
    local closestNape = nil
    local minDistance = math.huge
    if titansFolder then
        local playerPos = getPlayerPosition()
        for _, titan in ipairs(titansFolder:GetChildren()) do
            if titan:IsA("Model") and titan:FindFirstChildOfClass("Humanoid") then
                local hitboxes = titan:FindFirstChild("Hitboxes")
                if hitboxes then
                    local hit = hitboxes:FindFirstChild("Hit")
                    if hit then
                        local nape = hit:FindFirstChild("Nape")
                        if nape then
                            local distance = (nape.Position - playerPos).Magnitude
                            if distance < minDistance and distance <= maxTeleportDistance then
                                minDistance = distance
                                closestNape = nape
                            end
                        end
                    end
                end
            end
        end
    else
        warn("Titans folder not found in Workspace.")
    end
    if closestNape then
        napeLocation = closestNape
        print("Closest NapeLocation set to:", napeLocation.Position)
    else
        warn("No Nape part found within maximum teleport distance.")
    end
    return napeLocation
end

-- دالة للتحرك إلى Nape باستخدام BodyPosition و BodyGyro
local function teleportToNape()
    if napeLocation then
        local character = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if character then
            local bodyPosition = Instance.new("BodyPosition")
            bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyPosition.Position = napeLocation.Position + Vector3.new(0, 450, 0)
            bodyPosition.Parent = character

            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyGyro.CFrame = character.CFrame
            bodyGyro.Parent = character
            return bodyPosition, bodyGyro
        else
            warn("Nape not found.")
            return nil, nil
        end
    end
end

-- دالة لإزالة BodyPosition و BodyGyro
local function cleanupTeleport(bodyPos, bodyGyro)
    if bodyPos then bodyPos:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
end

-- دالة للانتقال السريع إلى Nape
local function quickTeleport()
    local character = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if character then
        local startPos = character.Position
        local function setPosition(pos)
            character.CFrame = CFrame.new(pos)
        end
        local function teleportSequence()
            findClosestNape()
            if napeLocation then
                local napePos = napeLocation.Position
                local step = (napePos - startPos) / 4
                local offset = step * 3
                for i = 1, 2 do
                    setPosition(startPos + offset)
                    wait(0.001)
                    setPosition(napePos)
                    setPosition(napePos)
                    setPosition(napePos)
                    setPosition(napePos)
                end
            end
        end
        teleportSequence()
    end
end

-- دالة لتبديل وضع Titan Farmer
local function toggleTitanFarmer()
    titanFarmerEnabled = not titanFarmerEnabled
    if titanFarmerEnabled then
        print("Teleportation Enabled")
        findClosestNape()
        local bodyPos, bodyGyro = teleportToNape()
        spawn(function()
            while titanFarmerEnabled do
                wait(1)
                findClosestNape()
                if bodyPos and bodyGyro and napeLocation then
                    bodyPos.Position = napeLocation.Position + Vector3.new(0, 300, 0)
                    bodyGyro.CFrame = player.Character.HumanoidRootPart.CFrame
                end
            end
            cleanupTeleport(bodyPos, bodyGyro)
        end)
    else
        print("Teleportation Disabled")
    end
end

tpButtonF.MouseButton1Click:Connect(function()
    toggleTitanFarmer()
    tpButtonF.BackgroundColor3 = titanFarmerEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
end)

UserInputService.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and titanFarmerEnabled then
        quickTeleport()
    end
end)

-- نظام Titan ESP
local highlightsList = {}
local espActive = false

local function createHighlight(model, color, transparency)
    if not model:FindFirstChildOfClass("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = model
        highlight.FillTransparency = transparency or 0.5
        highlight.FillColor = color or Color3.new(1, 1, 1)
        highlight.OutlineTransparency = transparency or 0
        highlight.OutlineColor = color or Color3.new(1, 1, 1)
        highlight.Enabled = espActive
        highlight.Parent = model
        table.insert(highlightsList, highlight)
        print("Highlight created for model: " .. model.Name)
    else
        print("Highlight already exists for model: " .. model.Name)
    end
end

local function highlightTitanParts(model)
    local parts = {"LowerTorso", "LeftUpperArm", "RightUpperLeg", "LeftLowerLeg", "LeftUpperLeg", "RightLowerLeg", "LeftFoot", "RightLowerArm", "UpperTorso", "LeftLowerArm", "RightUpperArm", "LeftHand", "RightFoot", "RightHand", "Head"}
    for _, partName in ipairs(parts) do
        local part = model:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            createHighlight(part.Parent, Color3.new(1, 1, 1), 0.65)
        else
            print("Part not found or not a BasePart: " .. partName)
        end
    end
end

local function applyESP()
    local titansFolder = Workspace:FindFirstChild("Titans")
    if titansFolder then
        for _, titan in ipairs(titansFolder:GetChildren()) do
            if titan:IsA("Model") and titan:FindFirstChildOfClass("Humanoid") then
                local fakeModel = titan:FindFirstChild("Fake")
                if fakeModel then
                    print("Highlighting model: " .. titan.Name)
                    highlightTitanParts(fakeModel)
                else
                    print("No Fake model found in: " .. titan.Name)
                end
            else
                print("No Humanoid found in: " .. titan.Name)
            end
        end
    else
        warn("Titans folder not found in Workspace.")
    end
end

local function toggleESP(active)
    espActive = active
    for _, highlight in ipairs(highlightsList) do
        if highlight:IsA("Highlight") then
            highlight.Enabled = espActive
        end
    end
    tpButtonE.BackgroundColor3 = espActive and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if not espActive then
        for _, highlight in ipairs(highlightsList) do
            highlight:Destroy()
        end
        highlightsList = {}
    else
        applyESP()
    end
end

tpButtonE.MouseButton1Click:Connect(function()
    toggleESP(not espActive)
end)

applyESP()

-- دالة للحصول على موقع Nape الثاني
local function findSecondClosestNape()
    local titansFolder = Workspace:FindFirstChild("Titans")
    local closestNapeCFrame = nil
    local minDistance = math.huge
    if titansFolder then
        local playerPos = getPlayerPosition()
        for _, titan in ipairs(titansFolder:GetChildren()) do
            if titan:IsA("Model") and titan:FindFirstChildOfClass("Humanoid") then
                local hitboxes = titan:FindFirstChild("Hitboxes")
                if hitboxes then
                    local hit = hitboxes:FindFirstChild("Hit")
                    if hit then
                        local nape = hit:FindFirstChild("Nape")
                        if nape then
                            local distance = (nape.Position - playerPos).Magnitude
                            if distance < minDistance and distance <= maxTeleportDistance then
                                minDistance = distance
                                closestNapeCFrame = nape.CFrame
                            end
                        end
                    end
                end
            end
        end
    else
        warn("Titans folder not found in Workspace.")
    end
    if closestNapeCFrame then
        closestNape = closestNapeCFrame
        print("Closest NapeLocation2 set to:", closestNape)
    else
        warn("No Nape part found within maximum teleport distance.")
    end
    return closestNape
end

-- دالة لتبديل التنقل إلى Nape
local function toggleNapeTeleport()
    teleportEnabled = not teleportEnabled
    local status = teleportEnabled and "Teleport Enabled (Bypass status is unknown)" or "Teleport Disabled (Bypass status is unknown)"
    print("Nape Teleportation Toggled: " .. status)
    return status
end

-- دالة للتنقل إلى Nape مع سرعة
local function napeTeleport()
    if teleportEnabled then
        findSecondClosestNape()
        local character = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if character and closestNape then
            local originalCFrame = character.CFrame
            character.CFrame = closestNape
            delay(0.01, function()
                character.Velocity = Vector3.new(300, 10, 0)
            end)
            delay(0.35, function()
                character.CFrame = originalCFrame
                closestNape = nil
                print("NapeLocation reset to nil")
            end)
        end
    end
end

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and teleportEnabled then
        napeTeleport()
    end
end)

tpButton.MouseButton1Click:Connect(function()
    local status = toggleNapeTeleport()
    tpButton.BackgroundColor3 = teleportEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
end)

-- التنقل إلى GasTank للتعبئة
local gasTank = game.Workspace.Unclimbable.Reloads.GasTanks:FindFirstChild("GasTank"):FindFirstChild("GasTank")
local function teleportToRefill()
    local character = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if gasTank and character then
        local tankCFrame = gasTank.CFrame
        character.CFrame = tankCFrame + Vector3.new(0, 25, 0)
    end
end

refillButton.MouseButton1Click:Connect(teleportToRefill)

-- إخفاء/إظهار الواجهة باستخدام RightShift
local function toggleFrameVisibility()
    if frame.Visible then
        frame.Visible = false
        wait(0.35)
    else
        frame.Visible = true
        wait(0.35)
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        toggleFrameVisibility()
    end
end) هدا سكريبت رئيسي
