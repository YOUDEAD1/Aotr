-- إعداد المتغيرات الأساسية
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
local AutoClickEnabled = false -- للتحكم في الضغط التلقائي
local MaxDistance = 1250
local MaxTeleportDistance = 5000
local ESPEnabled = false
local Highlights = {}
local ExpandedHitboxes = {}
local FloatingEnabled = false -- للتحكم في الطفو في الجو

-- الحصول على السيف النشط من يد اللاعب
local function GetActiveBlade()
    local character = LocalPlayer.Character
    if character then
        local rig = character:FindFirstChild("Rig_BOHDAID")
        if rig then
            local leftHand = rig:FindFirstChild("LeftHand")
            if leftHand then
                for i = 1, 7 do
                    local blade = leftHand:FindFirstChild("Blade_" .. i)
                    if blade then
                        return blade
                    end
                end
            end
            local rightHand = rig:FindFirstChild("RightHand")
            if rightHand then
                for i = 1, 7 do
                    local blade = rightHand:FindFirstChild("Blade_" .. i)
                    if blade then
                        return blade
                    end
                end
            end
        end
    end
    warn("No active blade found for player.")
    return nil
end

-- دالة للعثور على Nape
local function FindNape(hitFolder)
    return hitFolder:FindFirstChild("Nape")
end

-- دالة لمحاكاة الضغط التلقائي على زر الماوس الأيسر
local function SimulateLeftClick()
    if TeleportEnabled or TitanFarmerEnabled then
        QuickTeleport()
    end
end

-- حلقة للضغط التلقائي
local function StartAutoClick()
    spawn(function()
        while AutoClickEnabled do
            SimulateLeftClick()
            wait(0.5) -- التأخير بين كل ضغطة (0.5 ثانية)
        end
    end)
end

-- دالة لمحاكاة الضربة على Nape وتسجيل القتل
local function SimulateHit(napeObject, hitter)
    -- التأكد من وجود Nape والسيف
    if not napeObject or not hitter then
        warn("Nape or hitter not found.")
        return
    end

    -- العثور على الـ Titan الأب
    local titan = napeObject
    while titan and titan.Parent ~= Workspace.Titans do
        titan = titan.Parent
    end
    if not titan then
        warn("Could not find Titan parent.")
        return
    end

    -- العثور على Remote Events
    local strikeEvent = ReplicatedStorage.Assets.Hitboxes:FindFirstChild("TorrentialSteel")
    local strikeEventFallback = ReplicatedStorage.Assets.Hitboxes:FindFirstChild("RisingSlash")

    -- تسجيل الضربة باستخدام TorrentialSteel أو RisingSlash
    if strikeEvent and strikeEvent:IsA("RemoteEvent") then
        strikeEvent:FireServer(napeObject, hitter)
        print("Strike registered on Nape using TorrentialSteel.")
    elseif strikeEventFallback and strikeEventFallback:IsA("RemoteEvent") then
        strikeEventFallback:FireServer(napeObject, hitter)
        print("Strike registered on Nape using RisingSlash.")
    else
        warn("TorrentialSteel and RisingSlash RemoteEvents not found or not RemoteEvents.")
    end

    -- تطبيق الضرر مباشرة على Humanoid الخاص بـ Titan كبديل
    local humanoid = titan:FindFirstChildOfClass("Humanoid")
    if humanoid then
        for i = 1, 5 do
            humanoid:TakeDamage(2000) -- زيادة الضرر إلى 2000 لكل ضربة (إجمالي 10000)
            wait(0.1)
        end
        print("Applied 10000 total damage to Titan Humanoid as fallback.")
    else
        warn("Could not find Humanoid to apply damage.")
    end
end

