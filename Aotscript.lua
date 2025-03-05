-- إعداد المتغيرات الأساسية
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

-- التحقق من وجود PlayerGui
if not LocalPlayer:FindFirstChild("PlayerGui") then
    warn("PlayerGui not found. Waiting for it to load...")
    LocalPlayer:WaitForChild("PlayerGui", 10)
end

-- إعداد واجهة المستخدم
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Frame = Instance.new("Frame")
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

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0.0207602102, 0, -0.00166114408, 0)
Title.Size = UDim2.new(0, 312, 0, 50)
Title.Font = Enum.Font.SourceSans
Title.Text = "Tekkit AotR"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.TextSize = 14
Title.TextWrapped = true

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.0415333472, 0, 0.162598208, 0)
ScrollingFrame.Size = UDim2.new(0, 305, 0, 256)
ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

local TeleportLabel = Instance.new("TextLabel")
TeleportLabel.Name = "Teleport"
TeleportLabel.Parent = ScrollingFrame
TeleportLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TeleportLabel.BackgroundTransparency = 1
TeleportLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TeleportLabel.BorderSizePixel = 0
TeleportLabel.Position = UDim2.new(0.08, 0, 0.03, 0)
TeleportLabel.Size = UDim2.new(0, 200, 0, 18)
TeleportLabel.Font = Enum.Font.SourceSans
TeleportLabel.Text = "Nape Teleport"
TeleportLabel.TextColor3 = Color3.fromRGB(148, 148, 148)
TeleportLabel.TextSize = 25
TeleportLabel.TextWrapped = true

local TitanFarmerLabel = Instance.new("TextLabel")
TitanFarmerLabel.Name = "TitanFarmer"
TitanFarmerLabel.Parent = ScrollingFrame
TitanFarmerLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitanFarmerLabel.BackgroundTransparency = 1
TitanFarmerLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TitanFarmerLabel.BorderSizePixel = 0
TitanFarmerLabel.Position = UDim2.new(0.0804597735, 0, 0.105, 0)
TitanFarmerLabel.Size = UDim2.new(0, 200, 0, 18)
TitanFarmerLabel.Font = Enum.Font.SourceSans
TitanFarmerLabel.Text = "Titan Farmer"
TitanFarmerLabel.TextColor3 = Color3.fromRGB(148, 148, 148)
TitanFarmerLabel.TextSize = 20
TitanFarmerLabel.TextWrapped = true

local TpButton = Instance.new("TextButton")
TpButton.Name = "tpButton"
TpButton.Parent = ScrollingFrame
TpButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
TpButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TpButton.BorderSizePixel = 2
TpButton.Position = UDim2.new(0.7, 0, 0.035, 0)
TpButton.Size = UDim2.new(0, 30, 0, 30)
TpButton.Font = Enum.Font.SourceSans
TpButton.Text = ""
TpButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TpButton.TextSize = 14

local TpButtonF = Instance.new("TextButton")
TpButtonF.Name = "tpButtonF"
TpButtonF.Parent = ScrollingFrame
TpButtonF.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
TpButtonF.BorderColor3 = Color3.fromRGB(0, 0, 0)
TpButtonF.BorderSizePixel = 2
TpButtonF.Position = UDim2.new(0.7, 0, 0.109, 0)
TpButtonF.Size = UDim2.new(0, 30, 0, 30)
TpButtonF.Font = Enum.Font.SourceSans
TpButtonF.Text = ""
TpButtonF.TextColor3 = Color3.fromRGB(0, 0, 0)
TpButtonF.TextSize = 14

local RefillButton = Instance.new("TextButton")
RefillButton.Name = "refill"
RefillButton.Parent = ScrollingFrame
RefillButton.BackgroundColor3 = Color3.fromRGB(94, 94, 94)
RefillButton.BackgroundTransparency = 0.8
RefillButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
RefillButton.BorderSizePixel = 0
RefillButton.Position = UDim2.new(0.23, 0, 0.265, 0)
RefillButton.Size = UDim2.new(0, 100, 0, 25)
RefillButton.Font = Enum.Font.SourceSans
RefillButton.Text = "Tp to Refill"
RefillButton.TextColor3 = Color3.fromRGB(148, 148, 148)
RefillButton.TextScaled = true
RefillButton.TextSize = 27
RefillButton.TextWrapped = true

