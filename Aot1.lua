
local workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- دالة للعثور على Nape
local function findNape(hitFolder)
    return hitFolder:FindFirstChild("Nape")
end

-- دالة لتوسيع Hitbox الخاص بـ Nape
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

-- دالة لمعالجة العمالقة
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

-- إنشاء واجهة المستخدم الرسومية (GUI)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local TeleportLabel = Instance.new("TextLabel")
local TitanFarmerLabel = Instance.new("TextLabel")
local tpButton = Instance.new("TextButton")
local tpButtonF = Instance.new("TextButton")
local refillButton = Instance.new("TextButton")
local espLabel = Instance.new("TextLabel")
local tpButtonE = Instance.new("TextButton")
local closeButton = Instance.new("TextButton") -- زر X
local minimizeButton = Instance.new("TextButton") -- زر -
local maximizeButton = Instance.new("TextButton") -- زر +

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.4164823, 0, 0.0479591824, 0)
Frame.Size = UDim2.new(0, 340, 0, 329)
Frame.Style = Enum.FrameStyle.RobloxRound
Frame.Draggable = true
Frame.Selectable = true
Frame.Active = true

Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.0207602102, 0, -0.00166114408, 0)
Title.Size = UDim2.new(0, 312, 0, 50)
Title.Font = Enum.Font.SourceSans -- استبدلت Unknown بـ SourceSans لأن Solara قد لا يدعم بعض الخطوط
Title.Text = "Tekkit AotR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 1.000
Title.TextWrapped = true

ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1.000
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.0415333472, 0, 0.162598208, 0)
ScrollingFrame.Size = UDim2.new(0, 305, 0, 256)
ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

TeleportLabel.Name = "Teleport"
TeleportLabel.Parent = ScrollingFrame
TeleportLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportLabel.BackgroundTransparency = 1.000
TeleportLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TeleportLabel.BorderSizePixel = 0
TeleportLabel.Position = UDim2.new(0.0799999982, 0, 0.0299999993, 0)
TeleportLabel.Size = UDim2.new(0, 200, 0.0599999987, 0)
TeleportLabel.Font = Enum.Font.SourceSans -- استبدلت Fondamento للتوافق
TeleportLabel.Text = "Nape Teleport"
TeleportLabel.TextColor3 = Color3.fromRGB(148, 148, 148)
TeleportLabel.TextSize = 25.000
TeleportLabel.TextWrapped = true

TitanFarmerLabel.Name = "Titan Farmer"
TitanFarmerLabel.Parent = ScrollingFrame
TitanFarmerLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitanFarmerLabel.BackgroundTransparency = 1.000
TitanFarmerLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TitanFarmerLabel.BorderSizePixel = 0
TitanFarmerLabel.Position = UDim2.new(0.0804597735, 0, 0.104999997, 0)
TitanFarmerLabel.Size = UDim2.new(0, 200, 0.0599999987, 0)
TitanFarmerLabel.Font = Enum.Font.SourceSans
TitanFarmerLabel.Text = "Titan Farmer"
TitanFarmerLabel.TextColor3 = Color3.fromRGB(148, 148, 148)
TitanFarmerLabel.TextSize = 20.000
TitanFarmerLabel.TextWrapped = true

tpButton.Name = "tpButton"
tpButton.Parent = ScrollingFrame
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
tpButtonF.Parent = ScrollingFrame
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
refillButton.Parent = ScrollingFrame
refillButton.BackgroundColor3 = Color3.fromRGB(94, 94, 94)
refillButton.BackgroundTransparency = 0.800
refillButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
refillButton.BorderSizePixel = 0
refillButton.Position = UDim2.new(0.230000004, 0, 0.264999986, 0)
refillButton.Size = UDim2.new(0, 100, 0, 25)
refillButton.Font = Enum.Font.SourceSans
refillButton.Text = "Tp to Refill"
refillButton.TextColor3 = Color3.fromRGB(148, 148, 148)
refillButton.TextScaled = true
refillButton.TextSize = 27.000
refillButton.TextWrapped = true

