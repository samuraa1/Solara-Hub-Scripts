----------------------------------------------------------------------------------------------------------------------------

if not game:IsLoaded() then game["Loaded"]:Wait() end

-------------------------------------------------------------------------------------------------------------------------------

local players = game:GetService("Players")
local localplayer = players["LocalPlayer"]
local marketplaceservice = game:GetService("MarketplaceService")
local httpservice = game:GetService("HttpService")

-------------------------------------------------------------------------------------------------------------------------------

local function clik()
	local s = Instance.new("Sound") 
	s["SoundId"] = "rbxassetid://87152549167464"
	s["Parent"] = game["Workspace"]
	s["Volume"] = 1.2
	s["TimePosition"] = 0.1
	s:Play()
end

-------------------------------------------------------------------------------------------------------------------------------

local gui = Instance.new("ScreenGui")
gui["Name"] = "AnimationPlayer"
if game["Run Service"]:IsStudio() then gui["Parent"] = localplayer:WaitForChild("PlayerGui") else gui["Parent"] = gethui and gethui() or game:GetService("CoreGui") end
gui["ResetOnSpawn"] = false

local function repos(ui, w, h)
	local sw, sh = workspace["CurrentCamera"]["ViewportSize"]["X"], workspace["CurrentCamera"]["ViewportSize"]["Y"]
	local cx, cy = (sw - w) / 2, (sh - h) / 2 - 56
	ui["Position"] = UDim2.new(0, cx, 0, cy)
end

