getgenv().version = "2.0 (piggy version}"
--check game
if not table.find({4623386862, 5247067896, 5661005779}, game.PlaceId) then
    game.Players.LocalPlayer:Kick("Sorry, this place is not supported.")
    return
end
--check gui
if game:GetService("CoreGui"):FindFirstChild("Piggy") then
    game:GetService("CoreGui"):FindFirstChild("Piggy"):Destroy()
    game:GetService("Workspace").DescendantAdded:Disconnect()
    game:GetService("Workspace").DescendantRemoving:Disconnect()
    return
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/web.lua"))()
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local PiggyGui = Instance.new("ScreenGui")
PiggyGui.Parent = game:GetService("CoreGui")
PiggyGui.Name = "Piggy"

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = PiggyGui
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
ScrollingFrame.Position = UDim2.new(0.08, 0, 0.42, 0)
ScrollingFrame.Size = UDim2.new(0, 296, 0, 388)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)

local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.Parent = ScrollingFrame
UIGridLayout.CellSize = UDim2.new(0, 90, 0, 90)

local isDragging = false
local dragStart, startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    ScrollingFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

ScrollingFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = ScrollingFrame.Position
    end
end)

ScrollingFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag(input)
    end
end)

local itemCache = {}
local frameCache = {}

local function createViewport(item)
    local Viewport = Instance.new("ViewportFrame")
    Viewport.Size = UDim2.new(1, 0, 1, 0)
    Viewport.BackgroundTransparency = 1

    local clone = item:Clone()
    clone.Parent = Viewport

    local camera = Instance.new("Camera")
    camera.Parent = Viewport
    camera.CameraType = Enum.CameraType.Fixed
    camera.CFrame = CFrame.new(item.Position + Vector3.new(0, 3, 0), item.Position)
    Viewport.CurrentCamera = camera

    return Viewport, clone
end

local function updateViewport(Viewport, clone, item)
    if clone then clone:Destroy() end
    clone = item:Clone()
    clone.Parent = Viewport
    Viewport.CurrentCamera.CFrame = CFrame.new(item.Position + Vector3.new(0, 3, 0), item.Position)
    return clone
end

local function createItemFrame(item)
    if frameCache[item] then return end

    local ItemFrame = Instance.new("TextButton")
    ItemFrame.Parent = ScrollingFrame
    ItemFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    ItemFrame.BackgroundTransparency = 0.95
    ItemFrame.Size = UDim2.new(0, 100, 0, 100)
    ItemFrame.Text = ""

    local Viewport, clone = createViewport(item)
    Viewport.Parent = ItemFrame

    ItemFrame.MouseButton1Down:Connect(function()
        local clickDetector = item:FindFirstChild("ClickDetector")
        if clickDetector then
            local originalPos = LocalPlayer.Character.HumanoidRootPart.CFrame
            LocalPlayer.Character.HumanoidRootPart.CFrame = item.CFrame
            task.wait(0.1)
            fireclickdetector(clickDetector)
            task.wait(0.3)
            LocalPlayer.Character.HumanoidRootPart.CFrame = originalPos
        end
    end)

    frameCache[item] = {Frame = ItemFrame, Viewport = Viewport, Clone = clone}

    local function updateVisibility()
        if item.Transparency < 1 then
            ItemFrame.Visible = true
            frameCache[item].Clone = updateViewport(Viewport, frameCache[item].Clone, item)
        else
            ItemFrame.Visible = false
        end
    end

    updateVisibility()
    item:GetPropertyChangedSignal("Transparency"):Connect(updateVisibility)
end

local function onItemAdded(item)
    local parent = item.Parent
    if item.Name == "ItemPickupScript" or item.Name == "NewItemPickupScript" or (item.Name == "Script" and item.Parent:FindFirstChild("ClickDetector") and item.Parent:FindFirstChild("Mesh")) then
        itemCache[parent] = true
        task.defer(function() createItemFrame(parent) end)
    end
end

local function onItemRemoved(item)
    local parent = item.Parent
    if frameCache[parent] then
        frameCache[parent].Frame:Destroy()
        frameCache[parent].Clone:Destroy()
        itemCache[parent], frameCache[parent] = nil, nil
    end
end

game:GetService("Workspace").DescendantAdded:Connect(onItemAdded)
game:GetService("Workspace").DescendantRemoving:Connect(onItemRemoved)

for _, item in ipairs(game:GetService("Workspace"):GetDescendants()) do
    onItemAdded(item)
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/notify.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconBABA/script/refs/heads/main/command.lua"))()