espLabel.Name = "esp"
espLabel.Parent = ScrollingFrame
espLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
espLabel.BackgroundTransparency = 1.000
espLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
espLabel.BorderSizePixel = 0
espLabel.Position = UDim2.new(0.0542302355, 0, 0.181999996, 0)
espLabel.Size = UDim2.new(0, 200, 0.0599999987, 0)
espLabel.Font = Enum.Font.SourceSans
espLabel.Text = "Titan ESP"
espLabel.TextColor3 = Color3.fromRGB(148, 148, 148)
espLabel.TextSize = 23.000
espLabel.TextWrapped = true

tpButtonE.Name = "tpButtonE"
tpButtonE.Parent = ScrollingFrame
tpButtonE.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tpButtonE.BorderColor3 = Color3.fromRGB(0, 0, 0)
tpButtonE.BorderSizePixel = 2
tpButtonE.Position = UDim2.new(0.699999988, 0, 0.185000002, 0)
tpButtonE.Size = UDim2.new(0, 30, 0, 30)
tpButtonE.Font = Enum.Font.SourceSans
tpButtonE.Text = ""
tpButtonE.TextColor3 = Color3.fromRGB(0, 0, 0)
tpButtonE.TextSize = 14.000

closeButton.Name = "CloseButton"
closeButton.Parent = Frame
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20

minimizeButton.Name = "MinimizeButton"
minimizeButton.Parent = Frame
minimizeButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
minimizeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
minimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 20

maximizeButton.Name = "MaximizeButton"
maximizeButton.Parent = ScreenGui
maximizeButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
maximizeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
maximizeButton.Position = UDim2.new(0.4164823, 0, 0.0479591824, 0)
maximizeButton.Size = UDim2.new(0, 30, 0, 30)
maximizeButton.Font = Enum.Font.SourceSansBold
maximizeButton.Text = "+"
maximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
maximizeButton.TextSize = 20
maximizeButton.Visible = false

-- متغيرات التحكم
local NapeLocation
local TitanFarmerEnabled = false
local MaxTeleportDistance = 1250
local ESPEnabled = false
local TeleportEnabled = false
local Highlights = {}

-- دالة للحصول على موقع اللاعب
local function getPlayerPosition()
    local character = LocalPlayer.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            return rootPart.Position
        end
    end
    return nil
end

-- دالة للعثور على أقرب Nape
local function findClosestNape()
    local titansFolder = workspace:FindFirstChild("Titans")
    local closestNape = nil
    local minDistance = math.huge
    if titansFolder then
        local playerPos = getPlayerPosition()
        if playerPos then
            for _, titan in ipairs(titansFolder:GetChildren()) do
                if titan:IsA("Model") then
                    local hitboxes = titan:FindFirstChild("Hitboxes")
                    if hitboxes then
                        local hit = hitboxes:FindFirstChild("Hit")
                        if hit then
                            local nape = hit:FindFirstChild("Nape")
                            if nape then
                                local distance = (nape.Position - playerPos).Magnitude
                                if distance < minDistance and distance <= MaxTeleportDistance then
                                    minDistance = distance
                                    closestNape = nape
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    NapeLocation = closestNape
    return NapeLocation
end

-- دالة للنقل الآني البسيط
local function simpleTeleport()
    findClosestNape()
    if NapeLocation then
        local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = CFrame.new(NapeLocation.Position + Vector3.new(0, 10, 0))
        end
    end
end

-- دالة للنقل الآني إلى Nape مع BodyPosition
local function teleportToNape()
    if NapeLocation then
        local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local bodyPos = Instance.new("BodyPosition")
            bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyPos.Position = NapeLocation.Position + Vector3.new(0, 450, 0)
            bodyPos.Parent = rootPart
            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyGyro.CFrame = rootPart.CFrame
            bodyGyro.Parent = rootPart
            return bodyPos, bodyGyro
        end
    end
    return nil, nil
end

-- دالة لإزالة BodyPosition وBodyGyro
local function removeBodyObjects(bodyPos, bodyGyro)
    if bodyPos then bodyPos:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
end

