local aimbotActive = false

-- دالة للحصول على موقع اللاعب
function getPlayerPosition()
    -- يجب استبدال هذا بالدالة الصحيحة للحصول على موقع اللاعب
    return {x = 0, y = 0, z = 0}
end

-- دالة للحصول على موقع رأس العدو
function getEnemyHeadPosition(enemy)
    -- يجب استبدال هذا بالدالة الصحيحة للحصول على موقع رأس العدو
    return {x = enemy.x, y = enemy.y, z = enemy.z + 1.8} -- مثال: ارتفاع الرأس
end

-- دالة لحساب المسافة بين موقعين
function calculateDistance(pos1, pos2)
    local dx = pos1.x - pos2.x
    local dy = pos1.y - pos2.y
    local dz = pos1.z - pos2.z
    return math.sqrt(dx*dx + dy*dy + dz*dz)
end

-- دالة لتوجيه السلاح نحو الهدف
function aimAtTarget(target)
    local targetHeadPosition = getEnemyHeadPosition(target)
    local aimAngle = calculateAimAngle(targetHeadPosition)
    setAimAngle(aimAngle)
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

-- دالة التحديث الرئيسية
function update()
    if aimbotActive then
        local closestEnemy = findClosestEnemy()
        if closestEnemy then
            aimAtTarget(closestEnemy)
        end
    end
end

-- ربط الدالة بمفتاح معين (مثال: F1)
bindKey("F1", "toggleAimbot")

-- التحديث المستمر
while true do
    update()
    wait(0) -- تأخير لتجنب استهلاك وحدة المعالجة المركزية بشكل كبير
end
