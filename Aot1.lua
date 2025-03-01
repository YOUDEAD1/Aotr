local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
        napeObject.Transparency = 0.5 -- جعلها مرئية (Nape Visible Titan Ripper)
        napeObject.Color = Color3.fromRGB(255, 0, 0) -- لون أحمر مميز
        napeObject.Material = Enum.Material.Neon
        napeObject.CanCollide = false
        napeObject.Anchored = false
        print("[DEBUG] Nape hitbox expanded")
    end
end

-- دالة لتوسيع النقطة الضعيفة لإيرين (Extend Eren Weakpoint)
local function extendErenWeakpoint()
    local eren = Workspace:FindFirstChild("Eren") -- افتراض أن اسم العملاق هو "Eren"
    if eren then
        local hitboxes = eren:FindFirstChild("Hitboxes")
        if hitboxes then
            local hit = hitboxes:FindFirstChild("Hit")
            if hit then
                expandNapeHitbox(hit)
                print("[DEBUG] Eren weakpoint extended")
            end
        end
    end
end

-- دالة لمعالجة العمالقة (Nape Extend)
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
local tpButton = Instance.new("TextButton")
local tpButtonF = Instance.new("TextButton")
local opAutoFarmButton = Instance.new("TextButton")
local wipAutoFarmButton = Instance.new("TextButton")
local autoRefillButton = Instance.new("TextButton")
local antiInjuryButton = Instance.new("TextButton")
local tpButtonE = Instance.new("TextButton")
local closeButton = Instance.new("TextButton")
local minimizeButton = Instance.new("TextButton")
local maximizeButton = Instance.new("TextButton")

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
print("[DEBUG] ScreenGui created and parented to PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.Position = UDim2.new(0.4, 0, 0.05, 0)
Frame.Size = UDim2.new(0, 250, 0, 350)
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
tpButton.Position = UDim2.new(0.1, 0, 0.1, 0)
tpButton.Size = UDim2.new(0.8, 0, 0, 30)
tpButton.Font = Enum.Font.SourceSans
tpButton.Text = "Nape Teleport (Auto Kill)"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextSize = 14
print("[DEBUG] Nape Teleport button created")

tpButtonF.Parent = Frame
tpButtonF.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tpButtonF.Position = UDim2.new(0.1, 0, 0.2, 0)
tpButtonF.Size = UDim2.new(0.8, 0, 0, 30)
tpButtonF.Font = Enum.Font.SourceSans
tpButtonF.Text = "Titan Farmer"
tpButtonF.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButtonF.TextSize = 14
print("[DEBUG] Titan Farmer button created")

opAutoFarmButton.Parent = Frame
opAutoFarmButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
opAutoFarmButton.Position = UDim2.new(0.1, 0, 0.3, 0)
opAutoFarmButton.Size = UDim2.new(0.8, 0, 0, 30)
opAutoFarmButton.Font = Enum.Font.SourceSans
opAutoFarmButton.Text = "OP Auto Farm"
opAutoFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
opAutoFarmButton.TextSize = 14
print("[DEBUG] OP Auto Farm button created")

wipAutoFarmButton.Parent = Frame
wipAutoFarmButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
wipAutoFarmButton.Position = UDim2.new(0.1, 0, 0.4, 0)
wipAutoFarmButton.Size = UDim2.new(0.8, 0, 0, 30)
wipAutoFarmButton.Font = Enum.Font.SourceSans
wipAutoFarmButton.Text = "WIP Auto Farm"
wipAutoFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
wipAutoFarmButton.TextSize = 14
print("[DEBUG] WIP Auto Farm button created")

autoRefillButton.Parent = Frame
autoRefillButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
autoRefillButton.Position = UDim2.new(0.1, 0, 0.5, 0)
autoRefillButton.Size = UDim2.new(0.8, 0, 0, 30)
autoRefillButton.Font = Enum.Font.SourceSans
autoRefillButton.Text = "Auto Grab Blade Refill"
autoRefillButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoRefillButton.TextSize = 14
print("[DEBUG] Auto Refill button created")

antiInjuryButton.Parent = Frame
antiInjuryButton.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
antiInjuryButton.Position = UDim2.new(0.1, 0, 0.6, 0)
antiInjuryButton.Size = UDim2.new(0.8, 0, 0, 30)
antiInjuryButton.Font = Enum.Font.SourceSans
antiInjuryButton.Text = "Anti-Injury"
antiInjuryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
antiInjuryButton.TextSize = 14
print("[DEBUG] Anti-Injury button created")

tpButtonE.Parent = Frame
tpButtonE.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
tpButtonE.Position = UDim2.new(0.1, 0, 0.7, 0)
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
local OPAutoFarmEnabled = false
local WIPAutoFarmEnabled = false
local AutoRefillEnabled = false
local AntiInjuryEnabled = false
local ESPEnabled = false
local MaxTeleportDistance = 150 -- تقليل المسافة لتجنب النقل إلى آخر الخريطة
local SafePosition = Vector3.new(0, 50, 0) -- موقع آمن (يمكن تعديله)

local Highlights = {}

-- دالة للتحقق من جاهزية اللاعب
local function isPlayerReady()
    local character = LocalPlayer.Character
    if not character then
        print("[DEBUG] Character not found")
        return false
    end
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart or humanoid.Health <= 0 then
        print("[DEBUG] Humanoid or HumanoidRootPart not found or player dead")
        return false
    end
    print("[DEBUG] Player ready to teleport")
    return true
end

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
                    else
                        print("[DEBUG] Nape not found in Hit folder for " .. titan.Name)
                    end
                else
                    print("[DEBUG] Hit folder not found for " .. titan.Name)
                end
            else
                print("[DEBUG] Hitboxes folder not found for " .. titan.Name)
            end
        else
            print("[DEBUG] No humanoid or titan dead: " .. titan.Name)
        end
    end
    NapeLocation = closestNape
    if NapeLocation then
        print("[DEBUG] Closest living Nape found at " .. tostring(NapeLocation.Position))
    else
        print("[DEBUG] No living Nape found within range")
    end
    return NapeLocation
end

-- دالة لمحاكاة الهجوم (مع Nape Multi - مضاعفة الضرر)
local function attackTitan()
    local character = LocalPlayer.Character
    if not character then
        print("[DEBUG] Character not found for attack")
        return
    end
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then
        print("[DEBUG] Humanoid or HumanoidRootPart not found for attack")
        return
    end

    if NapeLocation then
        local startPos = rootPart.Position
        local endPos = NapeLocation.Position
        for i = 0, 1, 0.1 do
            rootPart.CFrame = CFrame.new(startPos:Lerp(endPos, i)) * CFrame.lookAt(rootPart.Position, NapeLocation.Position)
            wait(0.05)
        end
        local tool = character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
            print("[DEBUG] ODM Gear activated for attack")
            wait(0.5)
            humanoid.WalkSpeed = 100
            rootPart.Velocity = (NapeLocation.Position - rootPart.Position).Unit * 50
            wait(0.3)
            humanoid.WalkSpeed = 16
            -- مضاعفة الضرر (Nape Multi)
            if NapeLocation.Parent then
                local titanHumanoid = NapeLocation.Parent.Parent.Parent:FindFirstChildOfClass("Humanoid")
                if titanHumanoid then
                    titanHumanoid:TakeDamage(titanHumanoid.MaxHealth * 0.5) -- 50% ضرر إضافي
                    print("[DEBUG] Nape Multi applied")
                end
            end
        else
            print("[DEBUG] No ODM Gear found, attempting movement attack")
            humanoid.WalkSpeed = 100
            rootPart.Velocity = (NapeLocation.Position - rootPart.Position).Unit * 50
            wait(0.5)
            humanoid.WalkSpeed = 16
        end
    else
        print("[DEBUG] No Nape to attack")
    end
end

-- دالة لإعادة اللاعب إلى موقع آمن
local function resetPlayerPosition()
    local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        rootPart.CFrame = CFrame.new(SafePosition)
        print("[DEBUG] Player reset to safe position: " .. tostring(SafePosition))
    else
        print("[DEBUG] HumanoidRootPart not found for reset")
    end
end

-- دالة للنقل الآني مع الهجوم التلقائي
local function teleportAndKill()
    local success, err = pcall(function()
        if isPlayerReady() then
            findClosestNape()
            if NapeLocation then
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    rootPart.CFrame = CFrame.new(NapeLocation.Position + Vector3.new(0, 2, 0)) * CFrame.lookAt(rootPart.Position, NapeLocation.Position)
                    print("[DEBUG] Teleported to Nape")
                    wait(0.2)
                    attackTitan()
                    wait(0.5)
                else
                    print("[DEBUG] HumanoidRootPart not found for teleport")
                end
            else
                print("[DEBUG] No Nape found, resetting player position")
                resetPlayerPosition()
                wait(2)
            end
        else
            print("[DEBUG] Player not ready (missing components or dead), pausing teleport")
        end
    end)
    if not success then
        print("[DEBUG] Error in teleportAndKill: " .. err)
    end
end

-- دالة للنقل الآني مع BodyPosition (Titan Farmer و OP Auto Farm)
local function teleportToNape()
    local success, err = pcall(function()
        if isPlayerReady() then
            findClosestNape()
            if NapeLocation then
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local bodyPos = Instance.new("BodyPosition")
                    bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bodyPos.Position = NapeLocation.Position + Vector3.new(0, 5, 0)
                    bodyPos.Parent = rootPart
                    local bodyGyro = Instance.new("BodyGyro")
                    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                    bodyGyro.CFrame = CFrame.lookAt(rootPart.Position, NapeLocation.Position)
                    bodyGyro.Parent = rootPart
                    print("[DEBUG] BodyPosition and BodyGyro applied for Titan Farmer")
                    return bodyPos, bodyGyro
                else
                    print("[DEBUG] HumanoidRootPart not found for Titan Farmer")
                end
            end
        else
            print("[DEBUG] Player not ready, skipping Titan Farmer teleport")
        end
    end)
    if not success then
        print("[DEBUG] Error in teleportToNape: " .. err)
        return nil, nil
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
            while TitanFarmerEnabled do
                local success, err = pcall(function()
                    if isPlayerReady() then
                        local currentTitan = NapeLocation and NapeLocation.Parent and NapeLocation.Parent.Parent and NapeLocation.Parent.Parent.Parent
                        if not currentTitan or not currentTitan:FindFirstChildOfClass("Humanoid") or currentTitan:FindFirstChildOfClass("Humanoid").Health <= 0 then
                            removeBodyObjects(bodyPos, bodyGyro)
                            wait(0.1)
                            findClosestNape()
                            if NapeLocation then
                                bodyPos, bodyGyro = teleportToNape()
                                if NapeLocation then
                                    wait(0.2)
                                    attackTitan()
                                end
                            else
                                print("[DEBUG] No Nape found, resetting player position")
                                resetPlayerPosition()
                            end
                        elseif NapeLocation and bodyPos and bodyGyro then
                            bodyPos.Position = NapeLocation.Position + Vector3.new(0, 5, 0)
                            bodyGyro.CFrame = CFrame.lookAt(bodyPos.Position, NapeLocation.Position)
                            attackTitan()
                        else
                            print("[DEBUG] No Nape found, waiting for new titan")
                        end
                    else
                        print("[DEBUG] Player not ready, pausing Titan Farmer")
                    end
                end)
                if not success then
                    print("[DEBUG] Error in Titan Farmer loop: " .. err)
                    removeBodyObjects(bodyPos, bodyGyro)
                    bodyPos, bodyGyro = teleportToNape()
                end
                wait(1)
            end
            removeBodyObjects(bodyPos, bodyGyro)
        end)
        print("[DEBUG] Titan Farmer enabled")
    else
        print("[DEBUG] Titan Farmer disabled")
    end
