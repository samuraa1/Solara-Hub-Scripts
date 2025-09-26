local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if gethui then
    screenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(screenGui)
    screenGui.Parent = game:GetService("CoreGui")
else
    screenGui.Parent = game:GetService("CoreGui")
end

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 60)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Auto Farm"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.8, 0, 0, 25)
toggleButton.Position = UDim2.new(0.1, 0, 0, 35)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "OFF"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.Gotham
toggleButton.TextSize = 12
toggleButton.Parent = mainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleButton

local touchStartPos
local dragStartPos
local dragging = false

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        touchStartPos = input.Position
        dragStartPos = mainFrame.Position
        dragging = true
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - touchStartPos
        mainFrame.Position = UDim2.new(
            dragStartPos.X.Scale, 
            dragStartPos.X.Offset + delta.X,
            dragStartPos.Y.Scale, 
            dragStartPos.Y.Offset + delta.Y
        )
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local autoFarmEnabled = false
local garbageFolder = workspace:WaitForChild("Garbage")
local cleaning = false

local function setupCharacter()
    if not lp.Character or not lp.Character:FindFirstChild("Humanoid") then
        lp.CharacterAdded:Wait()
        wait(1)
    end
    
    local humanoid = lp.Character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        lp.CharacterAdded:Wait()
        wait(1)
    end
end

local function getMop()
    setupCharacter()
    
    if not lp.Backpack:FindFirstChild("Mop") then
        local startTime = tick()
        while not lp.Backpack:FindFirstChild("Mop") and tick() - startTime < 10 do
            wait(0.5)
        end
    end
    
    return lp.Backpack:FindFirstChild("Mop")
end

local function cleanSpill(spill)
    if not autoFarmEnabled or not spill or not spill:IsA("BasePart") or cleaning then
        return
    end
    
    cleaning = true
    
    local mop = getMop()
    if not mop then
        cleaning = false
        return
    end
    
    local humanoid = lp.Character:FindFirstChildWhichIsA("Humanoid")
    local rootPart = humanoid and humanoid.RootPart
    if not rootPart then
        cleaning = false
        return
    end
    
    local oldPosition = rootPart.CFrame
    
    mop.Parent = lp.Character
    
    local cleanAttempts = 0
    while autoFarmEnabled and spill and spill.Parent and cleanAttempts < 5 do
        rootPart.CFrame = spill.CFrame * CFrame.new(0, 3, 0)
        
        local bottom = mop:FindFirstChild("Bottom")
        if bottom then
            firetouchinterest(bottom, spill, 0)
            mop:Activate()
            firetouchinterest(bottom, spill, 1)
        end
        
        cleanAttempts += 1
        wait(0.2)
    end
    
    if rootPart and rootPart.Parent then
        rootPart.CFrame = oldPosition
    end
    
    mop.Parent = lp.Backpack
    cleaning = false
end

lp.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
        if autoFarmEnabled then
            RunService.Heartbeat:Wait()
            humanoid.Sit = false
        end
    end)
end)

spawn(function()
    while wait(1) do
        if autoFarmEnabled then
            setupCharacter()
            
            for _, spill in pairs(garbageFolder:GetChildren()) do
                if autoFarmEnabled then
                    spawn(function()
                        cleanSpill(spill)
                    end)
                    wait(0.3)
                else
                    break
                end
            end
        end
    end
end)

garbageFolder.ChildAdded:Connect(function(child)
    if autoFarmEnabled then
        wait(0.5)
        cleanSpill(child)
    end
end)

toggleButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    
    if autoFarmEnabled then
        toggleButton.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
        toggleButton.Text = "ON"
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        toggleButton.Text = "OFF"
    end
end)

workspace.FallenPartsDestroyHeight = 0/0

spawn(function()
    wait(2)
    setupCharacter()
end)
