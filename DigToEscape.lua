local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local enabled = {
    Common    = true,
    Uncommon  = true,
    Rare      = true,
    Epic      = true,
    Legendary = true
}

local rarities = {"Common", "Uncommon", "Rare", "Epic", "Legendary"}

local function pullItems()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end

    local targetPos = character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)

    for _, rarity in rarities do
        if not enabled[rarity] then continue end

        local folder = Workspace.Map.Functional.SpawnedItems:FindFirstChild(rarity)
        if not folder then continue end

        for _, item in folder:GetChildren() do
            local root = item:FindFirstChild("Root")
            if root and root:IsA("BasePart") then
                root.CFrame = CFrame.new(targetPos)
                root.Velocity = Vector3.zero
            end
        end
    end
end

local sg = Instance.new("ScreenGui")
sg.Name = "AutoPullGUI"
sg.ResetOnSpawn = false
sg.Parent = game:GetService('CoreGui')

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 200, 0, 280)
frame.Position = UDim2.new(0.85, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
frame.Parent = sg

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0, 10)

local topBar = Instance.new("Frame", frame)
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)

local topCorner = Instance.new("UICorner", topBar)
topCorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", topBar)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Font = Enum.Font.GothamBold
title.Text = "Auto Pull Items"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", topBar)
minimizeBtn.Size = UDim2.new(0, 25, 0, 20)
minimizeBtn.Position = UDim2.new(1, -65, 0.5, -10)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Text = "_"
minimizeBtn.TextColor3 = Color3.new()
minimizeBtn.TextSize = 16

local minBtnCorner = Instance.new("UICorner", minimizeBtn)
minBtnCorner.CornerRadius = UDim.new(0, 5)

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 25, 0, 20)
closeBtn.Position = UDim2.new(1, -35, 0.5, -10)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14

local closeBtnCorner = Instance.new("UICorner", closeBtn)
closeBtnCorner.CornerRadius = UDim.new(0, 5)

local pullBtn = Instance.new("TextButton", frame)
pullBtn.Size = UDim2.new(0.8, 0, 0, 40)
pullBtn.Position = UDim2.new(0.1, 0, 0, 45)
pullBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
pullBtn.Font = Enum.Font.GothamBold
pullBtn.Text = "PULL"
pullBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
pullBtn.TextSize = 18

local pullBtnCorner = Instance.new("UICorner", pullBtn)
pullBtnCorner.CornerRadius = UDim.new(0, 8)

local y = 95
for _, rarity in rarities do
    local container = Instance.new("Frame")
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(0.8, 0, 0, 25)
    container.Position = UDim2.new(0.1, 0, 0, y)
    container.Parent = frame

    local checkbox = Instance.new("TextButton", container)
    checkbox.Size = UDim2.new(0, 20, 0, 20)
    checkbox.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    checkbox.Font = Enum.Font.GothamBold
    checkbox.Text = "✓"
    checkbox.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkbox.TextSize = 14

    local cbCorner = Instance.new("UICorner", checkbox)
    cbCorner.CornerRadius = UDim.new(0, 4)

    local label = Instance.new("TextLabel", container)
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -30, 1, 0)
    label.Position = UDim2.new(0, 30, 0, 0)
    label.Font = Enum.Font.Gotham
    label.Text = rarity
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    checkbox.MouseButton1Click:Connect(function()
        enabled[rarity] = not enabled[rarity]
        if enabled[rarity] then
            checkbox.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            checkbox.Text = "✓"
        else
            checkbox.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            checkbox.Text = "✕"
        end
    end)

    y = y + 30
end

local dragging, dragInput, mousePos, framePos

topBar.InputBegan:Connect(function(input)
    if not (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        return
    end

    dragging = true
    mousePos = input.Position
    framePos = frame.Position

    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
        end
    end)
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        frame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

local minimizedIcon = Instance.new("ImageButton")
minimizedIcon.Name = "MinimizedIcon"
minimizedIcon.Size = UDim2.new(0, 60, 0, 60)
minimizedIcon.Position = UDim2.new(0, 10, 0.5, -30)
minimizedIcon.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
minimizedIcon.Image = "rbxassetid://3926305904"
minimizedIcon.ImageColor3 = Color3.fromRGB(100, 180, 255)
minimizedIcon.Visible = false
minimizedIcon.Parent = sg

local iconCorner = Instance.new("UICorner", minimizedIcon)
iconCorner.CornerRadius = UDim.new(0, 10)

local function toggleMinimize()
    frame.Visible = not frame.Visible
    minimizedIcon.Visible = not minimizedIcon.Visible
end

minimizeBtn.MouseButton1Click:Connect(toggleMinimize)
minimizedIcon.MouseButton1Click:Connect(toggleMinimize)

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftAlt then
        toggleMinimize()
    end
end)

pullBtn.MouseButton1Click:Connect(function()
    pullBtn.Text = "PULLING..."
    pullBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)

    pullItems()

    task.wait(0.3)

    pullBtn.Text = "PULL"
    pullBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
end)