end

-- تفعيل/تعطيل OP Auto Farm
local function toggleOPAutoFarm()
    OPAutoFarmEnabled = not OPAutoFarmEnabled
    opAutoFarmButton.BackgroundColor3 = OPAutoFarmEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if OPAutoFarmEnabled then
        local bodyPos, bodyGyro = teleportToNape()
        spawn(function()
            while OPAutoFarmEnabled do
                local success, err = pcall(function()
                    if isPlayerReady() then
                        local currentTitan = NapeLocation and NapeLocation.Parent and NapeLocation.Parent.Parent and NapeLocation.Parent.Parent.Parent
                        if not currentTitan or not currentTitan:FindFirstChildOfClass("Humanoid") or currentTitan:FindFirstChildOfClass("Humanoid").Health <= 0 then
                            removeBodyObjects(bodyPos, bodyGyro)
                            wait(0.1)
                            findClosestNape()
                            if NapeLocation then
                                bodyPos, bodyGyro = teleportToNape()
                                if NapeLocation then
                                    wait(0.2)
                                    attackTitan()
                                end
                            else
                                print("[DEBUG] No Nape found, resetting player position")
                                resetPlayerPosition()
                            end
                        elseif NapeLocation and bodyPos and bodyGyro then
                            bodyPos.Position = NapeLocation.Position + Vector3.new(0, 5, 0)
                            bodyGyro.CFrame = CFrame.lookAt(bodyPos.Position, NapeLocation.Position)
                            attackTitan()
                        else
                            print("[DEBUG] No Nape found, waiting for new titan")
                        end
                    else
                        print("[DEBUG] Player not ready, pausing OP Auto Farm")
                    end
                end)
                if not success then
                    print("[DEBUG] Error in OP Auto Farm loop: " .. err)
                    removeBodyObjects(bodyPos, bodyGyro)
                    bodyPos, bodyGyro = teleportToNape()
                end
                wait(0.5) -- سرعة أكبر لـ OP Auto Farm
            end
            removeBodyObjects(bodyPos, bodyGyro)
        end)
        print("[DEBUG] OP Auto Farm enabled")
    else
        print("[DEBUG] OP Auto Farm disabled")
    end
