local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- دالة للعثور على Nape
local function findNape(hitFolder)
    local nape = hitFolder:FindFirstChild("Nape")
    if nape then
        print("[DEBUG] Nape found in Hit folder")
    else
        print("[DEBUG] Nape not found in Hit folder")
    end
    return nape
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
        print("[DEBUG] Nape hitbox expanded")
    end
end

-- دالة لمعالجة العمالقة
local function processTitans(titansBasePart)
    if not titansBasePart then
        print("[DEBUG] Titans folder not found")
        return
    end
    for _, titan in pairs(titansBasePart:GetChildren()) do
        local hitboxesFolder = titan:FindFirstChild("Hitboxes")
        if hitboxesFolder then
            local hitFolder = hitboxesFolder:FindFirstChild("Hit")
            if hitFolder then
                expandNapeHitbox(hitFolder)
            else
                print("[DEBUG] Hit folder not found in " .. titan.Name)
            end
        else
            print("[DEBUG] Hitboxes folder not found in " .. titan.Name)
        end
    end
end

-- إنشاء واجهة المستخدم الرسومية (GUI)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local tpButton = Instance.new("TextButton") -- Nape Teleport
local tpButtonF = Instance.new("TextButton") -- Titan Farmer
local refillButton = Instance.new("TextButton") -- Tp to Refill
local tpButtonE = Instance.new("TextButton") -- Titan ESP
local closeButton = Instance.new("TextButton") -- زر X
local minimizeButton = Instance.new("TextButton") -- زر -
local maximizeButton = Instance.new("TextButton") -- زر +

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
print("[DEBUG] ScreenGui created and parented to PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.Position = UDim2.new(0.4, 0, 0.05, 0)
Frame.Size = UDim2.new(0, 250, 0, 200)
Frame.Draggable = true
Frame.Active = true
Frame.Visible = true
print("[DEBUG] Frame created and visible")

Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSans
Title.Text = "Tekkit AotR"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextSize = 20
Title.TextWrapped = true
print("[DEBUG] Title created")

tpButton.Parent = Frame
tpButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tpButton.Position = UDim2.new(0.1, 0, 0.2, 0)
tpButton.Size = UDim2.new(0.8, 0, 0, 30)
tpButton.Font = Enum.Font.SourceSans
tpButton.Text = "Nape Teleport (Auto Kill)"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextSize = 14
print("[DEBUG] Nape Teleport button created")

tpButtonF.Parent = Frame
tpButtonF.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tpButtonF.Position = UDim2.new(0.1, 0, 0.35, 0)
tpButtonF.Size = UDim2.new(0.8, 0, 0, 30)
tpButtonF.Font = Enum.Font.SourceSans
tpButtonF.Text = "Titan Farmer"
tpButtonF.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButtonF.TextSize = 14
print("[DEBUG] Titan Farmer button created")

refillButton.Parent = Frame
refillButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
refillButton.Position = UDim2.new(0.1, 0, 0.5, 0)
refillButton.Size = UDim2.new(0.8, 0, 0, 30)
refillButton.Font = Enum.Font.SourceSans
refillButton.Text = "Tp to Refill"
refillButton.TextColor3 = Color3.fromRGB(255, 255, 255)
refillButton.TextSize = 14
print("[DEBUG] Refill button created")

tpButtonE.Parent = Frame
tpButtonE.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tpButtonE.Position = UDim2.new(0.1, 0, 0.65, 0)
tpButtonE.Size = UDim2.new(0.8, 0, 0, 30)
tpButtonE.Font = Enum.Font.SourceSans
tpButtonE.Text = "Titan ESP"
tpButtonE.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButtonE.TextSize = 14
print("[DEBUG] Titan ESP button created")

closeButton.Parent = Frame
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Position = UDim2.new(0.85, 0, 0, 0)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
print("[DEBUG] Close button created")

minimizeButton.Parent = Frame
minimizeButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
minimizeButton.Position = UDim2.new(0.65, 0, 0, 0)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Font = Enum.Font.SourceSansBold
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 20
print("[DEBUG] Minimize button created")

maximizeButton.Parent = ScreenGui
maximizeButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
maximizeButton.Position = UDim2.new(0.4, 0, 0.05, 0)
maximizeButton.Size = UDim2.new(0, 30, 0, 30)
maximizeButton.Font = Enum.Font.SourceSansBold
maximizeButton.Text = "+"
maximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
maximizeButton.TextSize = 20
maximizeButton.Visible = false
print("[DEBUG] Maximize button created")

-- متغيرات التحكم
local NapeLocation
local TeleportEnabled = false
local TitanFarmerEnabled = false
local ESPEnabled = false
local MaxTeleportDistance = 1250
local Highlights = {}

-- دالة للعثور على أقرب Nape حي فقط
local function findClosestNape()
    local titansFolder = Workspace:FindFirstChild("Titans")
    if not titansFolder then
        print("[DEBUG] Titans folder not found in Workspace")
        return nil
    end
    local closestNape = nil
    local minDistance = math.huge
    local playerPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
    if not playerPos then
        print("[DEBUG] Player position not found")
        return nil
    end
    for _, titan in pairs(titansFolder:GetChildren()) do
        local humanoid = titan:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
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
    NapeLocation = closestNape
    if NapeLocation then
        print("[DEBUG] Closest living Nape found at " .. tostring(NapeLocation.Position))
    else
        print("[DEBUG] No living Nape found")
    end
    return NapeLocation
end

-- دالة لمحاكاة الهجوم
local function attackTitan()
    local character = LocalPlayer.Character
    if character then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool then
            -- محاكاة تفعيل الأداة للهجوم
            tool:Activate()
            print("[DEBUG] Tool activated for attack")
        else
            -- إذا لم يكن هناك أداة، محاكاة نقرة هجوم
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping) -- لمحاكاة حركة هجوم
                print("[DEBUG] Simulated attack via jump")
            end
        end
    end
