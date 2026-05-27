-- Calculator GUI Script
-- Compatible with Wave, Synapse, KRNL, Script-Ware, and most executors

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove old gui if reinjecting
if PlayerGui:FindFirstChild("CalculatorGui") then
	PlayerGui:FindFirstChild("CalculatorGui"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CalculatorGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Wave / some executors block PlayerGui parenting; fall back to CoreGui
local ok = pcall(function()
	ScreenGui.Parent = PlayerGui
end)
if not ok then
	ScreenGui.Parent = game:GetService("CoreGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 340)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 22)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 60, 60)
MainStroke.Thickness = 1.2
MainStroke.Transparency = 0.5
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Calculator"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -31, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseBtn.BackgroundTransparency = 0.2
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

local DisplayFrame = Instance.new("Frame")
DisplayFrame.Size = UDim2.new(1, -16, 0, 54)
DisplayFrame.Position = UDim2.new(0, 8, 0, 40)
DisplayFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
DisplayFrame.BackgroundTransparency = 0.1
DisplayFrame.BorderSizePixel = 0
DisplayFrame.Parent = MainFrame

local DisplayCorner = Instance.new("UICorner")
DisplayCorner.CornerRadius = UDim.new(0, 12)
DisplayCorner.Parent = DisplayFrame

local ExpressionLabel = Instance.new("TextLabel")
ExpressionLabel.Size = UDim2.new(1, -10, 0, 20)
ExpressionLabel.Position = UDim2.new(0, 5, 0, 2)
ExpressionLabel.BackgroundTransparency = 1
ExpressionLabel.Text = ""
ExpressionLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
ExpressionLabel.TextSize = 11
ExpressionLabel.Font = Enum.Font.Gotham
ExpressionLabel.TextXAlignment = Enum.TextXAlignment.Right
ExpressionLabel.TextTruncate = Enum.TextTruncate.AtEnd
ExpressionLabel.Parent = DisplayFrame

local DisplayLabel = Instance.new("TextLabel")
DisplayLabel.Size = UDim2.new(1, -10, 0, 28)
DisplayLabel.Position = UDim2.new(0, 5, 0, 22)
DisplayLabel.BackgroundTransparency = 1
DisplayLabel.Text = "0"
DisplayLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
DisplayLabel.TextSize = 22
DisplayLabel.Font = Enum.Font.GothamBold
DisplayLabel.TextXAlignment = Enum.TextXAlignment.Right
DisplayLabel.TextTruncate = Enum.TextTruncate.AtEnd
DisplayLabel.Parent = DisplayFrame

local ButtonGrid = Instance.new("Frame")
ButtonGrid.Size = UDim2.new(1, -16, 0, 232)
ButtonGrid.Position = UDim2.new(0, 8, 0, 100)
ButtonGrid.BackgroundTransparency = 1
ButtonGrid.Parent = MainFrame

local GridLayout = Instance.new("UIGridLayout")
GridLayout.CellSize = UDim2.new(0, 42, 0, 38)
GridLayout.CellPadding = UDim2.new(0, 4, 0, 4)
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
GridLayout.Parent = ButtonGrid

local buttons = {
	{"C",  "C",  "action"},
	{"±",  "±",  "special"},
	{"%",  "%",  "operator"},
	{"÷",  "/",  "operator"},
	{"7",  "7",  "number"},
	{"8",  "8",  "number"},
	{"9",  "9",  "number"},
	{"×",  "*",  "operator"},
	{"4",  "4",  "number"},
	{"5",  "5",  "number"},
	{"6",  "6",  "number"},
	{"−",  "-",  "operator"},
	{"1",  "1",  "number"},
	{"2",  "2",  "number"},
	{"3",  "3",  "number"},
	{"+",  "+",  "operator"},
	{"√",  "√",  "special"},
	{"0",  "0",  "number"},
	{".",  ".",  "number"},
	{"=",  "=",  "action"},
}

local function getButtonColor(btnType)
	if btnType == "action" then
		return Color3.fromRGB(255, 149, 0), Color3.fromRGB(255, 255, 255)
	elseif btnType == "operator" then
		return Color3.fromRGB(50, 50, 55), Color3.fromRGB(255, 149, 0)
	elseif btnType == "special" then
		return Color3.fromRGB(40, 40, 45), Color3.fromRGB(200, 200, 200)
	else
		return Color3.fromRGB(35, 35, 38), Color3.fromRGB(230, 230, 230)
	end
end

-- State
local currentInput   = ""
local expression     = ""
local justCalculated = false
local MAX_INPUT_DIGITS = 12

local function updateDisplay()
	if currentInput == "" then
		DisplayLabel.Text = expression == "" and "0" or ""
	else
		DisplayLabel.Text = currentInput
	end
	ExpressionLabel.Text = expression
end

-- Pure Lua math evaluator — no load(), works in all executors
local function evalExpr(expr)
	-- Tokenise into numbers and operators
	local tokens = {}
	local i = 1
	while i <= #expr do
		local ch = expr:sub(i, i)
		if ch:match("%d") or (ch == "." and #tokens > 0) then
			local num = ""
			while i <= #expr and (expr:sub(i,i):match("%d") or expr:sub(i,i) == ".") do
				num = num .. expr:sub(i,i)
				i = i + 1
			end
			table.insert(tokens, tonumber(num))
		elseif ch == "-" and (#tokens == 0 or type(tokens[#tokens]) == "string") then
			-- Unary minus
			local num = "-"
			i = i + 1
			while i <= #expr and (expr:sub(i,i):match("%d") or expr:sub(i,i) == ".") do
				num = num .. expr:sub(i,i)
				i = i + 1
			end
			table.insert(tokens, tonumber(num))
		elseif ch == "+" or ch == "-" or ch == "*" or ch == "/" then
			table.insert(tokens, ch)
			i = i + 1
		else
			i = i + 1
		end
	end

	if #tokens == 0 then return nil end

	-- Pass 1: resolve * and / (left to right)
	local pass1 = {tokens[1]}
	local idx = 2
	while idx <= #tokens do
		local op = tokens[idx]
		local right = tokens[idx + 1]
		if op == "*" then
			pass1[#pass1] = pass1[#pass1] * right
			idx = idx + 2
		elseif op == "/" then
			if right == 0 then return nil end
			pass1[#pass1] = pass1[#pass1] / right
			idx = idx + 2
		else
			table.insert(pass1, op)
			table.insert(pass1, right)
			idx = idx + 2
		end
	end

	-- Pass 2: resolve + and - (left to right)
	local result = pass1[1]
	local j = 2
	while j <= #pass1 do
		local op = pass1[j]
		local right = pass1[j + 1]
		if op == "+" then
			result = result + right
		elseif op == "-" then
			result = result - right
		end
		j = j + 2
	end

	return result
end

local function formatResult(num)
	if num ~= num then return "0" end -- NaN guard
	if num == math.floor(num) and math.abs(num) < 1e13 then
		return tostring(math.floor(num))
	end
	local s = string.format("%.10g", num)
	return s
end

local function appendDigit(digit)
	if justCalculated then
		currentInput   = ""
		expression     = ""
		justCalculated = false
	end
	if digit == "." then
		if currentInput == "" then currentInput = "0" end
		if currentInput:find("%.") then return end
	end
	local digitCount = #currentInput:gsub("[^0-9]", "")
	if digitCount >= MAX_INPUT_DIGITS then return end
	currentInput = currentInput .. digit
	updateDisplay()
end

local function appendOperator(op)
	justCalculated = false
	if currentInput == "" and expression == "" then return end
	if currentInput ~= "" then
		expression   = expression .. currentInput
		currentInput = ""
	else
		if expression:sub(-1):match("[%+%-%*/]") then
			expression = expression:sub(1, -2)
		end
	end
	expression = expression .. op
	updateDisplay()
end

local function calculate()
	local fullExpr = expression .. currentInput
	if fullExpr == "" then return end

	local displayExpr = fullExpr
		:gsub("%*", "×")
		:gsub("/",  "÷")
		:gsub("%-", "−")
	expression = displayExpr .. " ="

	local result = evalExpr(fullExpr)
	if result ~= nil then
		currentInput = formatResult(result)
	else
		-- Fallback: keep last valid input rather than showing error
		currentInput = currentInput ~= "" and currentInput or "0"
	end

	justCalculated = true
	updateDisplay()
end

local function handleButton(label, value)
	if label == "C" then
		currentInput   = ""
		expression     = ""
		justCalculated = false
		updateDisplay()

	elseif label == "=" then
		calculate()

	elseif label == "±" then
		if currentInput ~= "" and currentInput ~= "0" then
			currentInput = currentInput:sub(1,1) == "-"
				and currentInput:sub(2)
				or  "-" .. currentInput
			updateDisplay()
		end

	elseif label == "%" then
		if currentInput ~= "" then
			local num = tonumber(currentInput)
			if num then
				currentInput = formatResult(num / 100)
				updateDisplay()
			end
		end

	elseif label == "√" then
		if currentInput ~= "" then
			local num = tonumber(currentInput)
			if num and num >= 0 then
				currentInput = formatResult(math.sqrt(num))
				updateDisplay()
			end
		end

	elseif value == "+" or value == "-" or value == "*" or value == "/" then
		appendOperator(value)

	else
		appendDigit(value)
	end
end

for _, btnData in ipairs(buttons) do
	local label, value, btnType = btnData[1], btnData[2], btnData[3]
	local bgColor, textColor = getButtonColor(btnType)

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 42, 0, 38)
	btn.BackgroundColor3 = bgColor
	btn.BackgroundTransparency = 0.05
	btn.Text = label
	btn.TextColor3 = textColor
	btn.TextSize = 15
	btn.Font = (label == "=" and Enum.Font.GothamBold or Enum.Font.Gotham)
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.Parent = ButtonGrid

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 10)
	btnCorner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		handleButton(label, value)
	end)

	btn.MouseEnter:Connect(function() btn.BackgroundTransparency = 0 end)
	btn.MouseLeave:Connect(function() btn.BackgroundTransparency = 0.05 end)
end

-- Floating reopen circle
local ReopenBtn = Instance.new("TextButton")
ReopenBtn.Name = "ReopenBtn"
ReopenBtn.Size = UDim2.new(0, 72, 0, 72)
ReopenBtn.Position = UDim2.new(0, 20, 0.5, -36)
ReopenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ReopenBtn.BackgroundTransparency = 0.1
ReopenBtn.Text = "Calcu-\nlator"
ReopenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenBtn.TextSize = 12
ReopenBtn.Font = Enum.Font.GothamBold
ReopenBtn.BorderSizePixel = 0
ReopenBtn.Visible = false
ReopenBtn.Active = true
ReopenBtn.Draggable = true
ReopenBtn.Parent = ScreenGui

local ReopenCorner = Instance.new("UICorner")
ReopenCorner.CornerRadius = UDim.new(1, 0)
ReopenCorner.Parent = ReopenBtn

local ReopenStroke = Instance.new("UIStroke")
ReopenStroke.Color = Color3.fromRGB(255, 149, 0)
ReopenStroke.Thickness = 2
ReopenStroke.Parent = ReopenBtn

CloseBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	ReopenBtn.Visible = true
end)

ReopenBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	ReopenBtn.Visible = false
end)

updateDisplay()
