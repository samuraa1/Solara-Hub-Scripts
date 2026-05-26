local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
gui.Name = "DarcelHub"

local loading = Instance.new("Frame")
loading.Size = UDim2.new(1,0,1,0)
loading.BackgroundColor3 = Color3.fromRGB(10,10,10)
loading.Parent = gui

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1,0,1,0)
loadingText.Text = "DarcelHub"
loadingText.TextColor3 = Color3.fromRGB(255,255,255)
loadingText.BackgroundTransparency = 1
loadingText.Font = Enum.Font.GothamBold
loadingText.TextScaled = true
loadingText.Parent = loading

task.spawn(function()
    while loading.Parent do
        for i = 1,3 do
            loadingText.Text = "DarcelHub" .. string.rep(".", i)
            task.wait(0.4)
        end
    end
end)

task.wait(3)

for i = 0,1,0.05 do
    loading.BackgroundTransparency = i
    loadingText.TextTransparency = i
    task.wait(0.03)
end

loading:Destroy()

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,250,0,120)
frame.Position = UDim2.new(0.5,-125,0.5,-60)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Position = UDim2.new(0,0,0,0)
title.Text = "DarcelHub"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,0,0,20)
label.Position = UDim2.new(0,0,0,35)
label.Text = "Auto Finish"
label.TextColor3 = Color3.fromRGB(200,200,200)
label.BackgroundTransparency = 1
label.Font = Enum.Font.Gotham
label.TextScaled = true
label.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0,150,0,40)
button.Position = UDim2.new(0.5,-75,0,65)
button.Text = "Start AutoFarm"
button.TextColor3 = Color3.fromRGB(255,255,255)
button.BackgroundColor3 = Color3.fromRGB(50,50,50)
button.Font = Enum.Font.GothamBold
button.TextScaled = true
button.Parent = frame

local function tween(inst, properties, duration)
    game:GetService("TweenService"):Create(inst, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties):Play()
end

local UserInputService = game:GetService("UserInputService")
local dragging = false
local dragOffset = Vector2.new()

local function beginDrag(input)
    local guiObjects = game:GetService("GuiService"):GetGuiObjectsAtPosition(input.Position.X, input.Position.Y)
    if #guiObjects > 0 and guiObjects[1]:IsDescendantOf(title) then
        dragging = true
        local framePos = frame.AbsolutePosition
        dragOffset = input.Position - Vector2.new(framePos.X, framePos.Y)
        frame.Position = UDim2.new(0, framePos.X, 0, framePos.Y)
    end
end

local function updateDrag(input)
    if not dragging then return end
    local newPos = input.Position - dragOffset
    frame.Position = UDim2.new(0, newPos.X, 0, newPos.Y)
end

local function endDrag()
    dragging = false
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        endDrag()
    end
end)

local function startFarm()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local backpack = player:WaitForChild("Backpack")

    local blueprintCF = CFrame.new(208.990311, -6.94161654, 82.356781)
    local nextRoomCF = CFrame.new(323.887573, 7.07500315, 92.7000046)
    local escapeCF = CFrame.new(419.599365, -16.8007565 + 5, 97.8007507)

    local blueprintRoot = workspace.Map.Functional.JanitorEnding.LadderBlueprint.Root
    local blueprintPrompt = blueprintRoot:FindFirstChildWhichIsA("ProximityPrompt") or blueprintRoot:FindFirstChild("Attachment"):FindFirstChildWhichIsA("ProximityPrompt")

    backpack.ChildAdded:Connect(function(tool)
        if tool.Name:lower():find("ladder") then
            task.wait(0.05)
            tool.Parent = char
        end
    end)

    local function collectLadder(root)
        local prompt = root:FindFirstChildWhichIsA("ProximityPrompt")
        if not prompt then return end
        hrp.CFrame = root.CFrame + Vector3.new(0,2,0)
        task.wait(0.1)
        for i = 1,2 do
            fireproximityprompt(prompt)
            task.wait(0.05)
        end
    end

    for _, v in pairs(workspace.Map.Build.Models:GetDescendants()) do
        if v.Name == "Root" and v:FindFirstChildWhichIsA("ProximityPrompt") then
            collectLadder(v)
            task.wait(0.15)
        end
    end

    task.wait(0.3)
    hrp.CFrame = blueprintCF + Vector3.new(0,2,0)
    task.wait(0.3)

    if blueprintPrompt then
        for i = 1,3 do
            fireproximityprompt(blueprintPrompt)
            task.wait(0.1)
        end
    end

    task.wait(0.3)
    hrp.CFrame = nextRoomCF + Vector3.new(0,2,0)
    task.wait(4)

    local batteriesFolder = workspace.Map.Functional.JanitorEnding.SpawnedBatteries
    local storageRoot = workspace.Map.Functional.JanitorEnding.BatteryStorage.Root
    local storagePrompt = storageRoot:FindFirstChildOfClass("ProximityPrompt")

    local function collectBattery(battery)
        local root = battery:FindFirstChild("Root")
        if not root then return end
        local prompt = root:FindFirstChildOfClass("ProximityPrompt")
        if not prompt then return end
        hrp.CFrame = root.CFrame + Vector3.new(0, 0.8, 0)
        task.wait(0.2)
        fireproximityprompt(prompt, prompt.HoldDuration + 0.1)
        task.wait(0.25)
    end

    while true do
        local found = false
        for _, battery in ipairs(batteriesFolder:GetChildren()) do
            if battery:IsA("Model") then
                found = true
                collectBattery(battery)
            end
        end
        if not found then break end
        task.wait(0.5)
    end

    hrp.CFrame = storageRoot.CFrame + Vector3.new(0, 1.5, 0)
    task.wait(0.3)
    for i = 1,10 do
        if storagePrompt then
            fireproximityprompt(storagePrompt, storagePrompt.HoldDuration + 0.1)
        end
        task.wait(0.2)
    end

    task.wait(0.2)
    hrp.CFrame = escapeCF
end

button.MouseButton1Click:Connect(function()
    button.Text = "Starting..."
    tween(frame, {Size = UDim2.new(0,0,0,0)}, 0.4)
    tween(frame, {BackgroundTransparency = 1}, 0.4)
    for _, v in pairs(frame:GetChildren()) do
        if v:IsA("TextLabel") or v:IsA("TextButton") then
            tween(v, {TextTransparency = 1}, 0.3)
        end
    end
    task.wait(0.4)
    frame.Visible = false
    startFarm()
end)