-- دالة لتوسيع منطقة التصادم (Hitbox) لـ Nape مع ربط الضربات
local function ExpandNapeHitbox(hitFolder)
    local napeObject = FindNape(hitFolder)
    if napeObject then
        -- إنشاء جزء وهمي (Hitbox موسع)
        local expandedHitbox = Instance.new("Part")
        expandedHitbox.Name = "ExpandedNapeHitbox"
        expandedHitbox.Size = Vector3.new(105 * 2, 120 * 2, 100 * 2) -- مضاعفة الحجم إلى 210x240x200
        expandedHitbox.Transparency = 1
        expandedHitbox.Position = napeObject.Position
        expandedHitbox.Anchored = false
        expandedHitbox.CanCollide = false
        expandedHitbox.Parent = hitFolder

        -- ربط الجزء الموسع بـ Nape الأصلي باستخدام Weld
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = napeObject
        weld.Part1 = expandedHitbox
        weld.Parent = expandedHitbox

        -- نقل الضربات من الجزء الموسع إلى Nape الأصلي
        expandedHitbox.Touched:Connect(function(hit)
            local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid ~= napeObject.Parent:FindFirstChildOfClass("Humanoid") then
                local activeBlade = GetActiveBlade()
                if activeBlade then
                    SimulateHit(napeObject, activeBlade)
                else
                    warn("No active blade found to simulate hit.")
                end
            end
        end)

        table.insert(ExpandedHitboxes, expandedHitbox)
    end
end

-- دالة لمعالجة جميع Titans وتوسيع منطقة Nape
local function ProcessTitans(titansBasePart)
    for _, titan in ipairs(titansBasePart:GetChildren()) do
        local hitboxesFolder = titan:FindFirstChild("Hitboxes")
        if hitboxesFolder then
            local hitFolder = hitboxesFolder:FindFirstChild("Hit")
            if hitFolder then
                ExpandNapeHitbox(hitFolder)
            end
        end
    end
end

-- دالة للحصول على موقع اللاعب
local function GetPlayerPosition()
    local Character = LocalPlayer.Character
    if not Character then
        LocalPlayer.CharacterAdded:Wait()
        Character = LocalPlayer.Character
    end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") and Humanoid and Humanoid.Health > 0 then
        local Position = HumanoidRootPart.Position
        print("HumanoidRootPart Location:", Position)
        return Position
    else
        warn("HumanoidRootPart not found or player is dead.")
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

-- دالة لتفعيل الطفو في الجو
local function EnableFloating()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FloatingVelocity"
        bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0) -- يبقي اللاعب في الجو
        bodyVelocity.Parent = HumanoidRootPart
        FloatingEnabled = true
        print("Floating enabled.")
    end
end

-- دالة لإلغاء الطفو
local function DisableFloating()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart then
        local bodyVelocity = HumanoidRootPart:FindFirstChild("FloatingVelocity")
        if bodyVelocity then
            bodyVelocity:Destroy()
            FloatingEnabled = false
            print("Floating disabled.")
        end
    end
end

-- دالة للتنقل المستمر إلى Nape
local function TeleportToNape()
    if NapeLocation then
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if HumanoidRootPart and Humanoid and Humanoid.Health > 0 then
            local NapePosition = NapeLocation.Position + Vector3.new(0, 50, 0)
            local ray = Ray.new(NapePosition, Vector3.new(0, -1000, 0))
            local hitPart, hitPosition = Workspace:FindPartOnRay(ray, Character)
            if hitPosition then
                NapePosition = hitPosition + Vector3.new(0, 50, 0) -- وضع اللاعب في الجو
            end

            HumanoidRootPart.CFrame = CFrame.new(NapePosition)

            -- تفعيل الطفو في الجو
            if not FloatingEnabled then
                EnableFloating()
            end

            wait(0.5) -- تأخير بسيط للسماح للعبة بالتحميل
        else
            warn("HumanoidRootPart not found or player is dead.")
        end
    end
end

-- دالة للتنقل السريع عند النقر
local function QuickTeleport()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if HumanoidRootPart and Humanoid and Humanoid.Health > 0 then
        local StartPosition = HumanoidRootPart.Position
        local function SetPosition(Position)
            HumanoidRootPart.CFrame = CFrame.new(Position)
        end

        FindClosestNape()
        if NapeLocation then
            local NapePosition = NapeLocation.Position + Vector3.new(0, 50, 0)
            local ray = Ray.new(NapePosition, Vector3.new(0, -1000, 0))
            local hitPart, hitPosition = Workspace:FindPartOnRay(ray, Character)
            if hitPosition then
                NapePosition = hitPosition + Vector3.new(0, 50, 0) -- وضع اللاعب في الجو
            end

            local Step = (NapePosition - StartPosition) / 4
            local AdjustedStep = Step * 3
            for i = 1, 2 do
                SetPosition(StartPosition + AdjustedStep)
                wait(0.01)
                SetPosition(NapePosition)
                for _ = 1, 4 do
                    SetPosition(NapePosition)
                end
            end

            -- تفعيل الطفو في الجو
            if not FloatingEnabled then
                EnableFloating()
            end

            wait(0.5) -- تأخير بسيط للسماح للعبة بالتحميل
        end
    end
