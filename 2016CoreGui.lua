loadstring(game:HttpGet("https://pastebin.com/raw/9AQrDua1"))()
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Roblox-into-2016-Roblox-1393"))()

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function createGUI()
    if CoreGui:FindFirstChild("TopBarApp") then
        CoreGui.TopBarApp:Destroy()
    end

    local topbar = Instance.new("ScreenGui")
    topbar.Name = "TopBarApp"
    topbar.Parent = CoreGui

    local topBarFrame = Instance.new("Frame")
    topBarFrame.Name = "TopBarApp"
    topBarFrame.Size = UDim2.new(1,0,0,50)
    topBarFrame.Position = UDim2.new(0,0,0,0)
    topBarFrame.BackgroundTransparency = 1
    topBarFrame.Parent = topbar

    local menu = Instance.new("Frame")
    menu.Name = "UnibarLeftFrame"
    menu.Parent = topBarFrame

    local menuInner = Instance.new("Frame")
    menuInner.Name = "UnibarMenu"
    menuInner.Parent = menu

    local trigger = Instance.new("ImageButton")
    trigger.Name = "TriggerPoint"
    trigger.Parent = topBarFrame
    trigger.Size = UDim2.new(0,50,0,36)
    trigger.Position = UDim2.new(0,0,0,8.9)
    trigger.BackgroundTransparency = 1

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "PlayerNameLabel"
    nameLabel.Parent = healthFrame
    nameLabel.Text = LocalPlayer.Name
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 12
    nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
    nameLabel.BackgroundTransparency = 1
    nameLabel.AnchorPoint = Vector2.new(1,0)
    nameLabel.Position = UDim2.new(1,-23,0,-19)
    nameLabel.Size = UDim2.new(0,200,0,25)
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left

    return {topbar=topbar, trigger=trigger, health=healthFrame}
end

local guiRefs = createGUI()
local trigger = guiRefs.trigger
local health = guiRefs.health

trigger.BackgroundTransparency = 1
health.Visible = true
trigger.ScalingIcon.Size = UDim2.new(0,32,0,25)

local state = false

task.spawn(function()
    while true do
        if state then
            trigger.BackgroundTransparency = 1
            health.Visible = true
            trigger.ScalingIcon.Size = UDim2.new(0,32,0,25)
        else
        end
        state = not state
        task.wait()
    end
end)

task.spawn(function()
    while true do
        task.wait(0.5)
        if not CoreGui:FindFirstChild("TopBarApp") then
            guiRefs = createGUI()
            trigger = guiRefs.trigger
            health = guiRefs.health
        end
    end
end)
