-- تحميل مكتبة Orion
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- إنشاء نافذة واجهة المستخدم
local Window = OrionLib:MakeWindow({
    Name = "Attack on Titan Hub",
    IntroText = "Welcome to Attack on Titan Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "AttackOnTitanConfig"
})

-- إنشاء تبويب Main
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- إنشاء تبويب Misc
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- إضافة خيارات في تبويب Main
MainTab:AddToggle({
    Name = "Auto Reload Blades/Spears",
    Default = false,
    Callback = function(Value)
        print("[Auto Reload Blades/Spears]: ", Value)
        -- أضف هنا الكود الفعلي لتفعيل/تعطيل إعادة التحميل التلقائي
    end
})

MainTab:AddToggle({
    Name = "Titan ESP",
    Default = false,
    Callback = function(Value)
        print("[Titan ESP]: ", Value)
        -- أضف هنا الكود الفعلي لتفعيل/تعطيل ESP للعمالقة
    end
})

MainTab:AddToggle({
    Name = "Auto Mission (Blades)",
    Default = false,
    Callback = function(Value)
        print("[Auto Mission (Blades)]: ", Value)
        -- أضف هنا الكود الفعلي لتفعيل/تعطيل المهام التلقائية
    end
})

MainTab:AddToggle({
    Name = "Auto Raid (Blades)",
    Default = false,
    Callback = function(Value)
        print("[Auto Raid (Blades)]: ", Value)
        -- أضف هنا الكود الفعلي لتفعيل/تعطيل الغارات التلقائية
    end
})

MainTab:AddToggle({
    Name = "Auto Retry",
    Default = false,
    Callback = function(Value)
        print("[Auto Retry]: ", Value)
        -- أضف هنا الكود الفعلي لتفعيل/تعطيل إعادة المحاولة التلقائية
    end
})

MainTab:AddToggle({
    Name = "Auto Escape Grab",
    Default = false,
    Callback = function(Value)
        print("[Auto Escape Grab]: ", Value)
        -- أضف هنا الكود الفعلي لتفعيل/تعطيل الهروب التلقائي من القبضة
    end
})

MainTab:AddButton({
    Name = "Return to Lobby",
    Callback = function()
        print("Returning to Lobby...")
        -- أضف هنا الكود الفعلي للعودة إلى اللوبي
    end
})

MainTab:AddButton({
    Name = "Force Retry (5 Second Wait)",
    Callback = function()
        print("Forcing Retry with 5-second wait...")
        wait(5)
        print("Retrying...")
        -- أضف هنا الكود الفعلي لإعادة المحاولة
    end
})

-- إضافة خيارات في تبويب Misc
MiscTab:AddToggle({
    Name = "Open Second Raid Chest",
    Default = false,
    Callback = function(Value)
        print("[Open Second Raid Chest]: ", Value)
        -- أضف هنا الكود الفعلي لفتح الصندوق الثاني في الغارة
    end
})

MiscTab:AddButton({
    Name = "Check Shadow Ban",
    Callback = function()
        print("Checking Shadow Ban...")
        -- أضف هنا الكود الفعلي للتحقق من Shadow Ban
    end
})

MiscTab:AddToggle({
    Name = "Nape Extend",
    Default = false,
    Callback = function(Value)
        print("[Nape Extend]: ", Value)
        -- أضف هنا الكود الفعلي لتمديد منطقة Nape
    end
})

MiscTab:AddToggle({
    Name = "Nape Visibility",
    Default = false,
    Callback = function(Value)
        print("[Nape Visibility]: ", Value)
        -- أضف هنا الكود الفعلي لتفعيل/تعطيل رؤية Nape
    end
})

-- عرض إشعار ترحيبي
OrionLib:MakeNotification({
    Name = "Script Loaded!",
    Content = "Attack on Titan Hub has been loaded successfully.",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- تهيئة الواجهة
OrionLib:Init()
