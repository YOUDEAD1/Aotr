-- إنشاء واجهة المستخدم الرئيسية (ScreenGui)
local a = Instance.new("ScreenGui")
a.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")  -- إضافة الواجهة إلى PlayerGui

-- تحديد طريقة التفاعل مع الواجهة
a.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- إنشاء إطار (Frame) داخل الواجهة
local b = Instance.new("Frame")
b.Parent = a
b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- تحديد لون الخلفية
b.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- تحديد لون الحدود
b.BorderSizePixel = 0  -- إزالة حجم الحدود
b.Position = UDim2.new(0.4164823, 0, 0.0479591824, 0)  -- تحديد مكان الإطار
b.Size = UDim2.new(0, 340, 0, 329)  -- تحديد حجم الإطار
b.Style = Enum.FrameStyle.RobloxRound  -- تحديد أسلوب الإطار

-- إضافة نص (TextLabel) لعرض العنوان
local c = Instance.new("TextLabel")
c.Name = "Title"
c.Parent = b
c.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- لون خلفية النص
c.BackgroundTransparency = 1  -- جعل الخلفية شفافة
c.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- تحديد لون الحدود
c.BorderSizePixel = 0  -- إزالة الحدود
c.Position = UDim2.new(0.0207602102, 0, -0.00166114408, 0)  -- تحديد مكان النص
c.Size = UDim2.new(0, 312, 0, 50)  -- تحديد حجم النص
c.Font = Enum.Font.Unknown  -- نوع الخط
c.Text = "Tekkit AotR"  -- النص المعروض
c.TextColor3 = Color3.fromRGB(255, 255, 255)  -- لون النص
c.TextScaled = true  -- جعل النص قابل للتعديل تلقائيًا
c.TextSize = 1  -- حجم النص
c.TextWrapped = true  -- جعل النص ملتفًا إذا لزم الأمر

-- إنشاء Scrollable Frame لعرض عناصر قابلة للتمرير
local d = Instance.new("ScrollingFrame")
d.Parent = b
d.Active = true  -- جعل الإطار قابلًا للتحرك
d.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- لون خلفية الإطار
d.BackgroundTransparency = 1  -- شفافية الخلفية
d.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- تحديد لون الحدود
d.BorderSizePixel = 0  -- إزالة الحدود
d.Position = UDim2.new(0.0415333472, 0, 0.162598208, 0)  -- تحديد مكان الإطار
d.Size = UDim2.new(0, 305, 0, 256)  -- تحديد الحجم
d.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left  -- تحديد مكان شريط التمرير الرأسي

-- إضافة النص "Teleport"
local e = Instance.new("TextLabel")
e.Name = "Teleport"
e.Parent = d
e.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- لون الخلفية
e.BackgroundTransparency = 1  -- جعل الخلفية شفافة
e.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- تحديد لون الحدود
e.BorderSizePixel = 0  -- إزالة الحدود
e.Position = UDim2.new(0.0799999982, 0, 0.0299999993, 0)  -- تحديد مكان النص
e.Size = UDim2.new(0, 200, 0.0599999987, 0)  -- تحديد الحجم
e.Font = Enum.Font.Fondamento  -- نوع الخط
e.Text = "Nape Teleport"  -- النص المعروض
e.TextColor3 = Color3.fromRGB(148, 148, 148)  -- لون النص
e.TextSize = 25  -- حجم النص
e.TextWrapped = true  -- جعل النص ملتفًا إذا لزم الأمر

-- إضافة النص "Titan Farmer"
local f = Instance.new("TextLabel")
f.Name = "Titan Farmer"
f.Parent = d
f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- لون الخلفية
f.BackgroundTransparency = 1  -- شفافية الخلفية
f.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- تحديد لون الحدود
f.BorderSizePixel = 0  -- إزالة الحدود
f.Position = UDim2.new(0.0804597735, 0, 0.104999997, 0)  -- مكان النص
f.Size = UDim2.new(0, 200, 0.0599999987, 0)  -- الحجم
f.Font = Enum.Font.Unknown  -- نوع الخط
f.Text = "Titan Farmer"  -- النص المعروض
f.TextColor3 = Color3.fromRGB(148, 148, 148)  -- لون النص
f.TextSize = 20  -- حجم النص
f.TextWrapped = true  -- لف النص إذا لزم الأمر