end

-- دالة للنقل الآني مع الهجوم التلقائي
local function teleportAndKill()
    findClosestNape()
    if NapeLocation then
        local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = CFrame.new(NapeLocation.Position + Vector3.new(0, 10, 0))
            print("[DEBUG] Teleported to Nape")
            wait(0.1) -- تأخير بسيط لضمان استقرار الموقع
            attackTitan()
        else
            print("[DEBUG] HumanoidRootPart not found for teleport")
        end
    end
end

-- دالة للنقل الآني مع BodyPosition (Titan Farmer)
local function teleportToNape()
    findClosestNape()
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
            print("[DEBUG] BodyPosition and BodyGyro applied for Titan Farmer")
            return bodyPos, bodyGyro
        else
            print("[DEBUG] HumanoidRootPart not found for Titan Farmer")
        end
    end
    return nil, nil
end

-- دالة لإزالة BodyPosition وBodyGyro
local function removeBodyObjects(bodyPos, bodyGyro)
    if bodyPos then bodyPos:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    print("[DEBUG] Body objects removed")
end

-- تفعيل/تعطيل Titan Farmer
local function toggleTitanFarmer()
    TitanFarmerEnabled = not TitanFarmerEnabled
    tpButtonF.BackgroundColor3 = TitanFarmerEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if TitanFarmerEnabled then
        local bodyPos, bodyGyro = teleportToNape()
        spawn(function()
            while TitanFarmerEnabled and wait(1) do
                local currentTitan = NapeLocation and NapeLocation.Parent and NapeLocation.Parent.Parent and NapeLocation.Parent.Parent.Parent
                if currentTitan and currentTitan:FindFirstChildOfClass("Humanoid") and currentTitan:FindFirstChildOfClass("Humanoid").Health <= 0 then
                    removeBodyObjects(bodyPos, bodyGyro)
                    bodyPos, bodyGyro = teleportToNape()
                    wait(0.1)
                    attackTitan()
                elseif NapeLocation and bodyPos and bodyGyro then
                    bodyPos.Position = NapeLocation.Position + Vector3.new(0, 300, 0)
                    bodyGyro.CFrame = LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart and LocalPlayer.Character.HumanoidRootPart.CFrame
                    attackTitan()
                end
            end
            removeBodyObjects(bodyPos, bodyGyro)
        end)
        print("[DEBUG] Titan Farmer enabled")
    else
        print("[DEBUG] Titan Farmer disabled")
    end
