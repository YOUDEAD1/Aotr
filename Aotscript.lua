
print("AOTR Script Starting - Fully Enhanced - Grok @ xAI")

-- تحميل مكتبة Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("AOTR Auto-Farm", "DarkTheme")
local VIM = game:GetService("VirtualInputManager")
local workspace = game:GetService("Workspace")

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

-- إعداد واجهة GUI مع زر الإخفاء
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Controls")

-- زر الإخفاء بجانب X
local guiFrame = Window.MainFrame -- الوصول إلى الإطار الرئيسي لـ Kavo UI
local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(0, 30, 0, 30)
hideButton.Position = UDim2.new(1, -60, 0, 0) -- بجانب زر X
hideButton.Text = "-"
hideButton.Parent = guiFrame
hideButton.MouseButton1Click:Connect(function()
    guiFrame.Visible = not guiFrame.Visible
    hideButton.Text = guiFrame.Visible and "-" or "+"
end)

Section:NewToggle("Enable Auto-Farm", "Toggle auto-farming", function(state)
    autoFarmEnabled = state
    print("Auto-Farm " .. (state and "Enabled" or "Disabled"))
end)

Section:NewToggle("Enable Auto-Escape", "Toggle auto-escape", function(state)
    getgenv().autoescape = state
    print("Auto-Escape " .. (state and "Enabled" or "Disabled"))
end)

Section:NewToggle("Enable Auto-R (Blade Reload)", "Toggle auto blade reload", function(state)
    getgenv().autor = state
    print("Auto-R " .. (state and "Enabled" or "Disabled"))
end)

Section:NewToggle("Enable Nape Expander", "Expand titan nape hitbox", function(state)
    napeExpanderEnabled = state
    print("Nape Expander " .. (state and "Enabled" or "Disabled"))
end)

Section:NewToggle("Enable Titan Markers", "Show titan markers", function(state)
    titanMarkersEnabled = state
    print("Titan Markers " .. (state and "Enabled" or "Disabled"))
end)

Section:NewToggle("Enable Camera Lock", "Lock camera to nearest titan", function(state)
    cameraLockEnabled = state
    print("Camera Lock " .. (state and "Enabled" or "Disabled"))
end)

Section:NewSlider("Attack Speed", "Adjust attack speed (lower = faster)", 0.1, 0.01, 0.03, function(value)
    attackSpeed = value
    print("Attack Speed set to: " .. value)
end)

Section:NewButton("Kill All Titans", "Instantly kill all Titans", function()
    local titansFolder = workspace:FindFirstChild("Titans")
    if titansFolder then
        for _, titan in pairs(titansFolder:GetChildren()) do
            if titan:IsA("Model") and titan:FindFirstChild("Humanoid") then
                titan.Humanoid.Health = 0
            end
        end
        print("Killed all Titans!")
    else
        warn("Titans folder not found!")
    end
end)

-- Auto-Farm مع Titan Markers
spawn(function()
    local titanMarkers = {}
    while task.wait(0.1) do
        if not autoFarmEnabled and not titanMarkersEnabled then continue end
        local titansFolder = workspace:FindFirstChild("Titans")
        if not titansFolder then continue end

        if napeExpanderEnabled then
            processTitans(titansFolder)
        end

        if titanMarkersEnabled then
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

        if autoFarmEnabled then
            for _, titan in pairs(titansFolder:GetChildren()) do
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
    end
end)

-- Auto-Escape
spawn(function()
    while task.wait(0.3) do
        if not getgenv().autoescape then continue end
        for _, v in pairs(game.Players.LocalPlayer.PlayerGui:FindFirstChild("Interface") and game.Players.LocalPlayer.PlayerGui.Interface:FindFirstChild("Buttons") and game.Players.LocalPlayer.PlayerGui.Interface.Buttons:GetChildren() or {}) do
            if v:IsA("TextButton") then
                local key = v.Name:sub(1, 1):upper()
                VIM:SendKeyEvent(true, key, false, game)
                task.wait(0.01)
                VIM:SendKeyEvent(false, key, false, game)
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

-- Camera Lock من السكربت الثاني
spawn(function()
    local range = 6000
    local settings = {x = 5, y = 2, z = -0.3}
    while task.wait() do
        if not cameraLockEnabled then continue end
        if not game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then continue end
        local titan, closestDist = nil, nil
        local titansFolder = workspace:FindFirstChild("Titans")
        if not titansFolder then continue end

        for _, opposition in pairs(titansFolder:GetChildren()) do
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

print("AOTR Script Loaded Successfully with All Features - Grok @ xAI")

