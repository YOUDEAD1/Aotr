-- إعدادات اللاعب
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- الوظائف العامة
getgenv().AutoKill = false
getgenv().AutoEscape = false
getgenv().AutoReplaceBlade = false
getgenv().AutoGas = false
getgenv().SpeedBoost = false

-- توسيع هيت بوكس نقطة النحر
local function expandNapeHitbox(hitFolder)
    local napeObject = hitFolder:FindFirstChild("Nape")
    if napeObject then
        napeObject.Size = Vector3.new(105, 120, 100)
        napeObject.Transparency = 0.96
        napeObject.Color = Color3.new(1, 1, 1)
        napeObject.Material = Enum.Material.Neon
        napeObject.CanCollide = false
        napeObject.Anchored = false
    end
end

local function processTitans()
    local titansBasePart = Workspace:FindFirstChild("Titans")
    if titansBasePart then
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
end

-- تفعيل أو تعطيل Auto Kill
function toggleAutoKill()
    getgenv().AutoKill = not getgenv().AutoKill
    while getgenv().AutoKill do
        processTitans()
        wait(1)
    end
end

-- تفعيل أو تعطيل Auto Escape
function toggleAutoEscape()
    getgenv().AutoEscape = not getgenv().AutoEscape
    while getgenv().AutoEscape do
        for _, button in pairs(LocalPlayer.PlayerGui.Interface.Buttons:GetChildren()) do
            if button then
                button:Click() -- افترض أن الزر يمكن النقر عليه
            end
        end
        wait(0.3)
    end
end

-- تفعيل أو تعطيل Auto Replace Blade
function toggleAutoReplaceBlade()
    getgenv().AutoReplaceBlade = not getgenv().AutoReplaceBlade
    while getgenv().AutoReplaceBlade do
        for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
            if tool:IsA("Tool") and tool:GetAttribute("Broken") then
                keypress(0x52) -- مفتاح R
            end
        end
        wait(1)
    end
end

-- تفعيل أو تعطيل Auto Gas
function toggleAutoGas()
    getgenv().AutoGas = not getgenv().AutoGas
    while getgenv().AutoGas do
        local gasMeter = LocalPlayer.PlayerGui:FindFirstChild("GasMeter")
        if gasMeter and gasMeter.Value <= 10 then
            keypress(0x47) -- مفتاح G
        end
        wait(1)
    end
end

-- ربط الوظائف بالأزرار
toggleAutoKill() -- لتفعيل/تعطيل Auto Kill
toggleAutoEscape() -- لتفعيل/تعطيل Auto Escape
toggleAutoReplaceBlade() -- لتفعيل/تعطيل Auto Replace Blade
toggleAutoGas() -- لتفعيل/تعطيل Auto Gas

print("✅ AOTR Script Loaded!")
