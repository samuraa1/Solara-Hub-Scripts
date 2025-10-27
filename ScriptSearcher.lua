type Data = {
	Script: BaseScript,
	Path: string,
	Selectable: unknown?,
    SelectableObject: unknown?
}
type Scripts = {[number]: Data}

local BLACKLISTED_PATHS = {
	workspace,
	game:GetService("Players"),
	game:GetService("StarterGui"),
    game:GetService("CorePackages"),
    game:GetService("CoreGui"),
}

--// Studio stuff
decompile = decompile or function() return "" end
cloneref = cloneref or function(...) return ... end

local Scripts = {} :: Scripts
local UpdateList
local CurrentSearch = ""
local CurrentSelectable = nil
local Index = 0

local function ParentAllowed(Script: BaseScript): boolean
	for _, Parent in next, BLACKLISTED_PATHS do
		if Script:IsDescendantOf(Parent) then
			return false
		end
	end
	return true
end

local function IsAllowed(Script)
    if not (Script:IsA("BaseScript") or Script:IsA("ModuleScript")) then return end
	if not ParentAllowed(Script) then return end
    if not Script then return end

    return true
end

local function AddScript(Script)
    if not Script then return end
    local Success, Clone = pcall(Script.Clone, Script)
    if not Success then return end

	--// Allowed?
	if not IsAllowed(Script) or not Clone then
        if Clone then Clone:Destroy() end
        return
	end

    if Clone:IsA("BaseScript") then
        Clone.Enabled = false
    end
	
	local Data = {
		Script = Clone,
		Path = Script:GetFullName()
	}
	table.insert(Scripts, Data)
	
	--// Update UI
	if UpdateList then
		UpdateList(Data)
	end
end

--// Cloneref parents
for Index, Parent in next, BLACKLISTED_PATHS do
	BLACKLISTED_PATHS[Index] = cloneref(Parent)
end

--// Collection
for _, Script in game:GetDescendants() do
	AddScript(Script)
end
game.DescendantAdded:Connect(AddScript)

--// Until loaded
repeat wait() until game:IsLoaded()

local ReGui = loadstring(game:HttpGet('https://raw.githubusercontent.com/depthso/Dear-ReGui/refs/heads/main/ReGui.lua'))()

--// Window
local Window = ReGui:Window({
	Size = UDim2.fromOffset(600, 250),
	NoScroll = true,
	Title = "Script search | Depso"
}):Center()
local Layout = Window:List({
	UiPadding = 2,
	VerticalFlex = Enum.UIFlexAlignment.Fill,
	FillDirection = Enum.FillDirection.Vertical,
	Size = UDim2.fromScale(1, 1)
})

--// List
local ListLayout = Layout:Canvas({
	FillDirection = Enum.FillDirection.Vertical,
	Size = UDim2.new(0.45, 0, 1, 0),
	UiPadding = 2,
	Fill = true
})
local Search = ListLayout:InputText({
	Size = UDim2.new(1, 0, 0, 20),
	Label = "",
	Value = "",
	Placeholder = "Search..."
})
local List = ListLayout:Canvas({
	Scroll = true,
	UiPadding = 0,
	AutomaticSize = Enum.AutomaticSize.None,
	FlexMode = Enum.UIFlexMode.None,
	Fill = true
})

--// Editor
local EditorLayout = Layout:Canvas({
	FillDirection = Enum.FillDirection.Vertical,
    Size = UDim2.new(0.55, 0, 1, 0),
	UiPadding = 2,
	Fill = true
})
local Thing = EditorLayout:CodeEditor({
	Text = "print('oh this cool')",
	Fill = true,
})
local Row = EditorLayout:Row()
Row:Button({
	Text = "Copy",
	Callback = function()
		setclipboard(Thing:GetText())
	end,
})

--// Search functionality
local function SetVisible(Script: Data)
    local Path = Script.Path:lower()
    local Selectable = Script.SelectableObject

	if not Selectable then return end
	Selectable.Visible = Path:find(CurrentSearch) and true
end
Search.Callback = function(_, Input: string)
	CurrentSearch = Input:lower()
	for _, Script in next, Scripts do
        SetVisible(Script)
	end
end

--// Scripts
local function ViewScript(Data: Data)
    --// Update selectables
    local Selectable = Data.Selectable
    Selectable:SetSelected(true)
    if CurrentSelectable then
        CurrentSelectable:SetSelected(false)
    end
    CurrentSelectable = Selectable

    --// Decompile
	local Decompiled = decompile(Data.Script)
	local Source = `-- {Data.Path}\n{Decompiled}`
	Thing:SetText(Source)
end
local function UpdateList(Data: Data)
    --// Lazy loading
    Index += 1
    if Index > 20 then
        Index = 0
        task.wait()
    end

    --// Selectable
	local Selectable, Object = List:Selectable({
		Text = Data.Path:sub(1, 100),
		Callback = function()
			ViewScript(Data)
		end,
	})

    --// Set visible
    Data.SelectableObject = Object
    Data.Selectable = Selectable
    SetVisible(Data)
end

for _, Script in next, Scripts do
	UpdateList(Script)
end
