local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local FPSLabel = Instance.new("TextLabel")
local PingLabel = Instance.new("TextLabel")
local MemoryLabel = Instance.new("TextLabel")
local UnanchoredLabel = Instance.new("TextLabel")
local ScanButton = Instance.new("TextButton")
local ResultsFrame = Instance.new("ScrollingFrame")

do
    ScreenGui.Name = "PerformanceMonitor"
    ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)

    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 300, 0, 400)
    MainFrame.Position = UDim2.new(0.8, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Performance Monitor"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18
    Title.Parent = MainFrame

    FPSLabel.Name = "FPSLabel"
    FPSLabel.Size = UDim2.new(1, 0, 0, 25)
    FPSLabel.Position = UDim2.new(0, 0, 0, 35)
    FPSLabel.BackgroundTransparency = 1
    FPSLabel.Text = "FPS: Calculating..."
    FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FPSLabel.Font = Enum.Font.SourceSans
    FPSLabel.TextSize = 16
    FPSLabel.Parent = MainFrame

    PingLabel.Name = "PingLabel"
    PingLabel.Size = UDim2.new(1, 0, 0, 25)
    PingLabel.Position = UDim2.new(0, 0, 0, 60)
    PingLabel.BackgroundTransparency = 1
    PingLabel.Text = "Ping: Calculating..."
    PingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    PingLabel.Font = Enum.Font.SourceSans
    PingLabel.TextSize = 16
    PingLabel.Parent = MainFrame

    MemoryLabel.Name = "MemoryLabel"
    MemoryLabel.Size = UDim2.new(1, 0, 0, 25)
    MemoryLabel.Position = UDim2.new(0, 0, 0, 85)
    MemoryLabel.BackgroundTransparency = 1
    MemoryLabel.Text = "Memory: Calculating..."
    MemoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MemoryLabel.Font = Enum.Font.SourceSans
    MemoryLabel.TextSize = 16
    MemoryLabel.Parent = MainFrame

    UnanchoredLabel.Name = "UnanchoredLabel"
    UnanchoredLabel.Size = UDim2.new(1, 0, 0, 25)
    UnanchoredLabel.Position = UDim2.new(0, 0, 0, 110)
    UnanchoredLabel.BackgroundTransparency = 1
    UnanchoredLabel.Text = "Unanchored Parts: 0"
    UnanchoredLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    UnanchoredLabel.Font = Enum.Font.SourceSans
    UnanchoredLabel.TextSize = 16
    UnanchoredLabel.Parent = MainFrame

    ScanButton.Name = "ScanButton"
    ScanButton.Size = UDim2.new(0.8, 0, 0, 30)
    ScanButton.Position = UDim2.new(0.1, 0, 0, 140)
    ScanButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    ScanButton.Text = "Scan for Lag Sources"
    ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScanButton.Font = Enum.Font.SourceSansBold
    ScanButton.TextSize = 14
    ScanButton.Parent = MainFrame

    ResultsFrame.Name = "ResultsFrame"
    ResultsFrame.Size = UDim2.new(0.9, 0, 0.6, 0)
    ResultsFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
    ResultsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ResultsFrame.BorderSizePixel = 0
    ResultsFrame.ScrollBarThickness = 6
    ResultsFrame.Parent = MainFrame
end

local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

local function formatNumber(num)
    return string.format("%.1f", num)
end

local fps = 60
local frameTimes = {}
RunService.RenderStepped:Connect(function()
    table.insert(frameTimes, tick())
    for i = #frameTimes, 1, -1 do
        if tick() - frameTimes[i] > 1 then
            table.remove(frameTimes, i)
        end
    end
    fps = #frameTimes
end)

task.spawn(function()
    while true do
        FPSLabel.Text = string.format("FPS: %d", fps)
        
        local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        PingLabel.Text = string.format("Ping: %s ms", formatNumber(ping))
        
        local memory = math.floor(Stats:GetTotalMemoryUsageMb())
        MemoryLabel.Text = string.format("Memory: %d MB", memory)
        
        task.wait(0.1)
    end
end)

local function countUnanchoredParts()
    local count = 0
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part.Anchored then
            count = count + 1
        end
    end
    UnanchoredLabel.Text = string.format("Unanchored Parts: %d", count)
    return count
end

local function addResult(text, color)
    local result = Instance.new("TextLabel")
    result.Size = UDim2.new(1, -10, 0, 25)
    result.Position = UDim2.new(0, 5, 0, #ResultsFrame:GetChildren() * 30)
    result.BackgroundTransparency = 1
    result.Text = text
    result.TextColor3 = color
    result.Font = Enum.Font.SourceSans
    result.TextSize = 14
    result.Parent = ResultsFrame
end

ScanButton.MouseButton1Click:Connect(function()
    ResultsFrame:ClearAllChildren()
    addResult("Scanning for lag sources...", Color3.fromRGB(255, 255, 0))
    
    wait(1)

    local unanchoredCount = countUnanchoredParts()
    if unanchoredCount > 0 then
        addResult(string.format("Found %d unanchored parts.", unanchoredCount), Color3.fromRGB(255, 0, 0))
    else
        addResult("No unanchored parts found.", Color3.fromRGB(0, 255, 0))
    end

    addResult("Scan complete.", Color3.fromRGB(255, 255, 255))
end)

countUnanchoredParts()
