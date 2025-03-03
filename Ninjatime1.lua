-- Scylla Scripthub Loader (Decoded) with Auto Quest

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Anti AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Load external scripts
local v12 = loadstring(game:HttpGet("https://raw.githubusercontent.com/acezqqq/Scylla/main/NinjaTime.lua"))()
local v13 = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local v14 = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kohl-Admin/main/source.lua"))()
local v15 = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/notification-lib/main/source.lua"))()

-- Create the main window using Kavo UI
local window = v12:CreateWindow({
    Theme = "DarkTheme Scyll",
    Pos = "Scylla",
    Size = 160,
    Pos = UDim2.fromOffset(580, 460),
    Draggable = true,
    ToggleKey = "LeftAlt",
    ToggleKey = Enum.KeyCode.LeftAlt
})

-- Create tabs
local tabs = {
    Main = window:AddTab({ Title = "Main", Icon = "rbxassetid://3926305904" }),
    Player = window:AddTab({ Title = "Player", Icon = "" }),
    Teleport = window:AddTab({ Title = "Teleport", Icon = "" }),
    Spins = window:AddTab({ Title = "Spins", Icon = "" }),
    Main = window:AddTab({ Title = "Main", Icon = "" }),
    Info = window:AddTab({ Title = "Info", Icon = "" }),
    Misc = window:AddTab({ Title = "Misc", Icon = "" }),
    Settings = window:AddTab({ Title = "Settings", Icon = "rbxassetid://6022668955" })
}

-- Info Section
local infoSection = tabs.Info:AddSection("Info")
tabs.Info:AddButton({
    Title = "Copy Discord",
    Description = "Copy Discord Invite Link",
    Callback = function()
        setclipboard("https://discord.gg/Scylla")
        print("Copied to clipboard! Join discord")
    end
})

local infoSection = tabs.Info:AddSection("Updates")
tabs.Info:AddParagraph({
    Title = "Updates",
    Content = "**Chakra** \n[+] Added Auto Chakra Charge\n**Spins** \n[+] ADDED AUTO SPINS \n[+] ADDED INF SPINS! (diffrent script join discord!)"
})

-- Player Section: Walkspeed
local playerSection = tabs.Player:AddSection("Walkspeed")
local player = game.Players.LocalPlayer
local infJump = false
local walkSpeed = 16
local runService = game:GetService("RunService")
local connection

local function setWalkSpeed()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = walkSpeed
    end
end

local function monitorWalkSpeed()
    if connection then connection:Disconnect() end
    connection = runService.Heartbeat:Connect(function()
        if infJump then setWalkSpeed() end
    end)
end

tabs.Player:AddToggle("InfiniteJump", {
    Title = "Walkspeed",
    Description = "Change your walkspeed",
    Value = false,
    Callback = function(state)
        infJump = state
        if infJump then
            monitorWalkSpeed()
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.WalkSpeed = 16
            end
        end
    end
})

tabs.Player:AddSlider("Walkspeed", {
    Title = "Walkspeed",
    Description = "Change your walkspeed",
    Min = 16,
    Max = 16,
    Max = 500,
    Increment = 1,
    Callback = function(value)
        walkSpeed = value
        setWalkSpeed()
    end
})

-- Player Section: JumpPower
local playerSection = tabs.Player:AddSection("JumpPower")
tabs.Player:AddSlider("JumpPower", {
    Title = "JumpPower",
    Description = "Change your jump power",
    Min = 50,
    Max = 0,
    Max = 400,
    Increment = 1,
    Callback = function(value)
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
            print("Jump power set to", value)
        end
    end
})

-- Player Section: Fly
local playerSection = tabs.Player:AddSection("Fly")
local flying = false
local flySpeed = 16

