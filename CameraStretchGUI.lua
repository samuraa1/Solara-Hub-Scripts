local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VM = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

getgenv().StretchConfig = getgenv().StretchConfig or {
	Scale = 0.55,
	PopSoundId = "rbxassetid://7144958286",
	DotTexture = "rbxassetid://4607031412",
	SprintKey = Enum.KeyCode.W,
	HoldKey = Enum.KeyCode.LeftShift,
	ForceFieldUser = "poopayden123",
	AutoSprint = false,
	StretchEnabled = false,
	CustomSoundsEnabled = false
}

local gui = Instance.new("ScreenGui")
gui.Name = "StretchOverlay"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999999
gui.Parent = CoreGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 280, 0, 380)
main.Position = UDim2.new(1, 300, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 28)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 4)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(85, 90, 95)
stroke.Thickness = 1
stroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 32)
header.BackgroundColor3 = Color3.fromRGB(32, 34, 36)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 4)
headerCorner.Parent = header

local headerCover = Instance.new("Frame")
headerCover.Size = UDim2.new(1, 0, 0, 8)
headerCover.Position = UDim2.new(0, 0, 1, -8)
headerCover.BackgroundColor3 = Color3.fromRGB(32, 34, 36)
headerCover.BorderSizePixel = 0
headerCover.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SCREEN STRETCH"
title.TextColor3 = Color3.fromRGB(200, 205, 210)
title.TextSize = 13
title.Font = Enum.Font.Code
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 24, 0, 24)
hideBtn.Position = UDim2.new(1, -28, 0, 4)
hideBtn.BackgroundColor3 = Color3.fromRGB(40, 42, 44)
hideBtn.Text = "×"
hideBtn.TextColor3 = Color3.fromRGB(180, 185, 190)
hideBtn.TextSize = 16
hideBtn.Font = Enum.Font.Code
hideBtn.Parent = header

local hideBtnCorner = Instance.new("UICorner")
hideBtnCorner.CornerRadius = UDim.new(0, 2)
hideBtnCorner.Parent = hideBtn

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -40)
content.Position = UDim2.new(0, 8, 0, 36)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 0
content.ScrollBarImageColor3 = Color3.fromRGB(85, 90, 95)
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local function createLabel(text, order)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 18)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(160, 165, 170)
	lbl.TextSize = 11
	lbl.Font = Enum.Font.Code
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.LayoutOrder = order
	lbl.Parent = content
end

local function createSlider(labelText, min, max, default, callback, order)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 42)
	container.BackgroundColor3 = Color3.fromRGB(28, 30, 32)
	container.BorderSizePixel = 0
	container.LayoutOrder = order
	container.Parent = content
	
	local cCorner = Instance.new("UICorner")
	cCorner.CornerRadius = UDim.new(0, 3)
	cCorner.Parent = container
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.6, 0, 0, 18)
	label.Position = UDim2.new(0, 8, 0, 4)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(180, 185, 190)
	label.TextSize = 11
	label.Font = Enum.Font.Code
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container
	
	local value = Instance.new("TextLabel")
	value.Size = UDim2.new(0.3, 0, 0, 18)
	value.Position = UDim2.new(0.7, 0, 0, 4)
	value.BackgroundTransparency = 1
	value.Text = tostring(default)
	value.TextColor3 = Color3.fromRGB(140, 200, 255)
	value.TextSize = 11
	value.Font = Enum.Font.Code
	value.TextXAlignment = Enum.TextXAlignment.Right
	value.Parent = container
	
	local leftBtn = Instance.new("TextButton")
	leftBtn.Size = UDim2.new(0, 32, 0, 18)
	leftBtn.Position = UDim2.new(0, 8, 1, -22)
	leftBtn.BackgroundColor3 = Color3.fromRGB(36, 38, 40)
	leftBtn.Text = "◄"
	leftBtn.TextColor3 = Color3.fromRGB(160, 165, 170)
	leftBtn.TextSize = 12
	leftBtn.Font = Enum.Font.Code
	leftBtn.Parent = container
	
	local lCorner = Instance.new("UICorner")
	lCorner.CornerRadius = UDim.new(0, 2)
	lCorner.Parent = leftBtn
	
	local rightBtn = Instance.new("TextButton")
	rightBtn.Size = UDim2.new(0, 32, 0, 18)
	rightBtn.Position = UDim2.new(1, -40, 1, -22)
	rightBtn.BackgroundColor3 = Color3.fromRGB(36, 38, 40)
	rightBtn.Text = "►"
	rightBtn.TextColor3 = Color3.fromRGB(160, 165, 170)
	rightBtn.TextSize = 12
	rightBtn.Font = Enum.Font.Code
	rightBtn.Parent = container
	
	local rCorner = Instance.new("UICorner")
	rCorner.CornerRadius = UDim.new(0, 2)
	rCorner.Parent = rightBtn
	
	local current = default
	local step = (max - min) / 20
	
	leftBtn.MouseButton1Click:Connect(function()
		current = math.max(min, current - step)
		current = math.floor(current * 100 + 0.5) / 100
		value.Text = tostring(current)
		callback(current)
	end)
	
	rightBtn.MouseButton1Click:Connect(function()
		current = math.min(max, current + step)
		current = math.floor(current * 100 + 0.5) / 100
		value.Text = tostring(current)
		callback(current)
	end)
