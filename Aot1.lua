local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
local sword = character:FindFirstChild("Blade_1") or character:FindFirstChild("Blade_2") or character:FindFirstChild("Blade_3")

-- توسيع منطقة الناب
local function findNape(hitFolder)
    return hitFolder:FindFirstChild("Nape")
end

local function expandNapeHitbox(hitFolder)
    local napeObject = findNape(hitFolder)
    if napeObject then
        napeObject.Size = Vector3.new(105, 120, 100) -- تكبير حجم الناب
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

-- تنفيذ التوسيع عند بداية اللعبة
print("Titan Nape Expander & Auto Kill Loaded")
local titansBasePart = workspace:FindFirstChild("Titans")
if titansBasePart then
    processTitans(titansBasePart)
end

-- ضرب العمالقة تلقائيًا عند الاقتراب من الناب
local function attackTitan(titan)
    local hitboxesFolder = titan:FindFirstChild("Hitboxes")
    if hitboxesFolder then
        local nape = hitboxesFolder:FindFirstChild("Hit"):FindFirstChild("Nape")
        if nape then
            local distance = (humanoidRootPart.Position - nape.Position).Magnitude
            if distance <= 10 then -- إذا كان اللاعب قريبًا من الناب
                -- قتل العملاق
                titan:Destroy()
                
                -- تشغيل صوت القطع
                local slashSound = Instance.new("Sound", humanoidRootPart)
                slashSound.SoundId = "rbxassetid://142376088" -- يمكنك تغيير الـ ID إلى أي صوت قطع آخر
                slashSound:Play()
                
                -- إزالة الصوت بعد التشغيل
                game:GetService("Debris"):AddItem(slashSound, 2)
            end
        end
    end
end

-- حلقة مستمرة لمهاجمة العمالقة تلقائيًا
game:GetService("RunService").RenderStepped:Connect(function()
    if workspace:FindFirstChild("Titans") then
        for _, titan in ipairs(workspace.Titans:GetChildren()) do
            attackTitan(titan)
        end
    end
end)
