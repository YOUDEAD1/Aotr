-- تحميل مكتبة Kavo UI لإنشاء واجهة مستخدم رسومية (متوافقة مع Solara)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- استدعاء خدمات Roblox الأساسية للتفاعل مع اللعبة
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- الحصول على اللاعب المحلي (LocalPlayer) والشخصية (Character)
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- متغيرات لتتبع حالة الخيارات (للتحكم في تشغيل/إيقاف الوظائف)
local NapeExpanderEnabled = false -- حالة تكبير الناب
local AutoFarmEnabled = false -- حالة القتل التلقائي
local TitanESPEnabled = false -- حالة تسليط الضوء على العمالقة
local AutoRefillGasEnabled = false -- حالة إعادة تعبئة الغاز تلقائيًا
local AutoHealEnabled = false -- حالة الشفاء التلقائي

-- إعدادات إضافية للتحكم في السكريبت
local FlyHeightAboveTitan = 10 -- الارتفاع فوق الناب أثناء التحليق (وحدات)
local AttackDelay = 1 -- التأخير بين كل هجوم (ثوانٍ)
local SearchDelay = 2 -- التأخير بين كل دورة بحث عن العمالقة (ثوانٍ)
local HealthThreshold = 30 -- الحد الأدنى للصحة قبل الشفاء التلقائي
local GasThreshold = 20 -- الحد الأدنى للغاز قبل إعادة التعبئة
local ESPColor = Color3.fromRGB(255, 0, 0) -- لون تسليط الضوء على العمالقة

-- إنشاء نافذة واجهة المستخدم باستخدام Kavo UI
local Window = Library.CreateLib("Attack on Titan Ultimate Hub", "DarkTheme")

-- إنشاء تبويب رئيسي (Main) لوضع الخيارات الأساسية
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Core Features")

-- إنشاء تبويب إضافي (Utility) لوضع الميزات الإضافية
local UtilityTab = Window:NewTab("Utility")
local UtilitySection = UtilityTab:NewSection("Utility Features")

-- تحديث الشخصية (Character) عند إعادة الإنشاء (مثل الموت وإعادة الظهور)
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    Humanoid = Character:WaitForChild("Humanoid")
    print("Character updated successfully:", Character.Name)
end)

-- وظيفة للبحث عن العمالقة في مجلد Titans داخل Workspace
local function GetTitans()
    local titans = {}
    local titansBasePart = Workspace:FindFirstChild("Titans")
    if titansBasePart then
        for _, titan in pairs(titansBasePart:GetChildren()) do
            if titan:FindFirstChild("Humanoid") and titan:FindFirstChild("Nape") then
                table.insert(titans, titan)
            end
        end
    else
        print("Warning: Titans folder not found in Workspace!")
    end
    return titans
end

-- وظيفة لتكبير الناب (Nape Expander)
local function FindNape(hitFolder)
    -- التحقق مما إذا كان الناب موجودًا داخل مجلد Hit
    return hitFolder:FindFirstChild("Nape")
end

local function ExpandNapeHitbox(hitFolder)
    -- تكبير الناب وتغيير خصائصه البصرية
    local napeObject = FindNape(hitFolder)
    if napeObject then
        print("Expanding Nape for:", hitFolder.Parent.Parent.Name)
        napeObject.Size = Vector3.new(105, 120, 100) -- تكبير حجم الناب
        napeObject.Transparency = 0.96 -- جعل الناب شبه شفاف
        napeObject.Color = Color3.new(1, 1, 1) -- تغيير اللون إلى أبيض
        napeObject.Material = Enum.Material.Neon -- إضافة تأثير نيون
        napeObject.CanCollide = false -- تعطيل الاصطدام
        napeObject.Anchored = false -- السماح للناب بالتحرك مع العملاق
    else
        print("Nape not found in:", hitFolder:GetFullName())
    end
end

local function ProcessTitans(titansBasePart)
    -- معالجة جميع العمالقة في المجلد لتكبير الناب
    for _, titan in ipairs(titansBasePart:GetChildren()) do
        local hitboxesFolder = titan:FindFirstChild("Hitboxes")
        if hitboxesFolder then
            local hitFolder = hitboxesFolder:FindFirstChild("Hit")
            if hitFolder then
                ExpandNapeHitbox(hitFolder)
            else
                print("Hit folder not found in:", hitboxesFolder:GetFullName())
            end
        else
            print("Hitboxes folder not found in:", titan.Name)
        end
    end
