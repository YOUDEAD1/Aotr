local Environment = getgenv().ExunysDeveloperAimbot

-- إضافة متغير لتتبع حالة التشغيل/الإيقاف
local isAimbotEnabled = true

-- دالة لتشغيل/إيقاف السكريبت
local function toggleAimbot()
    isAimbotEnabled = not isAimbotEnabled
    if isAimbotEnabled then
        print("Aimbot Enabled")
    else
        print("Aimbot Disabled")
    end
end

-- ربط الدالة بمفتاح معين (مثال: F1)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F1 then
        toggleAimbot()
    end
end)

-- تعديل دالة GetClosestPlayer للتحقق من فريق اللاعب
local function GetClosestPlayer()
    if not isAimbotEnabled then return end

    local Settings = Environment.Settings
    local LockPart = Settings.LockPart

    if not Environment.Locked then
        RequiredDistance = Environment.FOVSettings.Enabled and Environment.FOVSettings.Radius or 2000

        for _, Value in next, GetPlayers(Players) do
            local Character = __index(Value, "Character")
            local Humanoid = Character and FindFirstChildOfClass(Character, "Humanoid")

            if Value ~= LocalPlayer and not tablefind(Environment.Blacklisted, __index(Value, "Name")) and Character and FindFirstChild(Character, LockPart) and Humanoid then
                local PartPosition, TeamCheckOption = __index(Character[LockPart], "Position"), Environment.DeveloperSettings.TeamCheckOption

                -- التحقق من أن اللاعب ليس من فريقك
                if Settings.TeamCheck and __index(Value, TeamCheckOption) == __index(LocalPlayer, TeamCheckOption) then
                    continue
                end

                if Settings.AliveCheck and __index(Humanoid, "Health") <= 0 then
                    continue
                end

                if Settings.WallCheck then
                    local BlacklistTable = GetDescendants(__index(LocalPlayer, "Character"))

                    for _, Value in next, GetDescendants(Character) do
                        BlacklistTable[#BlacklistTable + 1] = Value
                    end

                    if #GetPartsObscuringTarget(Camera, {PartPosition}, BlacklistTable) > 0 then
                        continue
                    end
                end

                local Vector, OnScreen, Distance = WorldToViewportPoint(Camera, PartPosition)
                Vector = ConvertVector(Vector)
                Distance = (GetMouseLocation(UserInputService) - Vector).Magnitude

                if Distance < RequiredDistance and OnScreen then
                    RequiredDistance, Environment.Locked = Distance, Value
                end
            end
        end
    elseif (GetMouseLocation(UserInputService) - ConvertVector(WorldToViewportPoint(Camera, __index(__index(__index(Environment.Locked, "Character"), LockPart), "Position")))).Magnitude > RequiredDistance then
        CancelLock()
    end
end

-- تعديل دالة التحديث الرئيسية
ServiceConnections.RenderSteppedConnection = Connect(__index(RunService, Environment.DeveloperSettings.UpdateMode), function()
    if isAimbotEnabled then
        GetClosestPlayer()
    end
end)
