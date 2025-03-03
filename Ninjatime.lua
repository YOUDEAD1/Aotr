-- Scylla scripthub made by cepedev and scripted by cepedev & local
-- Last updated: 12/18/2023
-- Supported games: Universal

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Anti AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Load Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Scylla Scripthub", "DarkTheme")

-- Main tab
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Main")

-- Walkspeed
MainSection:NewSlider("Walkspeed", "Change your walkspeed", 500, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- Jump Power
MainSection:NewSlider("Jump Power", "Change your jump power", 500, 50, function(j)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = j
end)

-- Gravity
MainSection:NewSlider("Gravity", "Change the game gravity", 500, 0, function(g)
    game.Workspace.Gravity = g
end)

-- FOV
MainSection:NewSlider("Field Of View", "Change your FOV", 120, 0, function(fov)
    game.Workspace.CurrentCamera.FieldOfView = fov
end)

-- Infinite Jump
MainSection:NewToggle("Infinite Jump", "Jump infinitely", function(state)
    if state then
        _G.InfiniteJump = true
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfiniteJump then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    else
        _G.InfiniteJump = false
    end
end)

-- Noclip
MainSection:NewToggle("Noclip", "Walk through walls", function(state)
    if state then
        _G.Noclip = true
        while _G.Noclip do
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
            wait()
        end
    else
        _G.Noclip = false
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
    end
end)

-- Fly
MainSection:NewToggle("Fly", "Fly around", function(state)
    if state then
        _G.Fly = true
        local speed = 50
        local bodyGyro = Instance.new("BodyGyro", game.Players.LocalPlayer.Character.HumanoidRootPart)
        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        local bodyVelocity = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
        while _G.Fly do
            if game.Players.LocalPlayer.Character then
                local camera = game.Workspace.CurrentCamera
                local moveDirection = Vector3.new()
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + (camera.CFrame.LookVector * speed)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - (camera.CFrame.LookVector * speed)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - (camera.CFrame.RightVector * speed)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + (camera.CFrame.RightVector * speed)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = Vect
or3.new(moveDirection.X, speed, moveDirection.Z)
                end
                if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = Vector3.new(moveDirection.X, -speed, moveDirection.Z)
                end
                bodyVelocity.Velocity = moveDirection
                bodyGyro.CFrame = camera.CFrame
            end
            wait()
        end
    else
        _G.Fly = false
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.HumanoidRootPart.BodyGyro:Destroy()
            game.Players.LocalPlayer.Character.HumanoidRootPart.BodyVelocity:Destroy()
        end
    end
end)

-- Combat tab
local CombatTab = Window:NewTab("Combat")
local CombatSection = CombatTab:NewSection("Combat")

-- Kill Aura
CombatSection:NewToggle("Kill Aura", "Kill nearby players", function(state)
    if state then
        _G.KillAura = true
        while _G.KillAura do
            for i,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    local distance = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                    if distance <= 20 then
                        v.Character.Humanoid.Health = 0
                    end
                end
            end
            wait()
        end
    else
        _G.KillAura = false
    end
end)
-- ESP
CombatSection:NewToggle("ESP", "See players through walls", function(state)
    if state then
        _G.ESP = true
        while _G.ESP do
            for i,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character then
                    local highlight = Instance.new("Highlight", v.Character)
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            end
            wait(1)
        end
    else
        _G.ESP = false
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("Highlight") then
                v.Character.Highlight:Destroy()
            end
        end
    end
end)

-- Aimbot
CombatSection:NewToggle("Aimbot", "Automatically aim at players", function(state)
    if state then
        _G.Aimbot = true
        local camera = game.Workspace.CurrentCamera
        local mouse = game.Players.LocalPlayer:GetMouse()
        while _G.Aimbot do
            local closestPlayer, closestDistance = nil, math.huge
            for i,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local screenPoint = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                    local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = v
                    end
                end
            end
            if closestPlayer then
                camera.CFrame = CFrame.new(camera.CFrame.Position, closestPlayer.Character.HumanoidRootPart.Position)
            end
            wait()
        end
    else
        _G.Aimbot = false
    end
end)

-- Auto Farm tab
local AutoFarmTab = Window:NewTab("Auto Farm")
local AutoFarmSection = AutoFarmTab:NewSection("Auto Farm")

-- Auto Collect
AutoFarmSection:NewToggle("Auto Collect", "Automatically collect resources", function(state)
    if state then
        _G.AutoCollect = true
        while _G.AutoCollect do
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("BasePart") and v.Name == "Resource" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    wait(0.5)
                    fireclickdetector(v:FindFirstChild("ClickDetector"))
                end
            end
            wait()
        end
    else
        _G.AutoCollect = false
    end
end)

-- Auto Sell
AutoFarmSection:NewToggle("Auto Sell", "Automatically sell resources", function(state)
    if state then
        _G.AutoSell = true
        while _G.AutoSell do
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("BasePart") and v.Name == "SellPoint" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    wait(0.5)
                    fireclickdetector(v:FindFirstChild("ClickDetector"))
                end
            end
            wait(1)
        end
    else
        _G.AutoSell = false
    end
end)

-- Visuals tab
local VisualsTab = Window:NewTab("Visuals")
local VisualsSection = VisualsTab:NewSection("Visuals")

-- Fullbright
VisualsSection:NewToggle("Fullbright", "Brighten the game", function(state)
    if state then
        _G.Fullbright = true
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
        game.Lighting.FogEnd = 100000
        game.Lighting.GlobalShadows = false
        game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        _G.Fullbright = false
        game.Lighting.Brightness = 1
        game.Lighting.ClockTime = 0
        game.Lighting.FogEnd = 100
        game.Lighting.GlobalShadows = true
        game.Lighting.Ambient = Color3.fromRGB(0, 0, 0)
    end
end)

-- No Fog
VisualsSection:NewToggle("No Fog", "Remove fog from the game", function(state)
    if state then
        _G.NoFog = true
        game.Lighting.FogEnd = 100000
    else
        _G.NoFog = false
        game.Lighting.FogEnd = 100
    end
end)
-- Player tab
local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Player")

-- God Mode
PlayerSection:NewToggle("God Mode", "Become invincible", function(state)
    if state then
        _G.GodMode = true
        while _G.GodMode do
            if game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.Humanoid.MaxHealth = math.huge
                game.Players.LocalPlayer.Character.Humanoid.Health = math.huge
            end
            wait()
        end
    else
        _G.GodMode = false
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.MaxHealth = 100
            game.Players.LocalPlayer.Character.Humanoid.Health = 100
        end
    end
end)

-- Invisibility
PlayerSection:NewToggle("Invisibility", "Become invisible", function(state)
    if state then
        _G.Invisible = true
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
            end
        end
    else
        _G.Invisible = false
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 0
            end
        end
    end
end)

-- Teleport to Player
PlayerSection:NewDropdown("Teleport to Player", "Teleport to a player", game.Players:GetPlayers(), function(selectedPlayer)
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Name == selectedPlayer then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
        end
    end
end)

-- Misc tab
local MiscTab = Window:NewTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

-- Server Hop
MiscSection:NewButton("Server Hop", "Hop to a new server", function()
    local servers = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data
    for i,v in pairs(servers) do
        if v.id ~= game.JobId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
            break
        end
    end
end)

-- Rejoin
MiscSection:NewButton("Rejoin", "Rejoin the same server", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

-- FPS Boost
MiscSection:NewButton("FPS Boost", "Boost your FPS", function()
    game.Lighting.GlobalShadows = false
    game.Lighting.Brightness = 0
    for i,v in pairs(game.Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
        end
    end
end)
-- Settings tab
local SettingsTab = Window:NewTab("Settings")
local SettingsSection = SettingsTab:NewSection("Settings")

-- Destroy GUI
SettingsSection:NewButton("Destroy GUI", "Destroy the GUI", function()
    Library:Destroy()
end)

-- Toggle GUI
SettingsSection:NewKeybind("Toggle GUI", "Keybind to toggle the GUI", Enum.KeyCode.F, function()
    Library:ToggleUI()
end)

-- Credits tab
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Credits")

CreditsSection:NewLabel("Made by Cepedev & Local")
CreditsSection:NewLabel("Last updated: 12/18/2023")
CreditsSection:NewLabel("Supported games: Universal")

-- Notify the user
Library:Notify("Scylla Scripthub loaded!", 5)

-- End of script
