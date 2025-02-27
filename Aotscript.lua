local game, workspace = game, workspace
local getrawmetatable, getmetatable, setmetatable, pcall, getgenv, next, tick = getrawmetatable, getmetatable, setmetatable, pcall, getgenv, next, tick
local Vector2new, Vector3zero, CFramenew, Color3fromRGB, Color3fromHSV, Drawingnew, TweenInfonew = Vector2.new, Vector3.zero, CFrame.new, Color3.fromRGB, Color3.fromHSV, Drawing.new, TweenInfo.new
local getupvalue, mousemoverel, tablefind, tableremove, stringlower, stringsub, mathclamp = debug.getupvalue, mousemoverel or (Input and Input.MouseMove), table.find, table.remove, string.lower, string.sub, math.clamp

local GetService = game.GetService
local RunService = GetService(game, "RunService")
local UserInputService = GetService(game, "UserInputService")
local Players = GetService(game, "Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ExunysDeveloperAimbot = {
    Settings = {
        Enabled = true,
        TeamCheck = true, -- تفعيل فحص الفريق لمنع التصويب على الحلفاء
        AliveCheck = true,
        WallCheck = false,
        LockMode = 1,
        LockPart = "Head",
        TriggerKey = Enum.UserInputType.MouseButton2,
        Toggle = false
    },
    FOVSettings = {
        Enabled = true,
        Radius = 90
    },
    Blacklisted = {}
}

local function GetClosestPlayer()
    local RequiredDistance = ExunysDeveloperAimbot.FOVSettings.Radius or 2000
    local ClosestPlayer = nil

    for _, Player in next, Players:GetPlayers() do
        if Player ~= LocalPlayer then
            local Character = Player.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            local Head = Character and Character:FindFirstChild(ExunysDeveloperAimbot.Settings.LockPart)

            if Character and Humanoid and Head then
                -- منع التصويب على الحلفاء
                if ExunysDeveloperAimbot.Settings.TeamCheck and Player.Team == LocalPlayer.Team then
                    continue
                end

                if ExunysDeveloperAimbot.Settings.AliveCheck and Humanoid.Health <= 0 then
                    continue
                end

                local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(Head.Position)
                local Distance = (UserInputService:GetMouseLocation() - Vector2new(ScreenPosition.X, ScreenPosition.Y)).Magnitude

                if Distance < RequiredDistance and OnScreen then
                    RequiredDistance = Distance
                    ClosestPlayer = Player
                end
            end
        end
    end

    return ClosestPlayer
end

local Running = false

local function ToggleAimbot()
    Running = not Running
    if not Running then
        ExunysDeveloperAimbot.Locked = nil
    end
end

UserInputService.InputBegan:Connect(function(Input, Processed)
    if Processed then return end

    -- مفتاح تشغيل/إيقاف السكربت
    if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode == Enum.KeyCode.P then
        ToggleAimbot()
    end

    if Input.UserInputType == ExunysDeveloperAimbot.Settings.TriggerKey then
        Running = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == ExunysDeveloperAimbot.Settings.TriggerKey then
        Running = false
        ExunysDeveloperAimbot.Locked = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if Running and ExunysDeveloperAimbot.Settings.Enabled then
        local Target = GetClosestPlayer()
        if Target and Target.Character then
            local Head = Target.Character:FindFirstChild(ExunysDeveloperAimbot.Settings.LockPart)
            if Head then
                Camera.CFrame = CFramenew(Camera.CFrame.Position, Head.Position)
            end
        end
    end
end)

return ExunysDeveloperAimbot