end

-- تفعيل/تعطيل WIP Auto Farm
local function toggleWIPAutoFarm()
    WIPAutoFarmEnabled = not WIPAutoFarmEnabled
    wipAutoFarmButton.BackgroundColor3 = WIPAutoFarmEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if WIPAutoFarmEnabled then
        local bodyPos, bodyGyro = teleportToNape()
        spawn(function()
            while WIPAutoFarmEnabled do
                local success, err = pcall(function()
                    if isPlayerReady() then
                        local currentTitan = NapeLocation and NapeLocation.Parent and NapeLocation.Parent.Parent and NapeLocation.Parent.Parent.Parent
                        if not currentTitan or not currentTitan:FindFirstChildOfClass("Humanoid") or currentTitan:FindFirstChildOfClass("Humanoid").Health <= 0 then
                            removeBodyObjects(bodyPos, bodyGyro)
                            wait(0.1)
                            findClosestNape()
                            if NapeLocation then
                                bodyPos, bodyGyro = teleportToNape()
                                if NapeLocation then
                                    wait(0.2)
                                    attackTitan()
                                end
                            else
                                print("[DEBUG] No Nape found, resetting player position")
                                resetPlayerPosition()
                            end
                        elseif NapeLocation and bodyPos and bodyGyro then
                            bodyPos.Position = NapeLocation.Position + Vector3.new(0, 5, 0)
                            bodyGyro.CFrame = CFrame.lookAt(bodyPos.Position, NapeLocation.Position)
                            attackTitan()
                        else
                            print("[DEBUG] No Nape found, waiting for new titan")
                        end
                    else
                        print("[DEBUG] Player not ready, pausing WIP Auto Farm")
                    end
                end)
                if not success then
                    print("[DEBUG] Error in WIP Auto Farm loop: " .. err)
                    removeBodyObjects(bodyPos, bodyGyro)
                    bodyPos, bodyGyro = teleportToNape()
                end
                wait(1)
            end
            removeBodyObjects(bodyPos, bodyGyro)
        end)
        print("[DEBUG] WIP Auto Farm enabled")
    else
        print("[DEBUG] WIP Auto Farm disabled")
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

