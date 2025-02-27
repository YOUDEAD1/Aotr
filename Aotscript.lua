local VIM = game:GetService("VirtualInputManager")
local workspace = game:GetService("Workspace")

-- Auto Escape (معدل)
getgenv().autoescape = true
task.spawn(function()
    while getgenv().autoescape do
        local buttons = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Interface") and game.Players.LocalPlayer.PlayerGui.Interface:FindFirstChild("Buttons")
        if buttons then
            for _, v in pairs(buttons:GetChildren()) do
                if v and v:IsA("TextButton") then
                    VIM:SendKeyEvent(true, string.lower(v.Text), false, game)
                end
            end
        end
        task.wait(0.3)
    end
end)

-- Auto Replace Blade (معدل)
getgenv().autor = true
task.spawn(function()
    while getgenv().autor do
        local character = game.Players.LocalPlayer.Character
        if character then
            for _, v in pairs(character:GetChildren()) do
                if v:IsA("Tool") then
                    for _, v2 in pairs(v:GetChildren()) do
                        if v2.Name == "Blade_1" and v2:GetAttribute("Broken") == true then
                            VIM:SendKeyEvent(true, "r", false, game)
                        end
                    end
                end
            end
        end
        task.wait(1)
    end
end)

-- Nape Attacker (معدل)
local function findNape(titan)
    local hitboxesFolder = titan:FindFirstChild("Hitboxes")
    if hitboxesFolder then
        local hitFolder = hitboxesFolder:FindFirstChild("Hit")
        if hitFolder then
            return hitFolder:FindFirstChild("Nape")
        end
    end
    return nil
end

local function attackNape(titan)
    local napeObject = findNape(titan)
    if napeObject then
        print("Attacking Nape of:", titan.Name)
        napeObject.Color = Color3.new(1, 0, 0)
        task.wait(1)
        napeObject.Color = Color3.new(1, 1, 1)
    else
        print("Nape not found for:", titan.Name)
    end
end

local function processTitans(titansBasePart)
    if titansBasePart then
        for _, titan in ipairs(titansBasePart:GetChildren()) do
            if titan:IsA("Model") then
                attackNape(titan)
            end
        end
    end
end

print("Combined Script Loaded")

task.spawn(function()
    while true do
        local titansBasePart = workspace:FindFirstChild("Titans")
        if titansBasePart then
            processTitans(titansBasePart)
        else
            print("Titans folder not found!")
        end
        task.wait(5)
    end
end)

-- Camera Control (معدل)
local __mixous = {};
local localPlayer = game.Players.LocalPlayer;
__mixous.directory = workspace:WaitForChild('Titans');
__mixous.range = 6000;
__mixous.settings = { x = 5; y = 2; z = -0.3; };
__mixous.fovchanger = true;

workspace.Camera:GetPropertyChangedSignal('CFrame'):Connect(function()
    if __mixous.pressed and __mixous.align then
        workspace.Camera.CFrame = __mixous.align
        workspace.Camera.CameraSubject = localPlayer.Character
        workspace.Camera.CameraType = Enum.CameraType.Attach
        workspace.Camera.FieldOfView = __mixous.fovchanger and 120 or workspace.Camera.FieldOfView
    end;
end)

local onTime = game:GetService('HttpService'):GenerateGUID(false)
getgenv().game__runtime = onTime;
if getgenv().runtime then
    pcall(function()
        getgenv().runtime:Disconnect()
    end);
end;

print('running', onTime)
getgenv().runtime = game:GetService('RunService').RenderStepped:Connect(function()
    if getgenv().game__runtime ~= onTime then
        print(getgenv().game__runtime, onTime)
        print('[disconnected]')
        getgenv().runtime:Disconnect();
    end;
    __mixous.pressed = game:GetService('UserInputService'):IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    if not __mixous.pressed then return end;
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild('HumanoidRootPart') then return end;
    local titan, closestdist = nil, nil;
    for i, opposition in next, __mixous.directory:GetChildren() do
        local calcDist = (opposition:FindFirstChild('HumanoidRootPart').Position - localPlayer.Character:FindFirstChild('HumanoidRootPart').Position).Magnitude
        if calcDist <= __mixous.range then
            if calcDist <= __mixous.range / 10 then
                titan = opposition; closestdist = calcDist
                break;
            end;
            if titan == nil then
                titan = opposition; closestdist = calcDist
            else
                if closestdist > calcDist then
                    titan = opposition; closestdist = calcDist
                end
            end;
        end;
    end;
    if titan then
        __mixous.align = CFrame.new(localPlayer.Character:FindFirstChild('HumanoidRootPart').Position + Vector3.new(__mixous.settings.x, __mixous.settings.y, __mixous.settings.z), titan:FindFirstChild("Fake") and titan.Fake.Head.Position + Vector3.new(0, -2.4, 0) or titan:FindFirstChild('HumanoidRootPart').Position);
    end;
end);