local EspLabel = Instance.new("TextLabel")
EspLabel.Name = "esp"
EspLabel.Parent = ScrollingFrame
EspLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EspLabel.BackgroundTransparency = 1
EspLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
EspLabel.BorderSizePixel = 0
EspLabel.Position = UDim2.new(0.0542302355, 0, 0.182, 0)
EspLabel.Size = UDim2.new(0, 200, 0, 18)
EspLabel.Font = Enum.Font.SourceSans
EspLabel.Text = "Titan ESP"
EspLabel.TextColor3 = Color3.fromRGB(148, 148, 148)
EspLabel.TextSize = 23
EspLabel.TextWrapped = true

local TpButtonE = Instance.new("TextButton")
TpButtonE.Name = "tpButtonE"
TpButtonE.Parent = ScrollingFrame
TpButtonE.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
TpButtonE.BorderColor3 = Color3.fromRGB(0, 0, 0)
TpButtonE.BorderSizePixel = 2
TpButtonE.Position = UDim2.new(0.7, 0, 0.185, 0)
TpButtonE.Size = UDim2.new(0, 30, 0, 30)
TpButtonE.Font = Enum.Font.SourceSans
TpButtonE.Text = ""
TpButtonE.TextColor3 = Color3.fromRGB(0, 0, 0)
TpButtonE.TextSize = 14

-- المتغيرات البرمجية
local NapeLocation
local NapeLocation2
local TeleportEnabled = false
local TitanFarmerEnabled = false
local MaxDistance = 1250
local MaxTeleportDistance = math.huge
local ESPEnabled = false
local Highlights = {}

-- دالة للحصول على موقع اللاعب
local function GetPlayerPosition()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local Position = HumanoidRootPart.Position
        print("HumanoidRootPart Location:", Position)
        return Position
    else
        warn("HumanoidRootPart not found for LocalPlayer.")
        return nil
    end
end

-- دالة للعثور على أقرب Nape
local function FindClosestNape()
    local TitansFolder = Workspace:FindFirstChild("Titans")
    local ClosestNape = nil
    local MinDistance = math.huge

    if TitansFolder then
        local PlayerPosition = GetPlayerPosition()
        if not PlayerPosition then return nil end

        for _, Titan in ipairs(TitansFolder:GetChildren()) do
            if Titan:IsA("Model") and Titan:FindFirstChildOfClass("Humanoid") then
                local Hitboxes = Titan:FindFirstChild("Hitboxes")
                if Hitboxes then
                    local Hit = Hitboxes:FindFirstChild("Hit")
                    if Hit then
                        local Nape = Hit:FindFirstChild("Nape")
                        if Nape then
                            local Distance = (Nape.Position - PlayerPosition).Magnitude
                            if Distance < MinDistance and Distance <= MaxTeleportDistance then
                                MinDistance = Distance
                                ClosestNape = Nape
                            end
                        end
                    end
                end
            end
        end
    else
        warn("Titans folder not found in Workspace.")
    end

    if ClosestNape then
        NapeLocation = ClosestNape
        print("Closest NapeLocation set to:", NapeLocation.Position)
    else
        warn("No Nape part found within maximum teleport distance.")
    end
    return NapeLocation
end

-- دالة للتنقل المستمر إلى Nape
local function TeleportToNape()
    if NapeLocation then
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            local BodyPosition = Instance.new("BodyPosition")
            BodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            BodyPosition.Position = NapeLocation.Position + Vector3.new(0, 450, 0)
            BodyPosition.Parent = HumanoidRootPart

            local BodyGyro = Instance.new("BodyGyro")
            BodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            BodyGyro.CFrame = HumanoidRootPart.CFrame
            BodyGyro.Parent = HumanoidRootPart

            return BodyPosition, BodyGyro
        else
            warn("HumanoidRootPart not found.")
            return nil, nil
        end
    end
end