-- النقل إلى Refill (Auto Grab Blade Refill)
local function teleportToRefill()
    local gasTank = Workspace:FindFirstChild("Unclimbable") and Workspace.Unclimbable:FindFirstChild("Reloads") and Workspace.Unclimbable.Reloads:FindFirstChild("GasTanks") and Workspace.Unclimbable.Reloads.GasTanks:FindFirstChild("GasTank") and Workspace.Unclimbable.Reloads.GasTanks.GasTank:FindFirstChild("GasTank")
    if gasTank then
        local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = CFrame.new(gasTank.Position + Vector3.new(0, 25, 0))
            print("[DEBUG] Teleported to Refill")
        else
            print("[DEBUG] HumanoidRootPart not found for Refill")
        end
    else
        print("[DEBUG] GasTank not found in Workspace")
    end
end

-- تفعيل/تعطيل Auto Grab Blade Refill
local function toggleAutoRefill()
    AutoRefillEnabled = not AutoRefillEnabled
    autoRefillButton.BackgroundColor3 = AutoRefillEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if AutoRefillEnabled then
        spawn(function()
            while AutoRefillEnabled do
                local character = LocalPlayer.Character
                if character then
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        -- افتراض أن هناك خاصية للتحقق من مستوى الشفرات
                        -- يمكن تعديل هذا بناءً على اللعبة
                        teleportToRefill()
                        wait(5) -- الانتظار قبل إعادة التعبئة
                    end
                end
                wait(10)
            end
        end)
        print("[DEBUG] Auto Refill enabled")
    else
        print("[DEBUG] Auto Refill disabled")
    end
