local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Domino Playground - Infinite Cash " .. Fluent.Version,
    SubTitle = "by Flames/Aura",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" })
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local running = false

local myToggle = Tabs.Main:AddToggle("InfiniteCash", {
    Title = "Infinite Cash",
    Default = false
})

myToggle:OnChanged(function(value)
    running = value
    if running then
        task.spawn(function()
            while running do
                ReplicatedStorage:WaitForChild("Prize"):FireServer()
                task.wait()
            end
        end)
    end
end)

myToggle:SetValue(false)