end

local function createToggle(labelText, default, callback, order)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 28)
	container.BackgroundColor3 = Color3.fromRGB(28, 30, 32)
	container.BorderSizePixel = 0
	container.LayoutOrder = order
	container.Parent = content
	
	local cCorner = Instance.new("UICorner")
	cCorner.CornerRadius = UDim.new(0, 3)
	cCorner.Parent = container
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.7, 0, 1, 0)
	label.Position = UDim2.new(0, 8, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(180, 185, 190)
	label.TextSize = 11
	label.Font = Enum.Font.Code
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container
	
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0, 40, 0, 18)
	toggle.Position = UDim2.new(1, -44, 0.5, -9)
	toggle.BackgroundColor3 = default and Color3.fromRGB(60, 140, 80) or Color3.fromRGB(60, 62, 64)
	toggle.Text = default and "ON" or "OFF"
	toggle.TextColor3 = Color3.fromRGB(220, 225, 230)
	toggle.TextSize = 10
	toggle.Font = Enum.Font.Code
	toggle.Parent = container
	
	local tCorner = Instance.new("UICorner")
	tCorner.CornerRadius = UDim.new(0, 2)
	tCorner.Parent = toggle
	
	local state = default
	
	toggle.MouseButton1Click:Connect(function()
		state = not state
		callback(state)
		TweenService:Create(toggle, TweenInfo.new(0.15), {
			BackgroundColor3 = state and Color3.fromRGB(60, 140, 80) or Color3.fromRGB(60, 62, 64)
		}):Play()
		toggle.Text = state and "ON" or "OFF"
	end)
end

local function createTextBox(labelText, default, callback, order)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 48)
	container.BackgroundColor3 = Color3.fromRGB(28, 30, 32)
	container.BorderSizePixel = 0
	container.LayoutOrder = order
	container.Parent = content
	
	local cCorner = Instance.new("UICorner")
	cCorner.CornerRadius = UDim.new(0, 3)
	cCorner.Parent = container
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -16, 0, 18)
	label.Position = UDim2.new(0, 8, 0, 4)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(180, 185, 190)
	label.TextSize = 11
	label.Font = Enum.Font.Code
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container
	
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, -16, 0, 20)
	box.Position = UDim2.new(0, 8, 1, -24)
	box.BackgroundColor3 = Color3.fromRGB(36, 38, 40)
	box.Text = default
	box.TextColor3 = Color3.fromRGB(140, 200, 255)
	box.TextSize = 10
	box.Font = Enum.Font.Code
	box.PlaceholderText = "Enter value..."
	box.PlaceholderColor3 = Color3.fromRGB(100, 105, 110)
	box.ClearTextOnFocus = false
	box.Parent = container
	
	local bCorner = Instance.new("UICorner")
	bCorner.CornerRadius = UDim.new(0, 2)
	bCorner.Parent = box
	
	box.FocusLost:Connect(function()
		callback(box.Text)
	end)