end

-- تفعيل/تعطيل Anti-Injury
local function toggleAntiInjury()
    AntiInjuryEnabled = not AntiInjuryEnabled
    antiInjuryButton.BackgroundColor3 = AntiInjuryEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if AntiInjuryEnabled then
        spawn(function()
            while AntiInjuryEnabled do
                local character = LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = 100 -- زيادة السرعة لتجنب الإصابات
                        humanoid.JumpPower = 50
                        humanoid.MaxHealth = math.huge
                        humanoid.Health = math.huge
                        print("[DEBUG] Anti-Injury applied")
                    end
                end
                wait(1)
            end
        end)
        print("[DEBUG] Anti-Injury enabled")
    else
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16 -- إعادة السرعة الطبيعية
                humanoid.JumpPower = 50
                humanoid.MaxHealth = 100
                humanoid.Health = 100
            end
        end
        print("[DEBUG] Anti-Injury disabled")
    end
end

-- تفعيل/تعطيل النقل الآني مع الهجوم التلقائي
local function toggleTeleport()
    TeleportEnabled = not TeleportEnabled
    tpButton.BackgroundColor3 = TeleportEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    if TeleportEnabled then
        spawn(function()
            while TeleportEnabled do
                local success, err = pcall(function()
                    teleportAndKill()
                    if not NapeLocation or not isPlayerReady() then
                        print("[DEBUG] No living Nape or player not ready, pausing teleport")
                        wait(2)
                    end
                end)
                if not success then
                    print("[DEBUG] Error in Nape Teleport loop: " .. err)
                end
                wait(1.5)
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
    -- توسيع النقطة الضعيفة لإيرين
    extendErenWeakpoint()
end

-- ربط الأحداث
tpButton.MouseButton1Click:Connect(toggleTeleport)
tpButtonF.MouseButton1Click:Connect(toggleTitanFarmer)
opAutoFarmButton.MouseButton1Click:Connect(toggleOPAutoFarm)
wipAutoFarmButton.MouseButton1Click:Connect(toggleWIPAutoFarm)
autoRefillButton.MouseButton1Click:Connect(toggleAutoRefill)
antiInjuryButton.MouseButton1Click:Connect(toggleAntiInjury)
tpButtonE.MouseButton1Click:Connect(toggleESP)
closeButton.MouseButton1Click:Connect(removeScript)
minimizeButton.MouseButton1Click:Connect(toggleFrameVisibility)
maximizeButton.MouseButton1Click:Connect(toggleFrameVisibility)

-- البدء
initialize()
