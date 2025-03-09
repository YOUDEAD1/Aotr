-- تحميل السكربت الخارجي مباشرة
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/refs/heads/main/solix%20v2%20new%20loader.lua"))()

-- تعريف الخدمات
local function b(c) return cloneref and cloneref(c) or c end
local d = { [Enum.UserInputType.MouseButton1] = "M1", [Enum.UserInputType.MouseButton2] = "M2", [Enum.UserInputType.MouseButton3] = "M3" }
local e = { Enum.KeyCode.Unknown, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Up, Enum.KeyCode.Left, Enum.KeyCode.Down, Enum.KeyCode.Right, Enum.KeyCode.Slash, Enum.KeyCode.Tab, Enum.KeyCode.Backspace, Enum.KeyCode.Escape, Enum.KeyCode.RightShift }
local function f(g, h) for i, j in next, g do if j == h or i == h then return true end end end

-- تعريف مكتبة nexlib
local k = { accentclr = Color3.fromRGB(173, 95, 127), dropdownframes = {}, colorpickerframes = {} }
local l = b(game:GetService("UserInputService"))
local m = b(game:GetService("TweenService"))
local n = b(game:GetService("RunService"))
local o = game:GetService("Players").LocalPlayer
local p = b(o:GetMouse())
local q = b(game:GetService("HttpService"))

-- إنشاء ملف تكوين
if not isfile("nexlib/config.cfg") then writefile("nexlib/config.cfg", q:JSONEncode({})) end

-- دالة تحريك الإطارات
local function r(s, t)
    pcall(function()
        local u, v, w, x
        s.InputBegan:Connect(function(y)
            if y.UserInputType == Enum.UserInputType.MouseButton1 then
                u = true
                w = y.Position
                x = t.Position
                y.Changed:Connect(function() if y.UserInputState == Enum.UserInputState.End then u = false end end)
            end
        end)
        s.InputChanged:Connect(function(y) if y.UserInputType == Enum.UserInputType.MouseMovement then v = y end end)
        l.InputChanged:Connect(function(y)
            if y == v and u then
                local z = y.Position - w
                t.Position = UDim2.new(x.X.Scale, x.X.Offset + z.X, x.Y.Scale, x.Y.Offset + z.Y)
            end
        end)
    end)
end

-- إعداد واجهة المستخدم
local A = Instance.new("ScreenGui")
A.Name = "nexlib"
A.Parent = game.CoreGui
A.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local B = Instance.new("Folder")

-- دالة الإشعارات
function k:Notification(C, D, E, F)
    for i, j in pairs(B:GetChildren()) do j:TweenPosition(UDim2.new(0.5, 0, j.Position.Y.Scale - 0.05, 0), "Out", "Quart", .3, true) end
    local G = Instance.new("Frame")
    G.Name = "Notification"
    G.Parent = B
    G.AnchorPoint = Vector2.new(0.5, 0.5)
    G.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    G.BorderColor3 = Color3.fromRGB(60, 60, 60)
    G.BorderSizePixel = 0
    G.Position = UDim2.new(1.5, 0, 0.5, 0)
    G.Size = UDim2.new(0, 328, 0, 45)
    local H = Instance.new("ImageLabel", G)
    H.Name = "OutlineNotification1"
    H.BackgroundTransparency = 1
    H.Position = UDim2.new(0, 1, 0, 1)
    H.Size = UDim2.new(1, -2, 1, -2)
    H.Image = "rbxassetid://2592362371"
    H.ImageColor3 = Color3.fromRGB(60, 60, 60)
    H.ScaleType = Enum.ScaleType.Slice
    H.SliceCenter = Rect.new(2, 2, 62, 62)
    local I = Instance.new("ImageLabel", G)
    I.Name = "OutlineNotification2"
    I.BackgroundTransparency = 1
    I.Size = UDim2.new(1, 0, 1, 0)
    I.Image = "rbxassetid://2592362371"
    I.ImageColor3 = Color3.fromRGB(0, 0, 0)
    I.ScaleType = Enum.ScaleType.Slice
    I.SliceCenter = Rect.new(2, 2, 62, 62)
    local J = Instance.new("ImageLabel", G)
    J.Name = "NotificationIco"
    J.AnchorPoint = Vector2.new(0, 0.5)
    J.BackgroundTransparency = 1
    J.Position = UDim2.new(0, 7, 0.5, 0)
    J.Size = UDim2.new(0, 25, 0, 25)
    J.Image = "http://www.roblox.com/asset/?id=6026568210"
    J.ImageColor3 = k.accentclr
    local K = Instance.new("TextLabel", G)
    K.Name = "NotificationTitle"
    K.BackgroundTransparency = 1
    K.Position = UDim2.new(0, 39, 0, 6)
    K.Size = UDim2.new(0, 200, 0, 19)
    K.Font = Enum.Font.Code
    K.Text = C
    K.TextColor3 = Color3.fromRGB(255, 255, 255)
    K.TextSize = 16
    K.TextXAlignment = Enum.TextXAlignment.Left
    local L = Instance.new("TextLabel", G)
    L.Name = "NotificationDesc"
    L.BackgroundTransparency = 1
    L.Position = UDim2.new(0.014, 35, 1, -25)
    L.Size = UDim2.new(0, 200, 0, 19)
    L.Font = Enum.Font.Code
    L.Text = D
    L.TextColor3 = Color3.fromRGB(200, 200, 200)
    L.TextSize = 15
    L.TextXAlignment = Enum.TextXAlignment.Left
    G.Size = UDim2.new(0, L.TextBounds.X + 45, 0, 45)
    if #K.Text >= #L.Text then G.Size = UDim2.new(0, K.TextBounds.X + 45, 0, 45) end
    G:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Quart", .3, true)
    delay(E, function()
        G:TweenPosition(UDim2.new(1.5, 0, G.Position.Y.Scale, 0), "InOut", "Linear", 0.2, true)
        wait(0.2)
        G:Destroy()
    end)