end

local notifications = Instance.new("Frame")
notifications.Name = "Notifications"
notifications.Size = UDim2.new(0, 240, 1, 0)
notifications.Position = UDim2.new(1, -250, 0, 10)
notifications.BackgroundTransparency = 1
notifications.Parent = gui

local notifLayout = Instance.new("UIListLayout")
notifLayout.Padding = UDim.new(0, 6)
notifLayout.SortOrder = Enum.SortOrder.LayoutOrder
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Top
notifLayout.Parent = notifications

local function notify(text, duration)
	local notif = Instance.new("Frame")
	notif.Size = UDim2.new(1, 0, 0, 0)
	notif.BackgroundColor3 = Color3.fromRGB(32, 34, 36)
	notif.BorderSizePixel = 0
	notif.BackgroundTransparency = 1
	notif.ClipsDescendants = true
	notif.Parent = notifications
	
	local nCorner = Instance.new("UICorner")
	nCorner.CornerRadius = UDim.new(0, 3)
	nCorner.Parent = notif
	
	local nStroke = Instance.new("UIStroke")
	nStroke.Color = Color3.fromRGB(85, 90, 95)
	nStroke.Thickness = 1
	nStroke.Transparency = 1
	nStroke.Parent = notif
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -16, 1, 0)
	label.Position = UDim2.new(0, 8, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(200, 205, 210)
	label.TextSize = 11
	label.Font = Enum.Font.Code
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextWrapped = true
	label.TextTransparency = 1
	label.Parent = notif
	
	local textBounds = label.TextBounds.Y + 12
	
	TweenService:Create(notif, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = UDim2.new(1, 0, 0, textBounds),
		BackgroundTransparency = 0
	}):Play()
	
	TweenService:Create(label, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
	TweenService:Create(nStroke, TweenInfo.new(0.25), {Transparency = 0}):Play()
	
	task.delay(duration or 3, function()
		TweenService:Create(notif, TweenInfo.new(0.25), {
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1
		}):Play()
		TweenService:Create(label, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
		TweenService:Create(nStroke, TweenInfo.new(0.25), {Transparency = 1}):Play()
		task.wait(0.25)
		notif:Destroy()
	end)
end

createLabel("CORE FEATURES", 1)
createToggle("Screen Stretch", getgenv().StretchConfig.StretchEnabled, function(v)
	getgenv().StretchConfig.StretchEnabled = v
	notify("Stretch: " .. (v and "ON" or "OFF"), 2)
end, 2)

createToggle("Custom Sounds", getgenv().StretchConfig.CustomSoundsEnabled, function(v)
	getgenv().StretchConfig.CustomSoundsEnabled = v
	notify("Custom Sounds: " .. (v and "ON" or "OFF"), 2)
end, 3)

createLabel("CAMERA SETTINGS", 4)
createSlider("Y-Scale", 0.1, 1.0, getgenv().StretchConfig.Scale, function(v)
	getgenv().StretchConfig.Scale = v
	notify("Scale: " .. v, 2)
end, 5)

createLabel("AUDIO SETTINGS", 6)
createTextBox("Sound ID", getgenv().StretchConfig.PopSoundId, function(v)
	getgenv().StretchConfig.PopSoundId = v
	notify("Sound ID updated", 2)
end, 7)

createLabel("PARTICLE SETTINGS", 8)
createTextBox("Dot Texture ID", getgenv().StretchConfig.DotTexture, function(v)
	getgenv().StretchConfig.DotTexture = v
	notify("Texture ID updated", 2)
end, 9)

createLabel("MOVEMENT SETTINGS", 10)
createToggle("Auto Sprint", getgenv().StretchConfig.AutoSprint, function(v)
	getgenv().StretchConfig.AutoSprint = v
	notify("Auto Sprint: " .. (v and "ON" or "OFF"), 2)
end, 11)

createLabel("FORCEFIELD SETTINGS", 12)
createTextBox("ForceField User", getgenv().StretchConfig.ForceFieldUser, function(v)
	getgenv().StretchConfig.ForceFieldUser = v
	notify("ForceField user: " .. v, 2)
end, 13)

local visible = false
local animating = false

local function toggleGui()
	if animating then return end
	animating = true
	visible = not visible
	
	local targetPos = visible and UDim2.new(1, -290, 0.5, -190) or UDim2.new(1, 300, 0.5, -190)
	
	TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Position = targetPos
	}):Play()
	
	task.wait(0.35)
	animating = false
