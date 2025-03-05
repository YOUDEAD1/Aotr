-- إعداد واجهة المستخدم
‏local a = Instance.new("ScreenGui")
‏local b = Instance.new("Frame")
‏local c = Instance.new("TextLabel")
‏local d = Instance.new("ScrollingFrame")
‏local e = Instance.new("TextLabel")
‏local f = Instance.new("TextLabel")
‏local g = Instance.new("TextButton")
‏local h = Instance.new("TextButton")
‏local i = Instance.new("TextButton")
‏local j = Instance.new("TextLabel")
‏local k = Instance.new("TextButton")
‏local l = Instance.new("BoolValue")

‏a.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
‏a.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

‏b.Parent = a
‏b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
‏b.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏b.BorderSizePixel = 0
‏b.Position = UDim2.new(0.4164823, 0, 0.0479591824, 0)
‏b.Size = UDim2.new(0, 340, 0, 329)
‏b.Style = Enum.FrameStyle.RobloxRound

‏c.Name = "Title"
‏c.Parent = b
‏c.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
‏c.BackgroundTransparency = 1.000
‏c.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏c.BorderSizePixel = 0
‏c.Position = UDim2.new(0.0207602102, 0, -0.00166114408, 0)
‏c.Size = UDim2.new(0, 312, 0, 50)
‏c.Font = Enum.Font.Unknown
‏c.Text = "Tekkit AotR"
‏c.TextColor3 = Color3.fromRGB(255, 255, 255)
‏c.TextScaled = true
‏c.TextSize = 1.000
‏c.TextWrapped = true

‏d.Parent = b
‏d.Active = true
‏d.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
‏d.BackgroundTransparency = 1.000
‏d.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏d.BorderSizePixel = 0
‏d.Position = UDim2.new(0.0415333472, 0, 0.162598208, 0)
‏d.Size = UDim2.new(0, 305, 0, 256)
‏d.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

‏e.Name = "Teleport"
‏e.Parent = d
‏e.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
‏e.BackgroundTransparency = 1.000
‏e.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏e.BorderSizePixel = 0
‏e.Position = UDim2.new(0.0799999982, 0, 0.0299999993, 0)
‏e.Size = UDim2.new(0, 200, 0.0599999987, 0)
‏e.Font = Enum.Font.Fondamento
‏e.Text = "Nape Teleport"
‏e.TextColor3 = Color3.fromRGB(148, 148, 148)
‏e.TextSize = 25.000
‏e.TextWrapped = true

‏f.Name = "Titan Farmer"
‏f.Parent = d
‏f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
‏f.BackgroundTransparency = 1.000
‏f.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏f.BorderSizePixel = 0
‏f.Position = UDim2.new(0.0804597735, 0, 0.104999997, 0)
‏f.Size = UDim2.new(0, 200, 0.0599999987, 0)
‏f.Font = Enum.Font.Unknown
‏f.Text = "Titan Farmer"
‏f.TextColor3 = Color3.fromRGB(148, 148, 148)
‏f.TextSize = 20.000
‏f.TextWrapped = true

‏g.Name = "tpButton"
‏g.Parent = d
‏g.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
‏g.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏g.BorderSizePixel = 2
‏g.Position = UDim2.new(0.699999988, 0, 0.0350000001, 0)
‏g.Size = UDim2.new(0, 30, 0, 30)
‏g.Font = Enum.Font.SourceSans
‏g.Text = ""
‏g.TextColor3 = Color3.fromRGB(0, 0, 0)
‏g.TextSize = 14.000

‏h.Name = "tpButtonF"
‏h.Parent = d
‏h.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
‏h.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏h.BorderSizePixel = 2
‏h.Position = UDim2.new(0.699999928, 0, 0.10900782, 0)
‏h.Size = UDim2.new(0, 30, 0, 30)
‏h.Font = Enum.Font.SourceSans
‏h.Text = ""
‏h.TextColor3 = Color3.fromRGB(0, 0, 0)
‏h.TextSize = 14.000