-- دالة لتدمير BodyPosition وBodyGyro
local function DestroyBodyControllers(BodyPosition, BodyGyro)
    if BodyPosition then BodyPosition:Destroy() end
    if BodyGyro then BodyGyro:Destroy() end
end

-- دالة للتنقل السريع عند النقر
local function QuickTeleport()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart then
        local StartPosition = HumanoidRootPart.Position
        local function SetPosition(Position)
            HumanoidRootPart.CFrame = CFrame.new(Position)
        end

        FindClosestNape()
        if NapeLocation then
            local NapePosition = NapeLocation.Position
            local Step = (NapePosition - StartPosition) / 4
            local AdjustedStep = Step * 3
            for i = 1, 2 do
                SetPosition(StartPosition + AdjustedStep)
                wait(0.001)
                SetPosition(NapePosition)
                for _ = 1, 4 do
                    SetPosition(NapePosition)
                end
            end
        end
    end
end

-- دالة لتبديل التنقل المستمر
local function ToggleTeleport()
    TeleportEnabled = not TeleportEnabled
    if TeleportEnabled then
        print("Teleportation Enabled")
        FindClosestNape()
        local BodyPosition, BodyGyro = TeleportToNape()
        spawn(function()
            while TeleportEnabled do
                wait(1)
                FindClosestNape()
                if BodyPosition and BodyGyro and NapeLocation then
                    BodyPosition.Position = NapeLocation.Position + Vector3.new(0, 300, 0)
                    BodyGyro.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
            DestroyBodyControllers(BodyPosition, BodyGyro)
        end)
    else
        print("Teleportation Disabled")
    end
end

TpButtonF.MouseButton1Click:Connect(function()
    ToggleTeleport()
    TpButtonF.BackgroundColor3 = TeleportEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
end)

UserInputService.InputEnded:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and TeleportEnabled then
        QuickTeleport()
    end
end)

-- دالة لإبراز Titans (ESP)
local function CreateHighlight(Model, Color, Transparency)
    if not Model:FindFirstChildOfClass("Highlight") then
        local Highlight = Instance.new("Highlight")
        Highlight.Adornee = Model
        Highlight.FillTransparency = Transparency or 0.5
        Highlight.FillColor = Color or Color3.new(1, 1, 1)
        Highlight.OutlineTransparency = Transparency or 0
        Highlight.OutlineColor = Color or Color3.new(1, 1, 1)
        Highlight.Enabled = ESPEnabled
        Highlight.Parent = Model
        table.insert(Highlights, Highlight)
        print("Highlight created for model: " .. Model.Name)
    else
        print("Highlight already exists for model: " .. Model.Name)
    end
end

local function HighlightTitanParts(Model)
    local Parts = {"LowerTorso", "LeftUpperArm", "RightUpperLeg", "LeftLowerLeg", "LeftUpperLeg", "RightLowerLeg", "LeftFoot", "RightLowerArm", "UpperTorso", "LeftLowerArm", "RightUpperArm", "LeftHand", "RightFoot", "RightHand", "Head"}
    for _, PartName in ipairs(Parts) do
        local Part = Model:FindFirstChild(PartName)
        if Part and Part:IsA("BasePart") then
            CreateHighlight(Part.Parent, Color3.new(1, 1, 1), 0.65)
        else
            print("Part not found or not a BasePart: " .. PartName)
        end
    end
end

local function ApplyESP()
    local TitansFolder = Workspace:FindFirstChild("Titans")
    if TitansFolder then
        for _, Titan in ipairs(TitansFolder:GetChildren()) do
            if Titan:IsA("Model") and Titan:FindFirstChildOfClass("Humanoid") then
                local Fake = Titan:FindFirstChild("Fake")
                if Fake then
                    print("Highlighting model: " .. Titan.Name)
                    HighlightTitanParts(Fake)
                else
                    print("No Fake model found in: " .. Titan.Name)
                end
            else
                print("No Humanoid found in: " .. Titan.Name)
            end
        end
    else
        warn("Titans folder not found in Workspace.")
    end
end

