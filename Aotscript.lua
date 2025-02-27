-- إعدادات السكريبت
local aimbotActive = false
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

-- دالة لتحديد العدو الأقرب
function findClosestEnemy()
    local closestEnemy = nil
    local closestDistance = math.huge
    local myPosition = player.Character and player.Character:FindFirstChild("Head") and player.Character.Head.Position

    if not myPosition then return nil end

    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Team ~= player.Team and otherPlayer.Character then
            local enemyHead = otherPlayer.Character:FindFirstChild("Head")
            if enemyHead then
                local distance = (myPosition - enemyHead.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestEnemy = enemyHead
                end
            end
        end
    end

    return closestEnemy
end

-- دالة لتوجيه السلاح نحو الهدف
function aimAtTarget(target)
    if target then
        local targetPosition = target.Position
        camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
    end
end

-- دالة التشغيل/الإيقاف
function toggleAimbot()
    aimbotActive = not aimbotActive
    if aimbotActive then
        print("Aimbot Activated")
    else
        print("Aimbot Deactivated")
    end
end

-- ربط الدالة بمفتاح معين (مثال: F1)
mouse.KeyDown:Connect(function(key)
    if key == "f1" then
        toggleAimbot()
    end
end)

-- التحديث المستمر
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotActive then
        local closestEnemy = findClosestEnemy()
        if closestEnemy then
            aimAtTarget(closestEnemy)
        end
    end
end)