end

-- دالة النافذة
function k:Window(D)
    local M = false
    local N = false
    local O = Instance.new("Frame")
    O.Name = "MainFrame"
    O.Parent = A
    O.AnchorPoint = Vector2.new(0.5, 0.5)
    O.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    O.BorderColor3 = Color3.fromRGB(60, 60, 60)
    O.Position = UDim2.new(0.5, 0, 0.5, 0)
    O.Size = UDim2.new(0, 258, 0, 250)
    O.Visible = true
    local P = Instance.new("ImageLabel", O)
    P.Name = "OutlineMainFrame1"
    P.BackgroundTransparency = 1
    P.Position = UDim2.new(0, 1, 0, 1)
    P.Size = UDim2.new(1, -2, 1, -2)
    P.Image = "rbxassetid://2592362371"
    P.ImageColor3 = Color3.fromRGB(60, 60, 60)
    P.ScaleType = Enum.ScaleType.Slice
    P.SliceCenter = Rect.new(2, 2, 62, 62)
    local Q = Instance.new("ImageLabel", O)
    Q.Name = "OutlineMainFrame2"
    Q.BackgroundTransparency = 1
    Q.Size = UDim2.new(1, 0, 1, 0)
    Q.Image = "rbxassetid://2592362371"
    Q.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Q.ScaleType = Enum.ScaleType.Slice
    Q.SliceCenter = Rect.new(2, 2, 62, 62)
    local R = Instance.new("Frame", O)
    R.Name = "ContainerHolderFrame"
    R.AnchorPoint = Vector2.new(0.5, 0)
    R.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    R.BorderColor3 = Color3.fromRGB(30, 30, 30)
    R.Position = UDim2.new(0.5, 0, 0.071, 0)
    R.Size = UDim2.new(1, -18, 0, 487)
    R.BackgroundTransparency = 1
    local S = Instance.new("Frame", R)
    S.Name = "TabHolderFrame"
    S.BackgroundTransparency = 1
    S.Size = UDim2.new(1, 0, 0, 28)
    S.Visible = false
    local T = Instance.new("UIListLayout", S)
    T.Name = "TabHolderFrameLayout"
    T.FillDirection = Enum.FillDirection.Horizontal
    T.SortOrder = Enum.SortOrder.LayoutOrder
    T.Padding = UDim.new(0, 8)
    local U = Instance.new("UIPadding", S)
    U.Name = "TabHolderFramePadding"
    U.PaddingLeft = UDim.new(0, 7)
    local V = Instance.new("Frame", O)
    V.Name = "TopBar"
    V.AnchorPoint = Vector2.new(0.5, 0)
    V.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    V.BorderSizePixel = 0
    V.Position = UDim2.new(0.5, 0, 0, 2)
    V.Size = UDim2.new(1, -5, 0, 28)
    local W = Instance.new("TextLabel", V)
    W.Name = "TopBarTitle"
    W.BackgroundTransparency = 1
    W.Position = UDim2.new(0, 7, 0, 5)
    W.Size = UDim2.new(0, 0, 0, 16)
    W.Font = Enum.Font.Code
    W.Text = D
    W.TextColor3 = Color3.fromRGB(255, 255, 255)
    W.TextSize = 16
    W.TextXAlignment = Enum.TextXAlignment.Left
    local X = Instance.new("Frame", V)
    X.Name = "TopBarLine"
    X.BackgroundColor3 = Color3.fromRGB(255, 55, 55)
    X.BorderSizePixel = 0
    X.Position = UDim2.new(0, 0, 0, 27)
    X.Size = UDim2.new(1, 0, 0, 1)
    r(V, O)
    B.Name = "NotificationFolder"
    B.Parent = A
    l.InputBegan:Connect(function(Y)
        if Y.KeyCode == Enum.KeyCode.RightShift then
            M = not M
            O.Visible = M
        end
    end)
    coroutine.wrap(function() while wait() do X.BackgroundColor3 = k.accentclr end end)()

    local _ = {}
    function _:Tab(D)
        local a0 = 50
        local a1 = Instance.new("TextButton", S)
        a1.Name = "TabBtn"
        a1.BackgroundTransparency = 1
        a1.Font = Enum.Font.Code
        a1.Text = D
        a1.TextColor3 = Color3.fromRGB(255, 255, 255)
        a1.TextSize = 15
        a1.TextTransparency = 0.4
        a1.Size = UDim2.new(0, a1.TextBounds.X, 1, 0)
        local a2 = Instance.new("ScrollingFrame", R)
        a2.Name = "SectionHolder1"
        a2.Active = true
        a2.BackgroundTransparency = 1
        a2.BorderSizePixel = 0
        a2.Position = UDim2.new(0, 8, 0, 32)
        a2.Size = UDim2.new(0, 227, 1, -40)
        a2.Visible = false
        a2.CanvasSize = UDim2.new(0, 0, 0, 0)
        a2.ScrollBarThickness = 0
        a2.ZIndex = 1
        local a3 = Instance.new("UIPadding", a2)
        a3.Name = "SectionHolder1Padding"
        a3.PaddingTop = UDim.new(0, 5)
        local a4 = Instance.new("UIListLayout", a2)
        a4.Name = "SectionHolder1Layout"
        a4.SortOrder = Enum.SortOrder.LayoutOrder
        a4.Padding = UDim.new(0, 10)
        local a5 = Instance.new("ScrollingFrame", R)
        a5.Name = "SectionHolder2"
        a5.Active = true
        a5.BackgroundTransparency = 1
        a5.BorderSizePixel = 0
        a5.Position = UDim2.new(0, 243, 0, 32)
        a5.Size = UDim2.new(0, 227, 1, -40)
        a5.Visible = false
        a5.CanvasSize = UDim2.new(0, 0, 0, 0)
        a5.ScrollBarThickness = 0
        a5.ZIndex = 2
        local a6 = Instance.new("UIPadding", a5)
        a6.Name = "SectionHolder2Padding"
        a6.PaddingTop = UDim.new(0, 5)
        local a7 = Instance.new("UIListLayout", a5)
        a7.Name = "SectionHolder2Layout"
        a7.SortOrder = Enum.SortOrder.LayoutOrder
        a7.Padding = UDim.new(0, 10)
        if N == false then
            N = true
            a2.Visible = true
            a5.Visible = true
            a1.TextTransparency = 0
        end
        a1.MouseButton1Click:Connect(function()
            for i, j in next, S:GetChildren() do
                if j.Name == "TabBtn" then m:Create(j, TweenInfo.new(.2, Enum.EasingStyle.Quad, "Out"), {TextTransparency = 0.4}):Play() end
            end
            for i, j in next, R:GetChildren() do if j.Name == "SectionHolder1" then j.Visible = false end end
            for i, j in next, R:GetChildren() do if j.Name == "SectionHolder2" then j.Visible = false end end
            a2.Visible = true
            a5.Visible = true
            m:Create(a1, TweenInfo.new(.2, Enum.EasingStyle.Quad, "Out"), {TextTransparency = 0}):Play()
        end)

        local a8 = {}
        function a8:Section(D)
            a0 = a0 - 1
            local a9 = (a2:GetChildren() and #a2:GetChildren() == 0 and a5:GetChildren() and #a5:GetChildren() == 0) and a2 or (#a2:GetChildren() == #a5:GetChildren() and a2 or a5)
            local ac = Instance.new("Frame", a9)
            ac.Name = "Section"
            ac.AnchorPoint = Vector2.new(0.5, 0)
            ac.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            ac.BorderColor3 = Color3.fromRGB(40, 40, 40)
            ac.Position = UDim2.new(0.495, 0, 0.011, 0)
            ac.Size = UDim2.new(1, -2, 0, 24)
            ac.ZIndex = a0
            local ad = Instance.new("ImageLabel", ac)
            ad.Name = "SectionOutline2"
            ad.BackgroundTransparency = 1
            ad.Size = UDim2.new(1, 0, 1, 0)
            ad.Image = "rbxassetid://2592362371"
            ad.ImageColor3 = Color3.fromRGB(0, 0, 0)
            ad.ScaleType = Enum.ScaleType.Slice
            ad.SliceCenter = Rect.new(2, 2, 62, 62)
            local ae = Instance.new("ImageLabel", ac)
            ae.Name = "SectionOutline1"
            ae.BackgroundTransparency = 1
            ae.Position = UDim2.new(0, 1, 0, 1)
            ae.Size = UDim2.new(1, -2, 1, -2)
            ae.Image = "rbxassetid://2592362371"
            ae.ImageColor3 = Color3.fromRGB(60, 60, 60)
            ae.ScaleType = Enum.ScaleType.Slice
            ae.SliceCenter = Rect.new(2, 2, 62, 62)
            local af = Instance.new("Frame", ac)
            af.Name = "SectionTitleFrame"
            af.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            af.BorderSizePixel = 0
            af.Position = UDim2.new(0, 10, 0, 0)
            af.Size = UDim2.new(0, 65, 0, 7)
            local ag = Instance.new("TextLabel", af)
            ag.Name = "SectionTitle"
            ag.BackgroundTransparency = 1
            ag.Position = UDim2.new(0, 0, 0, -3)
            ag.Size = UDim2.new(1, 0, 0, 7)
            ag.Font = Enum.Font.Code
            ag.Text = D
            ag.TextColor3 = Color3.fromRGB(255, 255, 255)
            ag.TextSize = 14
            af.Size = UDim2.new(0, ag.TextBounds.X + 6, 0, 7)
            local ah = Instance.new("Frame", ac)
            ah.Name = "SectionItemHolderFrame"
            ah.AnchorPoint = Vector2.new(0.5, 0)
            ah.BackgroundTransparency = 1
            ah.Position = UDim2.new(0.5, 0, 0, 15)
            ah.Size = UDim2.new(1, -16, 0, 0)
            local ai = Instance.new("UIListLayout", ah)
            ai.Name = "SectionItemHolderLayout"
            ai.SortOrder = Enum.SortOrder.LayoutOrder
            ai.Padding = UDim.new(0, 5)

            local a8 = {}
            function a8:Button(D, aj)
                local ak = Instance.new("TextButton", ah)
                ak.Name = "Button"
                ak.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                ak.BorderColor3 = k.accentclr
                ak.BorderSizePixel = 0
                ak.Size = UDim2.new(1, 0, 0, 20)
                ak.AutoButtonColor = false
                ak.Font = Enum.Font.Code
                ak.TextColor3 = Color3.fromRGB(255, 255, 255)
                ak.TextSize = 14
                ak.Text = D
                local al = Instance.new("ImageLabel", ak)
                al.Name = "ButtonOutline1"
                al.BackgroundTransparency = 1
                al.Size = UDim2.new(1, 0, 1, 0)
                al.Image = "rbxassetid://2592362371"
                al.ImageColor3 = Color3.fromRGB(60, 60, 60)
                al.ScaleType = Enum.ScaleType.Slice
                al.SliceCenter = Rect.new(2, 2, 62, 62)
                local am = Instance.new("ImageLabel", ak)
                am.Name = "ButtonOutline2"
                am.BackgroundTransparency = 1
                am.Position = UDim2.new(0, 1, 0, 1)
                am.Size = UDim2.new(1, -2, 1, -2)
                am.Image = "rbxassetid://2592362371"
                am.ImageColor3 = Color3.fromRGB(0, 0, 0)
                am.ScaleType = Enum.ScaleType.Slice
                am.SliceCenter = Rect.new(2, 2, 62, 62)
                ak.MouseButton1Click:Connect(function() pcall(aj) end)
                ak.MouseLeave:Connect(function() ak.BorderSizePixel = 0 end)
                ak.MouseEnter:Connect(function() ak.BorderSizePixel = 1 end)
                ac.Size = UDim2.new(1, -2, 0, ai.AbsoluteContentSize.Y + 24)
                coroutine.wrap(function() while wait() do ak.BorderColor3 = k.accentclr end end)()
            end

            return a8
        end
        return a8
    end
    return _
end

-- إنشاء النافذة
local bJ = k:Window("SolixHub")
local bK = bJ:Tab("Main")
local bL = bK:Section("Info")
bL:Button("Loaded", function()
    k:Notification("Success", "Script loaded successfully!", 3)
end)