local function ToggleESP(Enable)
    ESPEnabled = Enable
    for _, Highlight in ipairs(Highlights) do
        if Highlight:IsA("Highlight") then
            Highlight.Enabled = ESPEnabled
        end
    end
    TpButtonE.BackgroundColor3 = ESPEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if not ESPEnabled then
        for _, Highlight in ipairs(Highlights) do
            Highlight:Destroy()
        end
        Highlights = {}
    else
        ApplyESP()
    end
end

TpButtonE.MouseButton1Click:Connect(function()
    ToggleESP(not ESPEnabled)
end)

ApplyESP()

-- دالة للتنقل إلى Nape (Titan Farmer)
local function FindClosestNapeForFarmer()
    local TitansFolder = Workspace:FindFirstChild("Titans")
    local ClosestNape = nil
    local MinDistance = math.huge

    if TitansFolder then
        local PlayerPosition = GetPlayerPosition()
        if not PlayerPosition then return nil end

        for _, Titan in ipairs(TitansFolder:GetChildren()) do
            if Titan:IsA("Model") and Titan:FindFirstChildOfClass("Humanoid") then
                local Hitboxes = Titan:FindFirstChild("Hitboxes")
                if Hitboxes then
                    local Hit = Hitboxes:FindFirstChild("Hit")
                    if Hit then
                        local Nape = Hit:FindFirstChild("Nape")
                        if Nape then
                            local Distance = (Nape.Position - PlayerPosition).Magnitude
                            if Distance < MinDistance and Distance <= MaxDistance then
                                MinDistance = Distance
                                ClosestNape = Nape.CFrame
                            end
                        end
                    end
                end
            end
        end
    else
        warn("Titans folder not found in Workspace.")
    end

    if ClosestNape then
        NapeLocation2 = ClosestNape
        print("Closest NapeLocation2 set to:", NapeLocation2)
    else
        warn("No Nape part found within maximum teleport distance.")
    end
    return NapeLocation2
end

local function ToggleTitanFarmer()
    TitanFarmerEnabled = not TitanFarmerEnabled
    local Status = TitanFarmerEnabled and "Teleport Enabled (Bypass status is unknown)" or "Teleport Disabled (Bypass status is unknown)"
    print("Nape Teleportation Toggled: " .. Status)
    return Status
end

local function TitanFarmerTeleport()
    if TitanFarmerEnabled then
        FindClosestNapeForFarmer()
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart and NapeLocation2 then
            local OriginalCFrame = HumanoidRootPart.CFrame
            HumanoidRootPart.CFrame = NapeLocation2
            delay(0.01, function()
                HumanoidRootPart.Velocity = Vector3.new(300, 10, 0)
            end)
            delay(0.35, function()
                HumanoidRootPart.CFrame = OriginalCFrame
                NapeLocation2 = nil
                print("NapeLocation reset to nil")
            end)
        end
    end
end

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and TitanFarmerEnabled then
        TitanFarmerTeleport()
    end
end)

TpButton.MouseButton1Click:Connect(function()
    local Status = ToggleTitanFarmer()
    TpButton.BackgroundColor3 = TitanFarmerEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
end)

-- دالة التنقل إلى GasTank
local GasTank = Workspace:FindFirstChild("Unclimbable") and Workspace.Unclimbable:FindFirstChild("Reloads") and Workspace.Unclimbable.Reloads:FindFirstChild("GasTanks") and Workspace.Unclimbable.Reloads.GasTanks:FindFirstChild("GasTank") and Workspace.Unclimbable.Reloads.GasTanks.GasTank:FindFirstChild("GasTank")

local function TeleportToGasTank()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if GasTank and HumanoidRootPart then
        HumanoidRootPart.CFrame = GasTank.CFrame + Vector3.new(0, 25, 0)
    else
        warn("GasTank not found in Workspace.")
    end
end

RefillButton.MouseButton1Click:Connect(TeleportToGasTank)

-- دالة لإخفاء/إظهار الواجهة
local function ToggleGuiVisibility()
    if Frame.Visible then
        Frame.Visible = false
        wait(0.35)
    else
        Frame.Visible = true
        wait(0.35)
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        ToggleGuiVisibility()
    end
end)