end

-- وظيفة لتسليط الضوء على العمالقة (Titan ESP)
local ESPInstances = {}
local function CreateESP(target)
    if ESPInstances[target] then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(2, 0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.Adornee = target
    billboard.Parent = target

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = ESPColor
    frame.Parent = billboard

    ESPInstances[target] = billboard
    print("ESP created for:", target.Name)
end

local function RemoveESP(target)
    if ESPInstances[target] then
        ESPInstances[target]:Destroy()
        ESPInstances[target] = nil
        print("ESP removed for:", target.Name)
    end
end

-- وظيفة للتأكد من تجهيز الشفرات
local function EquipBlades()
    -- التحقق مما إذا كان اللاعب يحمل الشفرات بالفعل
    local tool = Character:FindFirstChildOfClass("Tool")
    if tool and tool.Name:lower():find("blade") then
        print("Blades already equipped:", tool.Name)
        return true
    else
        -- البحث عن الشفرات في المخزون (Backpack)
        for _, item in pairs(LocalPlayer.Backpack:GetChildren()) do
            if item:IsA("Tool") and item.Name:lower():find("blade") then
                item.Parent = Character
                print("Equipped Blades:", item.Name)
                return true
            end
        end
    end
    print("No Blades found in inventory!")
    return false
end

-- وظيفة للتحليق فوق العملاق ومهاجمة الناب
local function AttackNape(titan)
    local nape = titan:FindFirstChild("Nape")
    if nape and EquipBlades() then
        print("Targeting Nape of:", titan.Name)
        -- التحليق فوق الناب بارتفاع محدد
        local targetPos = nape.Position + Vector3.new(0, FlyHeightAboveTitan, 0)
        HumanoidRootPart.CFrame = CFrame.new(targetPos, nape.Position)
        wait(0.5)

        -- محاكاة الهجوم باستخدام الشفرات
        local tool = Character:FindFirstChildOfClass("Tool")
        if tool then
            print("Attacking with:", tool.Name)
            tool:Activate() -- تفعيل الشفرات للهجوم
            wait(0.5)
            -- إلحاق الضرر مباشرة (في حالة فشل الهجوم الطبيعي)
            local titanHumanoid = titan:FindFirstChild("Humanoid")
            if titanHumanoid then
                titanHumanoid:TakeDamage(100) -- إلحاق ضرر كبير
                print("Dealt 100 damage to:", titan.Name)
            else
                print("No Humanoid found in:", titan.Name)
            end
        else
            print("No tool equipped for attack!")
        end
    else
        print("Nape not found or Blades not equipped for:", titan.Name)
    end
end

-- وظيفة لإعادة تعبئة الغاز تلقائيًا
local function RefillGas()
    -- افتراض أن هناك RemoteEvent لإعادة تعبئة الغاز
    local success, response = pcall(function()
        return ReplicatedStorage:FindFirstChild("RefillGasEvent"):FireServer()
    end)
    if success then
        print("Gas refilled successfully!")
    else
        print("Failed to refill gas. Event not found or error occurred.")
    end
end

-- وظيفة للشفاء التلقائي
local function HealPlayer()
    -- افتراض أن هناك RemoteEvent للشفاء
    local success, response = pcall(function()
        return ReplicatedStorage:FindFirstChild("HealPlayerEvent"):FireServer()
    end)
    if success then
        print("Player healed successfully!")
    else
        print("Failed to heal player. Event not found or error occurred.")
    end
end

-- خيار: تفعيل تكبير الناب
MainSection:NewToggle("Nape Expander", "Expand Nape hitbox for easier kills", function(state)
    NapeExpanderEnabled = state
    print("Nape Expander toggled to:", state)
    if NapeExpanderEnabled then
        local titansBasePart = Workspace:FindFirstChild("Titans")
        if titansBasePart then
            ProcessTitans(titansBasePart)
            -- مراقبة التغييرات (إضافة عمالقة جدد)
            spawn(function()
                while NapeExpanderEnabled do
                    print("Checking for new Titans to expand Nape...")
                    ProcessTitans(titansBasePart)
                    wait(5)
                end
            end)
        else
            print("Titans folder not found in Workspace!")
        end
    end
end)

-- خيار: القتل التلقائي (Auto Farm)
MainSection:NewToggle("Auto Farm Titans", "Fly above Titans and kill them with blades", function(state)
    AutoFarmEnabled = state
    print("Auto Farm toggled to:", state)
    if AutoFarmEnabled then
        spawn(function()
            while AutoFarmEnabled and Character and Humanoid.Health > 0 do
                print("Searching for Titans to kill...")
                local titans = GetTitans()
                for _, titan in pairs(titans) do
                    if titan:FindFirstChild("Humanoid") and titan.Humanoid.Health > 0 then
                        print("Found Titan:", titan.Name)
                        AttackNape(titan)
                        wait(AttackDelay)
                    else
                        print("Skipping Titan (dead or invalid):", titan.Name)
                    end
                end
                wait(SearchDelay)
            end
            print("Auto Farm stopped.")
        end)
    end
end)

-- خيار: تسليط الضوء على العمالقة (Titan ESP)
MainSection:NewToggle("Titan ESP", "Highlight Titans for better visibility", function(state)
    TitanESPEnabled = state
    print("Titan ESP toggled to:", state)
    if TitanESPEnabled then
        spawn(function()
            while TitanESPEnabled do
                print("Updating ESP for Titans...")
                for _, titan in pairs(GetTitans()) do
                    CreateESP(titan)
                end
                wait(1)
            end
        end)
    else
        print("Removing ESP from Titans...")
        for _, titan in pairs(GetTitans()) do
            RemoveESP(titan)
        end
    end
end)

-- خيار: إعادة تعبئة الغاز تلقائيًا
UtilitySection:NewToggle("Auto Refill Gas", "Automatically refill ODM gas", function(state)
    AutoRefillGasEnabled = state
    print("Auto Refill Gas toggled to:", state)
    if AutoRefillGasEnabled then
        spawn(function()
            while AutoRefillGasEnabled and Character and Humanoid.Health > 0 do
                -- افتراض أن هناك قيمة Gas في الشخصية
                local gasValue = Character:FindFirstChild("GasValue") and Character.GasValue.Value or 100
                print("Current Gas Level:", gasValue)
                if gasValue <= GasThreshold then
                    print("Gas below threshold! Refilling...")
                    RefillGas()
                end
                wait(5)
            end
            print("Auto Refill Gas stopped.")
        end)
    end
end)

-- خيار: الشفاء التلقائي
UtilitySection:NewToggle("Auto Heal", "Automatically heal when health is low", function(state)
    AutoHealEnabled = state
    print("Auto Heal toggled to:", state)
    if AutoHealEnabled then
        spawn(function()
            while AutoHealEnabled and Character and Humanoid.Health > 0 do
                print("Checking health for Auto Heal...")
                if Humanoid.Health <= HealthThreshold then
                    print("Health below threshold! Healing...")
                    HealPlayer()
                end
                wait(5)
            end
            print("Auto Heal stopped.")
        end)
    end
end)

-- إضافة زر لعرض حالة السكريبت
UtilitySection:NewButton("Show Script Status", "Display current status of all features", function()
    print("===== Attack on Titan Ultimate Hub Status =====")
    print("Nape Expander Enabled:", NapeExpanderEnabled)
    print("Auto Farm Enabled:", AutoFarmEnabled)
    print("Titan ESP Enabled:", TitanESPEnabled)
    print("Auto Refill Gas Enabled:", AutoRefillGasEnabled)
    print("Auto Heal Enabled:", AutoHealEnabled)
    print("Current Health:", Humanoid.Health)
    print("Current Gas (Assumed):", Character:FindFirstChild("GasValue") and Character.GasValue.Value or "Unknown")
    print("===========================================")
end)

-- رسالة ترحيبية عند تحميل السكريبت
print("===== Attack on Titan Ultimate Hub Loaded Successfully! =====")
print("Features:")
print("- Nape Expander: Expand Titan Nape hitboxes for easier kills")
print("- Auto Farm: Fly above Titans and kill them automatically with blades")
print("- Titan ESP: Highlight Titans for better visibility")
print("- Auto Refill Gas: Automatically refill ODM gear gas")
print("- Auto Heal: Automatically heal when health is low")
print("Use the UI to toggle features and check status.")
print("====================================================")