local frame = Instance.new("Frame")
frame["Size"] = UDim2.new(0, 399, 0, 300)
frame["Position"] = UDim2.new(0.35, 0, 0.3, 0)
repos(frame, 399, 300)
frame["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
frame["BorderSizePixel"] = 0
frame["Parent"] = gui

task.spawn(function()
	local dragtoggle
	local dragspeed = 0.25
	local dragstart
	local startpos

	local function updatebuttoninput(input)
		local delta = input["Position"] - dragstart
		local position = UDim2.new(startpos["X"]["Scale"], startpos["X"]["Offset"] + delta["X"],
			startpos["Y"]["Scale"], startpos["Y"]["Offset"] + delta["Y"])
		game:GetService("TweenService"):Create(frame, TweenInfo.new(dragspeed), {["Position"] = position}):Play()
	end

	frame["InputBegan"]:Connect(function(input)
		if (input["UserInputType"] == Enum.UserInputType.MouseButton1 or input["UserInputType"] == Enum.UserInputType.Touch) then 
			dragtoggle = true
			dragstart = input["Position"]
			startpos = frame["Position"]
			input["Changed"]:Connect(function()
				if input["UserInputState"] == Enum.UserInputState.End then
					dragtoggle = false
				end
			end)
		end
	end)

	game:GetService("UserInputService")["InputChanged"]:Connect(function(input)
		if input["UserInputType"] == Enum.UserInputType.MouseMovement or input["UserInputType"] == Enum.UserInputType.Touch then
			if dragtoggle then
				updatebuttoninput(input)
			end
		end
	end)
end)

-------------------------------------------------------------------------------------------------------------------------------

local topbar = Instance.new("Frame")
topbar["Size"] = UDim2.new(0, 399, 0, 30)
topbar["BackgroundColor3"] = Color3.fromRGB(50, 50, 50)
topbar["BorderSizePixel"] = 0
topbar["Parent"] = frame

local titlelabel = Instance.new("TextLabel")
titlelabel["Size"] = UDim2.new(1, -140, 1, 0)
titlelabel["Position"] = UDim2.new(0, 0, 0, 0)
titlelabel["BackgroundTransparency"] = 1
titlelabel["Text"] = " FE R15 Animation Player"
titlelabel["Font"] = Enum.Font.RobotoMono
titlelabel["TextXAlignment"] = Enum.TextXAlignment.Left
titlelabel["TextColor3"] = Color3.new(1, 1, 1)
titlelabel["TextSize"] = 18
titlelabel["Parent"] = topbar

local searchbar = Instance.new("Frame")
searchbar["Size"] = UDim2.new(0, 399, 0, 30)
searchbar["Position"] = UDim2.new(0, 0, 0, 30)
searchbar["BackgroundColor3"] = Color3.fromRGB(40, 40, 40)
searchbar["BorderSizePixel"] = 0
searchbar["Parent"] = frame

local searchbox = Instance.new("TextBox")
searchbox["Size"] = UDim2.new(1, -10, 0, 20)
searchbox["Position"] = UDim2.new(0, 5, 0, 5)
searchbox["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
searchbox["TextColor3"] = Color3.new(1, 1, 1)
searchbox["PlaceholderText"] = "Search for Animations..."
searchbox["PlaceholderColor3"] = Color3.fromRGB(150, 150, 150)
searchbox["Text"] = ""
searchbox["TextSize"] = 14
searchbox["Font"] = Enum.Font.RobotoMono
searchbox["BorderSizePixel"] = 0
searchbox["Parent"] = searchbar

local function createbutton(name, position, size, color, text)
	local button = Instance.new("TextButton")
	button["Name"] = name
	button["Size"] = size
	button["Position"] = position
	button["BackgroundColor3"] = color
	button["Text"] = text
	button["TextColor3"] = Color3.new(1, 1, 1)
	button["TextSize"] = 16
	button["Font"] = Enum.Font.RobotoMono
	button["BorderSizePixel"] = 0
	button["BackgroundTransparency"] = 0.7
	button["Parent"] = topbar
	return button
end

local stopallbutton = createbutton("StopAllButton", UDim2.new(1, -147, 0, 5), UDim2.new(0, 90, 0, 20), Color3.fromRGB(200, 50, 50), "Stop All")
local minimizebutton = createbutton("MinimizeButton", UDim2.new(1, -51, 0, 5), UDim2.new(0, 20, 0, 20), Color3.fromRGB(50, 50, 200), "–")
local xbutton = createbutton("CloseButton", UDim2.new(1, -25, 0, 5), UDim2.new(0, 20, 0, 20), Color3.fromRGB(200, 50, 50), "X")

-------------------------------------------------------------------------------------------------------------------------------

local scrollframe = Instance.new("ScrollingFrame")
scrollframe["Size"] = UDim2.new(1, 0, 0, 230)
scrollframe["Position"] = UDim2.new(0, 0, 0, 65)
scrollframe["CanvasSize"] = UDim2.new(0, 0, 0, 0)
scrollframe["ScrollBarThickness"] = 0
scrollframe["BorderSizePixel"] = 0
scrollframe["BackgroundTransparency"] = 1
scrollframe["BackgroundColor3"] = Color3.fromRGB(20, 20, 20)
scrollframe["Parent"] = frame

local buttoncontainer = Instance.new("Frame")
buttoncontainer["Size"] = UDim2.new(1, 0, 1, 0)
buttoncontainer["Position"] = UDim2.new(0, 5, 0, 0)
buttoncontainer["BackgroundTransparency"] = 1
buttoncontainer["Parent"] = scrollframe

local buttonlayout = Instance.new("UIGridLayout")
buttonlayout["CellPadding"] = UDim2.new(0, 5, 0, 5)
buttonlayout["CellSize"] = UDim2.new(0, 126.2, 0, 60)
buttonlayout["SortOrder"] = Enum.SortOrder.LayoutOrder
buttonlayout["Parent"] = buttoncontainer

-------------------------------------------------------------------------------------------------------------------------------

local oldbuttons = {}

local animations = {
	{name = "California\nGirls", id = 124982597491660, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Helicopter", id = 95301257497525, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Helicopter 2", id = 122951149300674, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Helicopter 3", id = 91257498644328, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Da Hood Dance", id = 108171959207138, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Da Hood Stomp", id = 115048845533448, speed = 1.4, timepos = 0, looped = true, freezeonend = false},
	{name = "Flopping Fish", id = 79075971527754, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Gangnam Style", id = 100531289776679, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Caramelldansen", id = 88315693621494, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Air Circle", id = 94324173536622, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Heart Left", id = 110936682778213, speed = 0, timepos = 0, looped = true, freezeonend = false},
	{name = "Heart Right", id = 84671941093489, speed = 0, timepos = 0, looped = true, freezeonend = false},
	{name = "67", id = 115439144505157, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "6", id = 115439144505157, speed = 0, timepos = 0.2, looped = false, freezeonend = false},
	{name = "7", id = 115439144505157, speed = 0, timepos = 1.2, looped = false, freezeonend = false},
	{name = "Dog", id = 78195344190486, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "MM2 Zen", id = 86872878957632, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Default Dance", id = 88455578674030, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Sit", id = 97185364700038, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Kazotsky Kick", id = 119264600441310, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Fight Stance", id = 116763940575803, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Oh Who Is You", id = 81389876138766, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Sway Sit", id = 130995344283026, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Sway Sit 2", id = 131836270858895, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "The Worm", id = 90333292347820, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Snake", id = 98476854035224, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Peter Griffin Death", id = 129787664584610, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Walter Scene", id = 113475147402830, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Cute Stomach Lay", id = 80754582835479, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Shadow Dio Pose", id = 92266904563270, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Jotaro Pose", id = 122120443600865, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Jojo Pose", id = 120629563851640, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Float Lay", id = 77840765435893, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Biblically Accurate", id = 109873544976020, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Headless", id = 78837807518622, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "ME!ME!ME!", id = 103235915424832, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Plane", id = 82135680487389, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "XavierSoBased", id = 90802740360125, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Chinese Dance", id = 131758838511368, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Slickback", id = 74288964113793, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Car", id = 108747312576405, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Beat Da Koto Nai", id = 93497729736287, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Tank", id = 94915612757079, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Classic Walk", id = 107806791584829, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Weird Creature", id = 87025086742503, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Skibidi Toilet", id = 127154705636043, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Rolling Crybaby", id = 129699431093711, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Thinking", id = 127088545449493, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Fake Death", id = 88130117312312, speed = 1, timepos = 0, looped = false, freezeonend = true},
	{name = "Laced", id = 135611169366768, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Fit Check", id = 81176957565811, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Surrender", id = 100537772865440, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Assumptions", id = 91294374426630, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Griddy", id = 121966805049108, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Take The L", id = 78653596566468, speed = 1, timepos = 0, looped = true, freezeonend = true},
	{name = "Basketball Head Spin", id = 92854797386719, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Parrot Dance", id = 101810746304426, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Shot", id = 102691551292124, speed = 1, timepos = 0, looped = false, freezeonend = true},
	{name = "Ragdoll", id = 136224735234038, speed = 1, timepos = 0, looped = false, freezeonend = true},
	{name = "Sad Sit", id = 100798804992348, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Soda Pop", id = 105459130960429, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Billy Bounce", id = 137501135905857, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Ballin", id = 119242308765484, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Jackhammer", id = 91423662648449, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Monster Mash", id = 137883764619555, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Fumo Plush", id = 107217181254431, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Rizz Backflip", id = 131205329995035, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Float", id = 89523370947906, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Hi", id = 103041144411206, speed = 1, timepos = 0, looped = false, freezeonend = true},
	{name = "Posessed", id = 90708290447388, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Fuck you!", id = 98289978017308, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Silver Surfer", id = 100663712757148, speed = 0.8, timepos = 0, looped = true, freezeonend = false},
	{name = "Tall Thing Idk", id = 118864464720628, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Cat Sit", id = 99424293618796, speed = 1, timepos = 0, looped = true, freezeonend = false},
	{name = "Black Flash", id = 104767795538635, speed = 1, timepos = 0, looped = true, freezeonend = false},
}

local active = {}

local function makebutton(data)
	local button = Instance.new("TextButton")
	button["Name"] = data.name
	button["Size"] = UDim2.new(1, 0, 1, 0)
	button["BackgroundColor3"] = Color3.fromRGB(60, 60, 60)
	button["Text"] = data.name
	button["TextColor3"] = Color3.new(1, 1, 1)
	button["TextSize"] = 16
	button["TextWrapped"] = true
	button["Font"] = Enum.Font.RobotoMono
	button["BorderSizePixel"] = 0
	button["Parent"] = buttoncontainer

	table.insert(oldbuttons, button)

	button["MouseButton1Click"]:Connect(function()
		clik()
		if localplayer.Character then
			local humanoid = localplayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				for id, track in pairs(active) do
					if track then
						track:Stop()
					end
				end
				active = {}

				local animation = Instance.new("Animation")
				animation.AnimationId = "rbxassetid://" .. data.id

				local track = humanoid:LoadAnimation(animation)
				track:Play()
				track.Looped = data.looped
				track.TimePosition = data.timepos
				track:AdjustSpeed(data.speed)
				track:AdjustWeight(999)

				active[data.id] = track

				if data.freezeonend then
					local connection
					connection = track.Stopped:Connect(function()
						if humanoid and humanoid.Parent then
							humanoid.AutoRotate = false
							humanoid.WalkSpeed = 0
							humanoid.JumpPower = 0
						end

						if connection then
							connection:Disconnect()
						end
					end)
				end
			end
		end
	end)
end

for _, anim in ipairs(animations) do
	makebutton(anim)
end

local function filteranims(input)
	input = string.lower(input)

	for _, button in pairs(oldbuttons) do
		button.Visible = false
	end

	for _, button in pairs(oldbuttons) do
		if string.find(string.lower(button.Text), input, 1, true) then
			button.Visible = true
		end
	end

	buttonlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Wait()
	scrollframe["CanvasSize"] = UDim2.new(0, 0, 0, buttonlayout["AbsoluteContentSize"]["Y"])
end

searchbox:GetPropertyChangedSignal("Text"):Connect(function()
	filteranims(searchbox.Text)
end)

-------------------------------------------------------------------------------------------------------------------------------

stopallbutton["MouseButton1Click"]:Connect(function()
	clik()
	for id, track in pairs(active) do
		if track then
			track:Stop()
		end
	end
	active = {}
end)

xbutton["MouseButton1Click"]:Connect(function()
	clik()
	gui:Destroy()
end)

local isminimized = false
local originalsize = frame["Size"]

minimizebutton["MouseButton1Click"]:Connect(function()
	clik()
	isminimized = not isminimized
	if isminimized then
		minimizebutton["Text"] = "+"
		frame["Size"] = UDim2.new(originalsize["X"]["Scale"], originalsize["X"]["Offset"], 0, 30)
		scrollframe["Visible"] = false
	else
		minimizebutton["Text"] = "–"
		frame["Size"] = originalsize
		scrollframe["Visible"] = true
	end
end)

-------------------------------------------------------------------------------------------------------------------------------

buttonlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	buttoncontainer["Size"] = UDim2.new(1, -10, 0, buttonlayout["AbsoluteContentSize"]["Y"])
	scrollframe["CanvasSize"] = UDim2.new(0, 0, 0, buttonlayout["AbsoluteContentSize"]["Y"])
end)

-------------------------------------------------------------------------------------------------------------------------------