‏i.Name = "refill"
‏i.Parent = d
‏i.BackgroundColor3 = Color3.fromRGB(94, 94, 94)
‏i.BackgroundTransparency = 0.800
‏i.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏i.BorderSizePixel = 0
‏i.Position = UDim2.new(0.230000004, 0, 0.264999986, 0)
‏i.Size = UDim2.new(0, 100, 0, 25)
‏i.Font = Enum.Font.Unknown
‏i.Text = "Tp to Refill"
‏i.TextColor3 = Color3.fromRGB(148, 148, 148)
‏i.TextScaled = true
‏i.TextSize = 27.000
‏i.TextWrapped = true

‏j.Name = "esp"
‏j.Parent = d
‏j.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
‏j.BackgroundTransparency = 1.000
‏j.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏j.BorderSizePixel = 0
‏j.Position = UDim2.new(0.0542302355, 0, 0.181999996, 0)
‏j.Size = UDim2.new(0, 200, 0.0599999987, 0)
‏j.Font = Enum.Font.Unknown
‏j.Text = "Titan ESP"
‏j.TextColor3 = Color3.fromRGB(148, 148, 148)
‏j.TextSize = 23.000
‏j.TextWrapped = true

‏k.Name = "tpButtonE"
‏k.Parent = d
‏k.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
‏k.BorderColor3 = Color3.fromRGB(0, 0, 0)
‏k.BorderSizePixel = 2
‏k.Position = UDim2.new(0.699999988, 0, 0.185000002, 0)
‏k.Size = UDim2.new(0, 30, 0, 30)
‏k.Font = Enum.Font.SourceSans
‏k.Text = ""
‏k.TextColor3 = Color3.fromRGB(0, 0, 0)
‏k.TextSize = 14.000

‏b.Draggable = true
‏b.Selectable = true
‏b.Active = true

-- الوظائف البرمجية
‏local a = game:GetService("Players")
‏local a = a.LocalPlayer
‏local c = game:GetService("Workspace")
‏local d = game:GetService("UserInputService")
‏local e
‏local f = false
‏local j = 1250
‏local l
‏local m
‏local m = false
‏local n = math.huge
‏local o = false
‏local o = {}

‏local function o()
‏    local a = a.Character or a.CharacterAdded:Wait()
‏    local a = a:WaitForChild("HumanoidRootPart")
‏    if a and a:IsA("BasePart") then
‏        local a = a.Position
‏        print("HumanoidRootPart Location:", a)
‏        return a
‏    else
‏        warn("HumanoidRootPart not found for LocalPlayer.")
‏        return nil
‏    end
‏end

‏local function p()
‏    local a = c:FindFirstChild("Titans")
‏    local b = nil
‏    local c = math.huge
‏    if a then
‏        local d = o()
‏        for a, a in ipairs(a:GetChildren()) do
‏            if a:IsA("Model") and a:FindFirstChildOfClass("Humanoid") then
‏                local a = a:FindFirstChild("Hitboxes")
‏                if a then
‏                    local a = a:FindFirstChild("Hit")
‏                    if a then
‏                        local a = a:FindFirstChild("Nape")
‏                        if a then
‏                            local d = (a.Position - d).Magnitude
‏                            if d < c and d <= n then
‏                                c = d
‏                                b = a
‏                            end
‏                        end
‏                    end
‏                end
‏            end
‏        end
‏    else
‏        warn("Titans folder not found in Workspace.")
‏    end
‏    if b then
‏        l = b
‏        print("Closest NapeLocation set to:", l.Position)
‏    else
‏        warn("No Nape part found within maximum teleport distance.")
‏    end
‏    return l
‏end