end

-- دالة لتبديل التنقل المستمر
local function ToggleTeleport()
    TeleportEnabled = not TeleportEnabled
    AutoClickEnabled = TeleportEnabled -- تفعيل الضغط التلقائي مع التنقل
    if TeleportEnabled then
        print("Teleportation Enabled")
        StartAutoClick() -- بدء الضغط التلقائي
        spawn(function()
            while TeleportEnabled do
                FindClosestNape()
                if NapeLocation then
                    TeleportToNape()
                end
                wait(1)
            end
            -- إلغاء الطفو عند إيقاف التنقل
            DisableFloating()
        end)
    else
        print("Teleportation Disabled")
        DisableFloating()
    end
end

TpButtonF.MouseButton1Click:Connect(function()
    ToggleTeleport()
    TpButtonF.BackgroundColor3 = TeleportEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
end)

-- دالة لتبديل Titan Farmer مع الضغط التلقائي
local function ToggleTitanFarmer()
    TitanFarmerEnabled = not TitanFarmerEnabled
    AutoClickEnabled = TitanFarmerEnabled -- تفعيل الضغط التلقائي مع Titan Farmer
    local Status = TitanFarmerEnabled and "Teleport Enabled (Bypass status is unknown)" or "Teleport Disabled (Bypass status is unknown)"
    print("Nape Teleportation Toggled: " .. Status)
    if TitanFarmerEnabled then
        StartAutoClick() -- بدء الضغط التلقائي
    end
    return Status
end

local function TitanFarmerTeleport()
    if TitanFarmerEnabled then
        FindClosestNapeForFarmer()
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if HumanoidRootPart and Humanoid and Humanoid.Health > 0 and NapeLocation2 then
            HumanoidRootPart.CFrame = NapeLocation2
            delay(0.01, function()
                HumanoidRootPart.Velocity = Vector3.new(300, 10, 0)
            end)
            -- لا نعيد اللاعب إلى الموقع الأصلي، بل نتركه في الجو
            NapeLocation2 = nil
            print("NapeLocation reset to nil")

            -- تفعيل الطفو في الجو
            if not FloatingEnabled then
                EnableFloating()
            end

            wait(0.5) -- تأخير بسيط للسماح للعبة بالتحميل
        end
    end
end

TpButton.MouseButton1Click:Connect(function()
    local Status = ToggleTitanFarmer()
    TpButton.BackgroundColor3 = TitanFarmerEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
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

-- دالة التنقل إلى GasTank
local GasTank = Workspace:FindFirstChild("Unclimbable") and Workspace.Unclimbable:FindFirstChild("Reloads") and Workspace.Unclimbable.Reloads:FindFirstChild("GasTanks") and Workspace.Unclimbable.Reloads.GasTanks:FindFirstChild("GasTank") and Workspace.Unclimbable.Reloads.GasTanks.GasTank:FindFirstChild("GasTank")

local function TeleportToGasTank()
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if GasTank and HumanoidRootPart and Humanoid and Humanoid.Health > 0 then
        local GasPosition = GasTank.Position + Vector3.new(0, 25, 0)
        local ray = Ray.new(GasPosition, Vector3.new(0, -1000, 0))
        local hitPart, hitPosition = Workspace:FindPartOnRay(ray, Character)
        if hitPosition then
            GasPosition = hitPosition + Vector3.new(0, 25, 0) -- وضع اللاعب في الجو
        end

        HumanoidRootPart.CFrame = CFrame.new(GasPosition)

        -- تفعيل الطفو في الجو
        if not FloatingEnabled then
            EnableFloating()
        end

        wait(0.5) -- تأخير بسيط للسماح للعبة بالتحميل
    else
        warn("GasTank not found or player is dead.")
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

-- تشغيل توسيع Nape عند تحميل السكربت
print("Nape Expander Loaded")
local TitansBasePart = Workspace:FindFirstChild("Titans")
if TitansBasePart then
    ProcessTitans(TitansBasePart)
end