local function startFly()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")
        humanoid.PlatformStand = true
        rootPart.Anchored = true
        local cfLoop
        cfLoop = runService.Heartbeat:Connect(function(delta)
            local moveDirection = humanoid.MoveDirection * flySpeed * delta
            local cf = rootPart.CFrame
            local camera = workspace.CurrentCamera.CFrame
            local cameraPos = cf:ToObjectSpace(camera).Position
            camera = camera * CFrame.new(-cameraPos.X, -cameraPos.Y, -cameraPos.Z + 1)
            local cameraPosFinal = camera.Position
            local rootPos = cf.Position
            local lookDirection = CFrame.new(cameraPosFinal, Vector3.new(rootPos.X, cameraPosFinal.Y, rootPos.Z)):VectorToObjectSpace(moveDirection)
            rootPart.CFrame = CFrame.new(rootPos) * (camera - cameraPosFinal) * CFrame.new(lookDirection)
        end)
    end
end

local function stopFly()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoid then humanoid.PlatformStand = false end
        if rootPart then rootPart.Anchored = false end
    end
    if cfLoop then
        cfLoop:Disconnect()
        cfLoop = nil
    end
end

tabs.Player:AddToggle("Fly", {
    Title = "Fly",
    Description = "Allows you to fly",
    Value = false,
    Callback = function(state)
        flying = state
        if flying then
            startFly()
        else
            stopFly()
        end
    end
})

tabs.Player:AddSlider("FlySpeed", {
    Title = "FlySpeed",
    Description = "Change your fly speed",
    Min = 16,
    Max = 0,
    Max = 500,
    Increment = 1,
    Callback = function(value)
        if type(value) == "number" then
            flySpeed = value
        end
    end
})

-- Player Section: Infinite Jump
local playerSection = tabs.Player:AddSection("InfiniteJump")
local infJumpEnabled = false

local function enableInfJump()
    if _G.infinJumpStarted == nil then
        _G.infinJumpStarted = true
        game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
            if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.Space then
                if infJumpEnabled then
                    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        wait()
                        humanoid:ChangeState(Enum.HumanoidStateType.Seated)
                    end
                end
            end
        end)
    end
end

tabs.Player:AddToggle("InfiniteJump", {
    Title = "InfiniteJump",
    Description = "Jump infinitely",
    Value = false,
    Callback = function(state)
        infJumpEnabled = state
        enableInfJump()
    end
})

-- Player Section: FOV
local playerSection = tabs.Player:AddSection("FOV")
tabs.Player:AddSlider("FOV", {
    Title = "FOV",
    Description = "Change your FOV",
    Min = 70,
    Max = 0,
    Max = 120,
    Increment = 1,
    Callback = function(value)
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            game:GetService("Workspace").CurrentCamera.FieldOfView = value
            print("FOV set to", value)
        end
    end
})

-- Player Section: NoClip
local playerSection = tabs.Player:AddSection("NoClip")
local noClipEnabled = false
local collisionStates = {}

local function toggleNoClip(character, enable)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            if enable then
                collisionStates[part] = part.CanCollide
                part.CanCollide = false
            elseif collisionStates[part] ~= nil then
                part.CanCollide = collisionStates[part]
            end
        end
    end
end

local function manageNoClip(state)
    local character = player.Character
    if character then
        toggleNoClip(character, state)
    end
end

tabs.Player:AddToggle("NoClip", {
    Title = "NoClip",
    Description = "Walk through walls",
    Value = false,
    Callback = function(state)
        noClipEnabled = state
        if noClipEnabled then
            manageNoClip(true)
        else
            manageNoClip(false)
            collisionStates = {}
        end
    end
})

if player.Character then
    toggleNoClip(player.Character, noClipEnabled)
end

-- Player Section: Auto Charge Chakra
local playerSection = tabs.Player:AddSection("Auto Charge Chakra")
_G.AutoChargeChakra = false
_G.ChargeDelay = 0.5