‏local function n()
‏    if l then
‏        local a = a.Character and a.Character:FindFirstChild("HumanoidRootPart")
‏        if a then
‏            local b = Instance.new("BodyPosition")
‏            b.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
‏            b.Position = l.Position + Vector3.new(0, 450, 0)
‏            b.Parent = a
‏            local c = Instance.new("BodyGyro")
‏            c.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
‏            c.CFrame = a.CFrame
‏            c.Parent = a
‏            return b, c
‏        else
‏            warn("Nape not found.")
‏            return nil, nil
‏        end
‏    end
‏end

‏local function o(a, b)
‏    if a then a:Destroy() end
‏    if b then b:Destroy() end
‏end

‏local function q()
‏    local a = a.Character and a.Character:FindFirstChild("HumanoidRootPart")
‏    if a then
‏        local b = a.Position
‏        local function c(b)
‏            a.CFrame = CFrame.new(b)
‏        end
‏        local function a()
‏            p()
‏            if l then
‏                local a = l.Position
‏                local d = (a - b) / 4
‏                local d = d * 3
‏                for e = 1, 2 do
‏                    c(b + d)
‏                    wait(0.001)
‏                    c(a)
‏                    c(a)
‏                    c(a)
‏                    c(a)
‏                end
‏            end
‏        end
‏        a()
‏    end
‏end

‏local function r()
‏    m = not m
‏    if m then
‏        print("Teleportation Enabled")
‏        p()
‏        local b, c = n()
‏        spawn(function()
‏            while m do
‏                wait(1)
‏                p()
‏                if b and c then
‏                    b.Position = l.Position + Vector3.new(0, 300, 0)
‏                    c.CFrame = a.Character.HumanoidRootPart.CFrame
‏                end
‏            end
‏            o(b, c)
‏        end)
‏    else
‏        print("Teleportation Disabled")
‏    end
‏end

‏h.MouseButton1Click:Connect(function()
‏    r()
‏    h.BackgroundColor3 = m and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
‏end)

‏d.InputEnded:Connect(function(a)
‏    if (a.UserInputType == Enum.UserInputType.MouseButton1 or a.UserInputType == Enum.UserInputType.Touch) and m == true then
‏        q()
‏    end
‏end)

‏local h = {}
‏local l = false

‏local function m(a, b, c)
‏    if not a:FindFirstChildOfClass("Highlight") then
‏        local d = Instance.new("Highlight")
‏        d.Adornee = a
‏        d.FillTransparency = c or 0.5
‏        d.FillColor = b or Color3.new(1, 1, 1)
‏        d.OutlineTransparency = c or 0
‏        d.OutlineColor = b or Color3.new(1, 1, 1)
‏        d.Enabled = l
‏        d.Parent = a
‏        table.insert(h, d)
‏        print("Highlight created for model: " .. a.Name)
‏    else
‏        print("Highlight already exists for model: " .. a.Name)
‏    end
‏end

‏local function n(a)
‏    local b = {"LowerTorso", "LeftUpperArm", "RightUpperLeg", "LeftLowerLeg", "LeftUpperLeg", "RightLowerLeg", "LeftFoot", "RightLowerArm", "UpperTorso", "LeftLowerArm", "RightUpperArm", "LeftHand", "RightFoot", "RightHand", "Head"}
‏    for b, b in ipairs(b) do
‏        local a = a:FindFirstChild(b)
‏        if a and a:IsA("BasePart") then
‏            m(a.Parent, Color3.new(1, 1, 1), 0.65)
‏        else
‏            print("Part not found or not a BasePart: " .. b)
‏        end
‏    end
‏end

‏local function m()
‏    local a = workspace:FindFirstChild("Titans")
‏    if a then
‏        for a, a in ipairs(a:GetChildren()) do
‏            if a:IsA("Model") and a:FindFirstChildOfClass("Humanoid") then
‏                local b = a:FindFirstChild("Fake")
‏                if b then
‏                    print("Highlighting model: " .. a.Name)
‏                    n(b)
‏                else
‏                    print("No Fake model found in: " .. a.Name)
‏                end
‏            else
‏                print("No Humanoid found in: " .. a.Name)
‏            end
‏        end
‏    else
‏        warn("Titans folder not found in Workspace.")
‏    end
‏end

