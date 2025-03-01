
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
local tpButton = Instance.new("TextButton")
local closeButton = Instance.new("TextButton") -- زر X
local minimizeButton = Instance.new("TextButton") -- زر -
local maximizeButton = Instance.new("TextButton") -- زر +

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
print("[DEBUG] ScreenGui created and parented to PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.Position = UDim2.new(0.4, 0, 0.05, 0)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Draggable = true
Frame.Active = true
print("[DEBUG] Frame created")

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
tpButton.Position = UDim2.new(0.1, 0, 0.3, 0)
tpButton.Size = UDim2.new(0.8, 0, 0, 30)
tpButton.Font = Enum.Font.SourceSans
tpButton.Text = "Nape Teleport (Click to Toggle)"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextSize = 14
print("[DEBUG] Teleport button created")

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

-- دالة للعثور على أقرب Nape
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
        local hitboxes = titan:FindFirstChild("Hitboxes")
        if hitboxes then
            local hit = hitboxes:FindFirstChild("Hit")
            if hit then
                local nape = hit:FindFirstChild("Nape")
                if nape then
                    local distance = (nape.Position - playerPos).Magnitude
                    if distance < minDistance then
                        minDistance = distance
                        closestNape = nape
                    end
                end
            end
        end
    end
    NapeLocation = closestNape
    if NapeLocation then
        print("[DEBUG] Closest Nape found at " .. tostring(NapeLocation.Position))
    else
        print("[DEBUG] No Nape found")
    end
    return NapeLocation
end

-- دالة للنقل الآني
local function simpleTeleport()
    findClosestNape()
    if NapeLocation then
        local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = CFrame.new(NapeLocation.Position + Vector3.new(0, 10, 0))
            print("[DEBUG] Teleported to Nape")
        else
            print("[DEBUG] HumanoidRootPart not found for teleport")
        end
    end
end

-- تفعيل/تعطيل النقل الآني
local function toggleTeleport()
    TeleportEnabled = not TeleportEnabled
    tpButton.BackgroundColor3 = TeleportEnabled and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
    print("[DEBUG] Teleport Enabled: " .. tostring(TeleportEnabled))
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
closeButton.MouseButton1Click:Connect(removeScript)
minimizeButton.MouseButton1Click:Connect(toggleFrameVisibility)
maximizeButton.MouseButton1Click:Connect(toggleFrameVisibility)

-- النقل الآني عند النقر بزر الماوس الأيسر
local mouse = LocalPlayer:GetMouse()
mouse.Button1Down:Connect(function()
    if TeleportEnabled then
        simpleTeleport()
    end
end)

-- البدء
initialize()