-- إضافة زر للتنقل
local g = Instance.new("TextButton")
g.Name = "tpButton"
g.Parent = d
g.BackgroundColor3 = Color3.fromRGB(79, 79, 79)  -- اللون الخلفي للزر
g.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- لون الحدود
g.BorderSizePixel = 2  -- حجم الحدود
g.Position = UDim2.new(0.699999988, 0, 0.0350000001, 0)  -- مكان الزر
g.Size = UDim2.new(0, 30, 0, 30)  -- حجم الزر
g.Font = Enum.Font.SourceSans  -- نوع الخط
g.Text = ""  -- لا يوجد نص على الزر
g.TextColor3 = Color3.fromRGB(0, 0, 0)  -- لون النص
g.TextSize = 14  -- حجم النص

-- إضافة زر آخر لأداء مهمة معينة
local h = Instance.new("TextButton")
h.Name = "tpButtonF"
h.Parent = d
h.BackgroundColor3 = Color3.fromRGB(79, 79, 79)  -- اللون الخلفي
h.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- لون الحدود
h.BorderSizePixel = 2  -- حجم الحدود
h.Position = UDim2.new(0.699999928, 0, 0.10900782, 0)  -- مكان الزر
h.Size = UDim2.new(0, 30, 0, 30)  -- حجم الزر
h.Font = Enum.Font.SourceSans  -- نوع الخط
h.Text = ""  -- لا يوجد نص على الزر
h.TextColor3 = Color3.fromRGB(0, 0, 0)  -- لون النص
h.TextSize = 14  -- حجم النص

-- إضافة زر ثالث
local i = Instance.new("TextButton")
i.Name = "refill"
i.Parent = d
i.BackgroundColor3 = Color3.fromRGB(94, 94, 94)  -- اللون الخلفي
i.BackgroundTransparency = 0.800  -- شفافية الخلفية
i.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- لون الحدود
i.BorderSizePixel = 0  -- إزالة الحدود
i.Position = UDim2.new(0.230000004, 0, 0.264999986, 0)  -- مكان الزر
i.Size = UDim2.new(0, 100, 0, 25)  -- حجم الزر
i.Font = Enum.Font.Unknown  -- نوع الخط
i.Text = "Tp to Refill"  -- النص المعروض
i.TextColor3 = Color3.fromRGB(148, 148, 148)  -- لون النص
i.TextScaled = true  -- جعل النص قابل للتعديل
i.TextSize = 27  -- حجم النص
i.TextWrapped = true  -- لف النص إذا لزم الأمر

-- إضافة نص "Titan ESP"
local j = Instance.new("TextLabel")
j.Name = "esp"
j.Parent = d
j.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- لون الخلفية
j.BackgroundTransparency = 1  -- شفافية الخلفية
j.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- لون الحدود
j.BorderSizePixel = 0  -- إزالة الحدود
j.Position = UDim2.new(0.0542302355, 0, 0.181999996, 0)  -- مكان النص
j.Size = UDim2.new(0, 200, 0.0599999987, 0)  -- الحجم
j.Font = Enum.Font.Unknown  -- نوع الخط
j.Text = "Titan ESP"  -- النص المعروض
j.TextColor3 = Color3.fromRGB(148, 148, 148)  -- لون النص
j.TextSize = 23  -- حجم النص
j.TextWrapped = true  -- لف النص إذا لزم الأمر

-- إضافة زر آخر لتفعيل عمليات إضافية
local k = Instance.new("TextButton")
k.Name = "tpButtonE"
k.Parent = d
k.BackgroundColor3 = Color3.fromRGB(79, 79, 79)  -- لون الخلفية
k.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- لون الحدود
k.BorderSizePixel = 2  -- حجم الحدود
k.Position = UDim2.new(0.699999988, 0, 0.185000002, 0)  -- مكان الزر
k.Size = UDim2.new(0, 30, 0, 30)  -- حجم الزر
k.Font = Enum.Font.SourceSans  -- نوع الخط
k.Text = ""  -- لا يوجد نص على الزر
k.TextColor3 = Color3.fromRGB(0, 0, 0)  -- لون النص
k.TextSize = 14  -- حجم النص

-- جعل الإطار قابلاً للسحب
b.Draggable = true
b.Selectable = true
b.Active = true