‏local function n(a)
‏    l = a
‏    for a, a in ipairs(h) do
‏        if a:IsA("Highlight") then
‏            a.Enabled = l
‏        end
‏    end
‏    k.BackgroundColor3 = l and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
‏    if not l then
‏        for a, a in ipairs(h) do
‏            a:Destroy()
‏        end
‏        h = {}
‏    else
‏        m()
‏    end
‏end

‏k.MouseButton1Click:Connect(function()
‏    n(not l)
‏end)

‏m()

‏local function h()
‏    local a = a.Character or a.CharacterAdded:Wait()
‏    local a = a:WaitForChild("HumanoidRootPart")
‏    if a and a:IsA("BasePart") then
‏        local a = a.Position
‏        print("HumanoidRootPart Location:", a)
‏        return a
‏    else
‏        warn("HumanoidRootPart not found for LocalPlayer.")
‏        return nil
‏    end
‏end

‏local function k()
‏    local a = c:FindFirstChild("Titans")
‏    local b = nil
‏    local c = math.huge
‏    if a then
‏        local d = h()
‏        for a, a in ipairs(a:GetChildren()) do
‏            if a:IsA("Model") and a:FindFirstChildOfClass("Humanoid") then
‏                local a = a:FindFirstChild("Hitboxes")
‏                if a then
‏                    local a = a:FindFirstChild("Hit")
‏                    if a then
‏                        local a = a:FindFirstChild("Nape")
‏                        if a then
‏                            local d = (a.Position - d).Magnitude
‏                            if d < c and d <= j then
‏                                c = d
‏                                b = a.CFrame
‏                            end
‏                        end
‏                    end
‏                end
‏            end
‏        end
‏    else
‏        warn("Titans folder not found in Workspace.")
‏    end
‏    if b then
‏        e = b
‏        print("Closest NapeLocation2 set to:", e)
‏    else
‏        warn("No Nape part found within maximum teleport distance.")
‏    end
‏    return e
‏end

‏local function c()
‏    f = not f
‏    local a = f and "Teleport Enabled (Bypass status is unknown)" or "Teleport Disabled (Bypass status is unknown)"
‏    print("Nape Teleportation Toggled: " .. a)
‏    return a
‏end

‏local function h()
‏    if f then
‏        k()
‏        local a = a.Character and a.Character:FindFirstChild("HumanoidRootPart")
‏        if a and e then
‏            local b = a.CFrame
‏            a.CFrame = e
‏            delay(0.01, function()
‏                a.Velocity = Vector3.new(300, 10, 0)
‏            end)
‏            delay(0.35, function()
‏                a.CFrame = b
‏                e = nil
‏                print("NapeLocation reset to nil")
‏            end)
‏        end
‏    end
‏end

‏d.InputEnded:Connect(function(a)
‏    if a.UserInputType == Enum.UserInputType.MouseButton1 and f == true then
‏        h()
‏    end
‏end)

‏g.MouseButton1Click:Connect(function()
‏    local a = c()
‏    g.BackgroundColor3 = f and Color3.new(0, 1, 0) or Color3.fromRGB(79, 79, 79)
‏end)

‏local c = game.Workspace.Unclimbable.Reloads.GasTanks:FindFirstChild("GasTank"):FindFirstChild("GasTank")

‏local function e()
‏    local a = a.Character and a.Character:FindFirstChild("HumanoidRootPart")
‏    if c and a then
‏        local b = c.CFrame
‏        a.CFrame = c.CFrame + Vector3.new(0, 25, 0)
‏    end
‏end

‏i.MouseButton1Click:Connect(e)

‏local function a()
‏    if b.Visible then
‏        b.Visible = false
‏        wait(0.35)
‏    else
‏        b.Visible = true
‏        wait(0.35)
‏    end
‏end

‏d.InputBegan:Connect(function(b)
‏    if b.KeyCode == Enum.KeyCode.RightShift then
‏        a()
‏    end
‏end)