-- تفعيل/تعطيل Titan Farmer
local function toggleTitanFarmer()
    TitanFarmerEnabled = not TitanFarmerEnabled
    if TitanFarmerEnabled then
        findClosestNape()
        local bodyPos, bodyGyro = teleportToNape()
        spawn(function()
            while TitanFarmerEnabled and wait(1) do
                findClosestNape()
                if bodyPos and bodyGyro then
                    bodyPos.Position = NapeLocation.Position + Vector3.new(0, 300, 0)
                    bodyGyro.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
            removeBodyObjects(bodyPos, bodyGyro)
        end)
    end
    tpButtonF.BackgroundColor3 = TitanFarmerEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
end

-- دالة لإنشاء Highlight
local function createHighlight(model, color, transparency)
    if not model:FindFirstChildOfClass("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = model
        highlight.FillTransparency = transparency or 0.5
        highlight.FillColor = color or Color3.new(1, 1, 1)
        highlight.OutlineTransparency = transparency or 0
        highlight.OutlineColor = color or Color3.new(1, 1, 1)
        highlight.Enabled = ESPEnabled
        highlight.Parent = model
        table.insert(Highlights, highlight)
    end
end

-- دالة لتطبيق ESP على العمالقة
local function applyESP()
    local titansFolder = workspace:FindFirstChild("Titans")
    if titansFolder then
        for _, titan in ipairs(titansFolder:GetChildren()) do
            if titan:IsA("Model") then
                local fake = titan:FindFirstChild("Fake")
                if fake then
                    createHighlight(fake, Color3.new(1, 1, 1), 0.65)
                end
            end
        end
    end
end

-- تفعيل/تعطيل ESP
local function toggleESP(enable)
    ESPEnabled = enable
    for _, highlight in ipairs(Highlights) do
        highlight.Enabled = ESPEnabled
    end
    tpButtonE.BackgroundColor3 = ESPEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if not ESPEnabled then
        for _, highlight in ipairs(Highlights) do
            highlight:Destroy()
        end
        Highlights = {}
    else
        applyESP()
    end
end

-- النقل إلى Refill
local function teleportToRefill()
    local gasTank = workspace:FindFirstChild("Unclimbable") and workspace.Unclimbable:FindFirstChild("Reloads") and workspace.Unclimbable.Reloads:FindFirstChild("GasTanks") and workspace.Unclimbable.Reloads.GasTanks:FindFirstChild("GasTank") and workspace.Unclimbable.Reloads.GasTanks.GasTank:FindFirstChild("GasTank")
    local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if gasTank and rootPart then
        rootPart.CFrame = gasTank.CFrame + Vector3.new(0, 25, 0)
    end
end

-- تفعيل/تعطيل النقل الآني
local function toggleTeleport()
    TeleportEnabled = not TeleportEnabled
    tpButton.BackgroundColor3 = TeleportEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
end

-- دالة لإخفاء/إظهار الواجهة
local function toggleFrameVisibility()
    if Frame.Visible then
        Frame.Visible = false
        maximizeButton.Visible = true
    else
        Frame.Visible = true
        maximizeButton.Visible = false
    end
end

-- دالة لإزالة السكريبت
local function removeScript()
    ScreenGui:Destroy()
end

-- تشغيل توسيع Nape عند البدء
local function initialize()
    print("Nape Expander Loaded - Solara Compatible")
    local titansBasePart = workspace:FindFirstChild("Titans")
    if titansBasePart then
        processTitans(titansBasePart)
    end
    workspace.ChildAdded:Connect(function(child)
        if child.Name == "Titans" then
            processTitans(child)
        end
    end)
end

-- ربط الأحداث
tpButtonF.MouseButton1Click:Connect(toggleTitanFarmer)
tpButton.MouseButton1Click:Connect(toggleTeleport)
tpButtonE.MouseButton1Click:Connect(function() toggleESP(not ESPEnabled) end)
refillButton.MouseButton1Click:Connect(teleportToRefill)
closeButton.MouseButton1Click:Connect(removeScript)
minimizeButton.MouseButton1Click:Connect(toggleFrameVisibility)
maximizeButton.MouseButton1Click:Connect(toggleFrameVisibility)

-- النقل الآني الدائم عند الضغط على زر الماوس الأيسر
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and TeleportEnabled then
        simpleTeleport()
    elseif input.KeyCode == Enum.KeyCode.RightShift then
        toggleFrameVisibility()
    end
end)

-- البدء
initialize()
applyESP()