tabs.Player:AddToggle("AutoChargeChakra", {
    Title = "AutoChargeChakra",
    Description = "Automatically charges chakra",
    Value = false,
    Callback = function(state)
        _G.AutoChargeChakra = state
        if state then
            print("AutoChargeChakra started")
            spawn(function()
                while _G.AutoChargeChakra do
                    local args = {
                        [1] = "ChargeChakra",
                        [2] = true,
                        [3] = false
                    }
                    game:GetService("ReplicatedStorage").Modules.Services.RNet.Bridges.GameplayEvent_Event:FireServer(args)
                    wait(_G.ChargeDelay)
                end
            end)
        else
            print("AutoChargeChakra stopped")
        end
    end
})

tabs.Player:AddInput("ChargeDelayInput", {
    Title = "Charge Delay",
    Description = "Input chakra cooldown (0.1 - 0.5)",
    Value = "0.1",
    Default = "0.1",
    Numeric = true,
    ShowClear = false,
    Callback = function(value)
        local numValue = tonumber(value)
        if numValue and numValue >= 0.1 and numValue <= 0.5 then
            _G.ChargeDelay = numValue
            print("Charge delay set to", numValue)
        else
            print("Invalid input! Please enter a number between 0.1 and 0.5")
        end
    end
})

-- Teleport Section: Teleport to Player/NPC
local teleportSection = tabs.Teleport:AddSection("Teleport to Player/NPC")
local playerDropdown = tabs.Teleport:AddDropdown("PlayerDropdown", {
    Title = "Players",
    Description = "Select a player to teleport to",
    Values = {},
    Multi = false,
    Default = 1,
    Callback = function()
        -- Callback will be defined below
    end
})

local npcDropdown = tabs.Teleport:AddDropdown("NPCDropdown", {
    Title = "NPCs",
    Description = "Select an NPC to teleport to",
    Values = {},
    Multi = false,
    Default = 1,
    Callback = function()
        -- Callback will be defined below
    end
})