end

hideBtn.MouseButton1Click:Connect(toggleGui)

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.P then
		toggleGui()
	end
end)

local processed = setmetatable({}, {__mode = "k"})
local originalSounds = {}

local function optimizeGame()
	local Lighting = game:GetService("Lighting")
	Lighting.Technology = Enum.Technology.Compatibility
	Lighting.GlobalShadows = false
	Lighting.ShadowSoftness = 0
	
	local function process(obj)
		if processed[obj] then return end
		processed[obj] = true
		
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.SmoothPlastic
			obj.CastShadow = false
		elseif obj:IsA("Sound") then
			originalSounds[obj] = obj.SoundId
			if getgenv().StretchConfig.CustomSoundsEnabled then
				obj.SoundId = getgenv().StretchConfig.PopSoundId
			end
		elseif obj:IsA("ParticleEmitter") then
			obj.Texture = getgenv().StretchConfig.DotTexture
			obj.Rate = 5
			obj.Size = NumberSequence.new(0.1)
		end
	end
	
	for _, obj in ipairs(workspace:GetDescendants()) do
		task.spawn(process, obj)
	end
	
	workspace.DescendantAdded:Connect(process)
end

RunService.Heartbeat:Connect(function()
	if not getgenv().StretchConfig.CustomSoundsEnabled then return end
	
	for sound, original in pairs(originalSounds) do
		if sound and sound.Parent then
			sound.SoundId = getgenv().StretchConfig.PopSoundId
		end
	end
end)

local function applyForceField(plr, character)
	if plr.Name ~= getgenv().StretchConfig.ForceFieldUser then return end
	for _, obj in ipairs(character:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.ForceField
			obj.BrickColor = BrickColor.new("White")
			obj.CastShadow = false
		end
	end
end

Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		task.spawn(applyForceField, plr, char)
	end)
end)

if player.Character then
	task.spawn(applyForceField, player, player.Character)
end

player.CharacterAdded:Connect(function(char)
	task.spawn(applyForceField, player, char)
end)

local holding = false

UIS.InputBegan:Connect(function(input, gpe)
	if gpe or not getgenv().StretchConfig.AutoSprint then return end
	if input.KeyCode == getgenv().StretchConfig.SprintKey then
		VM:SendKeyEvent(true, getgenv().StretchConfig.HoldKey, false, game)
		holding = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == getgenv().StretchConfig.SprintKey and holding then
		VM:SendKeyEvent(false, getgenv().StretchConfig.HoldKey, false, game)
		holding = false
	end
end)

local Camera = workspace.CurrentCamera

RunService.RenderStepped:Connect(function()
	if not getgenv().StretchConfig.StretchEnabled then return end
	
	local cfg = getgenv().StretchConfig
	Camera.CFrame = Camera.CFrame * CFrame.new(
		0, 0, 0,
		1, 0, 0,
		0, cfg.Scale, 0,
		0, 0, 1
	)
end)

task.spawn(optimizeGame)
notify("Screen Stretch • Press P", 3)