end

-- دالة لإنشاء Highlight لـ ESP
local function createHighlight(model)
    if not model:FindFirstChildOfClass("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = model
        highlight.FillTransparency = 0.65
        highlight.FillColor = Color3.new(1, 1, 1)
        highlight.OutlineTransparency = 0
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.Enabled = ESPEnabled
        highlight.Parent = model
        table.insert(Highlights, highlight)
        print("[DEBUG] Highlight created for " .. model.Name)
    end
end

-- دالة لتطبيق ESP على العمالقة
local function applyESP()
    local titansFolder = Workspace:FindFirstChild("Titans")
    if titansFolder then
        for _, titan in pairs(titansFolder:GetChildren()) do
            local fake = titan:FindFirstChild("Fake")
            if fake then
                createHighlight(fake)
            end
        end
        print("[DEBUG] ESP applied to Titans")
    else
        print("[DEBUG] Titans folder not found for ESP")
    end
end

-- تفعيل/تعطيل ESP
local function toggleESP()
    ESPEnabled = not ESPEnabled
    tpButtonE.BackgroundColor3 = ESPEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if ESPEnabled then
        applyESP()
    else
        for _, highlight in pairs(Highlights) do
            highlight:Destroy()
        end
        Highlights = {}
        print("[DEBUG] ESP disabled and highlights removed")
    end
end

-- النقل إلى Refill
local function teleportToRefill()
    local gasTank = Workspace:FindFirstChild("Unclimbable") and Workspace.Unclimbable:FindFirstChild("Reloads") and Workspace.Unclimbable.Reloads:FindFirstChild("GasTanks") and Workspace.Unclimbable.Reloads.GasTanks:FindFirstChild("GasTank") and Workspace.Unclimbable.Reloads.GasTanks.GasTank:FindFirstChild("GasTank")
    if gasTank then
        local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = gasTank.CFrame + Vector3.new(0, 25, 0)
            print("[DEBUG] Teleported to Refill")
        else
            print("[DEBUG] HumanoidRootPart not found for Refill")
        end
    else
        print("[DEBUG] GasTank not found in Workspace")
    end
end

-- تفعيل/تعطيل النقل الآني مع الهجوم التلقائي
local function toggleTeleport()
    TeleportEnabled = not TeleportEnabled
    tpButton.BackgroundColor3 = TeleportEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if TeleportEnabled then
        spawn(function()
            while TeleportEnabled and wait(1) do
                teleportAndKill()
            end
        end)
        print("[DEBUG] Nape Teleport with Auto Kill enabled")
    else
        print("[DEBUG] Nape Teleport with Auto Kill disabled")
    end
end

-- دالة لإخفاء/إظهار الواجهة
local function toggleFrameVisibility()
    if Frame.Visible then
        Frame.Visible = false
        maximizeButton.Visible = true
        print("[DEBUG] Frame hidden")
    else
        Frame.Visible = true
        maximizeButton.Visible = false
        print("[DEBUG] Frame shown")
    end
end

-- دالة لإزالة السكريبت
local function removeScript()
    ScreenGui:Destroy()
    print("[DEBUG] Script removed")
end

-- تشغيل توسيع Nape عند البدء
local function initialize()
    print("[DEBUG] Initializing Nape Expander")
    local titansBasePart = Workspace:FindFirstChild("Titans")
    if titansBasePart then
        processTitans(titansBasePart)
    else
        print("[DEBUG] Titans not found at startup")
    end
    Workspace.ChildAdded:Connect(function(child)
        if child.Name == "Titans" then
            processTitans(child)
            print("[DEBUG] Titans folder added, processing")
        end
    end)
end

-- ربط الأحداث
tpButton.MouseButton1Click:Connect(toggleTeleport)
tpButtonF.MouseButton1Click:Connect(toggleTitanFarmer)
refillButton.MouseButton1Click:Connect(teleportToRefill)
tpButtonE.MouseButton1Click:Connect(toggleESP)
closeButton.MouseButton1Click:Connect(removeScript)
minimizeButton.MouseButton1Click:Connect(toggleFrameVisibility)
maximizeButton.MouseButton1Click:Connect(toggleFrameVisibility)

-- البدء
initialize()