local function updatePlayerDropdown()
    local players = {}
    for _, player in ipairs(game.Players:GetChildren()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    playerDropdown:SetValues(players)
end

local function updateNPCDropdown()
    local npcs = {}
    local npcFolder = workspace:WaitForChild("NPCs")
    for _, npc in ipairs(npcFolder:GetChildren()) do
        if npc.Name ~= "Target" then
            table.insert(npcs, npc.Name)
        end
    end
    npcDropdown:SetValues(npcs)
end

updatePlayerDropdown()
updateNPCDropdown()

playerDropdown.Callback = function(playerName)
    local targetPlayer = game.Players:FindFirstChild(playerName)
    if targetPlayer then
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local targetCharacter = targetPlayer.Character
            if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = targetCharacter.HumanoidRootPart.CFrame
            end
        end
    else
        print("Target not found")
    end
end

npcDropdown.Callback = function(npcName)
    local npc = workspace.NPCs:FindFirstChild(npcName)
    if npc then
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
        end
    else
        print("NPC not found")
    end
end

tabs.Teleport:AddButton({
    Title = "Respawn",
    Description = "Respawn at 0,0,0 then tele back",
    Callback = function()
        local playersService = game:GetService("Players")
        local userInputService = game:GetService("UserInputService")
        local localPlayer = playersService.LocalPlayer
        local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local camera = workspace.CurrentCamera
        
        local originalCFrame = character.PrimaryPart.CFrame
        print("Teleporting to 0,0,0")
        character:SetPrimaryPartCFrame(CFrame.new(0, originalCFrame.Y, 0))
        wait(10)
        print("Teleported back to original position")
        character:SetPrimaryPartCFrame(originalCFrame)
    end
})

-- Main Section: Auto Farming
local mainSection = tabs.Main:AddSection("Auto Farming")
local instantKillEnabled = false
local killRange = 50

local function applyInstantKill(enemy)
    if enemy and enemy.Health > 0 then
        enemy:TakeDamage(enemy.Health)
    end
end

local function checkNearbyMobs()
    while instantKillEnabled do
        for _, enemy in pairs(game:GetService("ReplicatedStorage").Entities:GetChildren()) do
            if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Name ~= game.Players.LocalPlayer.Name then
                local humanoid = enemy:FindFirstChild("Humanoid")
                local rootPart = enemy:FindFirstChild("HumanoidRootPart")
                if humanoid and rootPart then
                    local playerCharacter = game.Players.LocalPlayer.Character
                    if playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart") then
                        local distance = (rootPart.Position - playerCharacter.HumanoidRootPart.Position).Magnitude
                        if distance <= killRange then
                            applyInstantKill(humanoid)
                        end
                    end
                end
            end
        end
        wait(0.5)
    end
end

tabs.Main:AddToggle("InstantKill", {
    Title = "InstantKill",
    Description = "Kills enemies instantly",
    Value = false,
    Callback = function(state)
        instantKillEnabled = state
        if state then
            checkNearbyMobs()
        else
            instantKillEnabled = false
        end
    end
})

-- New Feature: Auto Quest (Added to Main Section)
local mainSection = tabs.Main:AddSection("Quest Automation")
local autoQuestEnabled = false

-- Function to accept a new quest
local function acceptQuest()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    -- Assuming quests are managed via a RemoteEvent in ReplicatedStorage
    -- This may need to be adjusted based on the actual game structure
    local questEvent = replicatedStorage:FindFirstChild("QuestEvent") -- Replace with the actual RemoteEvent name
    if questEvent then
        questEvent:FireServer("AcceptQuest")
        print("Accepted a new quest")
    else
        print("QuestEvent not found. Please check the game structure.")
    end
end

-- Function to complete the current quest
local function completeQuest()
    local replicatedStorage = game:GetService("ReplicatedStorage")
    -- Assuming quest completion is managed via a RemoteEvent
    local questEvent = replicatedStorage:FindFirstChild("QuestEvent") -- Replace with the actual RemoteEvent name
    if questEvent then
        questEvent:FireServer("CompleteQuest")
        print("Completed the current quest")
    else
        print("QuestEvent not found. Please check the game structure.")
    end
end

-- Function to check if the current quest is completed
local function isQuestCompleted()
    -- This is a placeholder. You'll need to adjust this based on the actual game
    -- For example, check if the quest objectives (e.g., kill enemies, collect items) are done
    -- For now, we'll assume the quest is completed if there are no enemies nearby (using InstantKill logic)
    local enemiesNearby = false
    for _, enemy in pairs(game:GetService("ReplicatedStorage").Entities:GetChildren()) do
        if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Name ~= game.Players.LocalPlayer.Name then
            local humanoid = enemy:FindFirstChild("Humanoid")
            local rootPart = enemy:FindFirstChild("HumanoidRootPart")
            if humanoid and rootPart then
                local playerCharacter = game.Players.LocalPlayer.Character
                if playerCharacter and playerCharacter:FindFirstChild("HumanoidRootPart") then
                    local distance = (rootPart.Position - playerCharacter.HumanoidRootPart.Position).Magnitude
                    if distance <= killRange then
                        enemiesNearby = true
                        break
                    end
                end
            end
        end
    end
    return not enemiesNearby -- Quest is considered completed if no enemies are nearby
end

-- Main Auto Quest function
local function autoQuest()
    while autoQuestEnabled do
        -- Step 1: Accept a new quest
        acceptQuest()
        -- Step 2: Wait until the quest is completed
        while autoQuestEnabled and not isQuestCompleted() do
            -- Ensure InstantKill is enabled to kill enemies and complete the quest
            if not instantKillEnabled then
                instantKillEnabled = true
                checkNearbyMobs()
            end
            wait(1) -- Check every second
        end
        -- Step 3: Complete the quest
        completeQuest()
        -- Step 4: Wait a bit before accepting the next quest
        wait(2) -- Adjust this delay as needed
    end
end

-- Add Auto Quest toggle to the Main tab
tabs.Main:AddToggle("AutoQuest", {
    Title = "AutoQuest",
    Description = "Automatically accepts and completes quests",
    Value = false,
    Callback = function(state)
        autoQuestEnabled = state
        if state then
            print("AutoQuest started")
            autoQuest()
        else
            print("AutoQuest stopped")
            autoQuestEnabled = false
            -- Optionally stop InstantKill if it was enabled by AutoQuest
            if instantKillEnabled then
                instantKillEnabled = false
            end
        end
    end
})

-- Main Section: Entity Farming (Original)
local mainSection = tabs.Main:AddSection("Entity Farming")
local entityDropdown = tabs.Main:AddDropdown("EntityDropdown", {
    Title = "Entities",
    Description = "Select an entity to farm",
    Values = {},
    Multi = false,
    Default = 1,
    Callback = function()
        -- Callback defined below
    end
})

local positionDropdown = tabs.Main:AddDropdown("PositionDropdown", {
    Title = "Position",
    Description = "Select position relative to entity",
    Values = { "Behind", "Above", "Below" },
    Multi = false,
    Default = 1,
    Callback = function()
        -- Callback defined below
    end
})

local autoFarmEnabled = false

tabs.Main:AddToggle("AutoFarm", {
    Title = "AutoFarm",
    Description = "Automatically farms entities",
    Value = false,
    Callback = function(state)
        if state then
            startAutofarming()
        else
            stopAutofarming()
        end
    end
})

tabs.Main:AddButton({
    Title = "UpdateEntities",
    Description = "Update the entity dropdown",
    Callback = function()
        updateEntityDropdown()
    end
})

-- Misc Section
tabs.Misc:AddButton({
    Title = "ServerHop",
    Description = "Hop to a new server",
    Callback = function()
        local httpService = game:GetService("HttpService")
        local teleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        local jobId = game.JobId
        local servers = httpService:JSONDecode(game:HttpGet(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100", placeId))).data
        local serverIds = {}
        for _, server in pairs(servers) do
            if server.id ~= jobId and server.playing < server.maxPlayers then
                table.insert(serverIds, server.id)
            end
        end
        if #serverIds > 0 then
            local randomServer = serverIds[math.random(1, #serverIds)]
            teleportService:TeleportToPlaceInstance(placeId, randomServer, game.Players.LocalPlayer)
        else
            print("Serverhop: Couldn't find a suitable server.")
        end
    end
})

tabs.Misc:AddButton({
    Title = "Rejoin",
    Description = "Rejoin the same server",
    Callback = function()
        local playersService = game:GetService("Players")
        local teleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        local jobId = game.JobId
        if #playersService:GetPlayers() <= 1 then
            playersService.LocalPlayer:Kick("\nRejoining...")
            wait()
            teleportService:Teleport(placeId, playersService.LocalPlayer)
        else
            teleportService:TeleportToPlaceInstance(placeId, jobId, playersService.LocalPlayer)
        end
    end
})

tabs.Misc:AddButton({
    Title = "FPSBoost",
    Description = "Boost your FPS",
    Callback = function()
        local playersService = game:GetService("Players")
        local lightingService = game:GetService("Lighting")
        local localPlayer = playersService.LocalPlayer
        local function fpsBoost()
            local character = localPlayer.Character
            if character and character.PrimaryPart then
                local originalCFrame = character.PrimaryPart.CFrame
                print("Teleporting to 0,0,0")
                character:SetPrimaryPartCFrame(CFrame.new(0, originalCFrame.Y, 0))
                wait(10)
                print("Teleported back to original position")
                character:SetPrimaryPartCFrame(originalCFrame)
            else
                warn("No character found. Unable to teleport")
            end
        end
        fpsBoost()
    end
})

-- Configure Kavo UI and Notification Libraries
v13:SetLibrary(v12)
v14:SetLibrary(v12)
v13:IgnoreThemeSettings()
v13:SetIgnoreIndexes({})
v14:SetFolder("Scylla")
v13:SetFolder("Scylla/Kavo")
v14:BuildInterfaceSection(tabs.Settings)
v13:BuildConfigSection(tabs.Settings)
window:SelectTab(1)

-- Show a notification
v12:Notify({
    Title = "Loaded",
    Description = "Scylla Scripthub loaded successfully!",
    Duration = 8
})

-- Load autoload config
v13:LoadAutoloadConfig()
