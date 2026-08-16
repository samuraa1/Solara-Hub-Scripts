local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local lastUsername = nil
local dragging = false
local dragInput, dragStart, startPos

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AvatarChangerGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Name = "Main"
Frame.Size = UDim2.new(0, 280, 0, 168)
Frame.Position = UDim2.new(0.5, -140, 0.5, -84)
Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 12)
FrameCorner.Parent = Frame

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Color3.fromRGB(58, 58, 70)
FrameStroke.Thickness = 1
FrameStroke.Parent = Frame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 12)
TitleFix.Position = UDim2.new(0, 0, 1, -12)
TitleFix.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -16, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(240, 240, 245)
Title.Text = "Avatar Changer"
Title.Parent = TitleBar

local Hint = Instance.new("TextLabel")
Hint.BackgroundTransparency = 1
Hint.Size = UDim2.new(0, 90, 1, 0)
Hint.Position = UDim2.new(1, -100, 0, 0)
Hint.Font = Enum.Font.Gotham
Hint.TextSize = 11
Hint.TextXAlignment = Enum.TextXAlignment.Right
Hint.TextColor3 = Color3.fromRGB(140, 140, 155)
Hint.Text = "RShift"
Hint.Parent = TitleBar

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -28, 0, 36)
TextBox.Position = UDim2.new(0, 14, 0, 52)
TextBox.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
TextBox.BorderSizePixel = 0
TextBox.ClearTextOnFocus = false
TextBox.PlaceholderText = "Username or display name"
TextBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 145)
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.Parent = Frame

local TextPad = Instance.new("UIPadding")
TextPad.PaddingLeft = UDim.new(0, 12)
TextPad.PaddingRight = UDim.new(0, 12)
TextPad.Parent = TextBox

local TextCorner = Instance.new("UICorner")
TextCorner.CornerRadius = UDim.new(0, 8)
TextCorner.Parent = TextBox

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1, -28, 0, 36)
Button.Position = UDim2.new(0, 14, 0, 96)
Button.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
Button.BorderSizePixel = 0
Button.AutoButtonColor = false
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Text = "Apply Avatar"
Button.Parent = Frame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = Button

local Status = Instance.new("TextLabel")
Status.BackgroundTransparency = 1
Status.Size = UDim2.new(1, -28, 0, 20)
Status.Position = UDim2.new(0, 14, 0, 138)
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.TextColor3 = Color3.fromRGB(150, 150, 165)
Status.Text = "Enter a player name"
Status.Parent = Frame

local COSMETIC = {
    Accessory = true,
    Hat = true,
    BodyColors = true,
    CharacterMesh = true,
    Shirt = true,
    Pants = true,
    ShirtGraphic = true,
}

local function setStatus(text, color)
    Status.Text = text
    Status.TextColor3 = color or Color3.fromRGB(150, 150, 165)
end

local function trim(s)
    return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""):gsub("^@", ""))
end

local function findPlayer(query)
    query = trim(query)
    if query == "" then
        return nil
    end
    local q = query:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower() == q or p.DisplayName:lower() == q then
            return p
        end
    end
    local matches = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():find(q, 1, true) or p.DisplayName:lower():find(q, 1, true) then
            table.insert(matches, p)
        end
    end
    if #matches == 1 then
        return matches[1]
    end
    for _, p in ipairs(matches) do
        if p.Name:lower():sub(1, #q) == q or p.DisplayName:lower():sub(1, #q) == q then
            return p
        end
    end
    return matches[1]
end

local function clearCosmetics(char)
    for _, c in ipairs(char:GetChildren()) do
        if COSMETIC[c.ClassName] then
            c:Destroy()
        end
    end
end

local function copyFace(fromHead, toHead)
    if not fromHead or not toHead then
        return
    end
    local src = fromHead:FindFirstChild("face") or fromHead:FindFirstChild("Face") or fromHead:FindFirstChildOfClass("Decal")
    if not src then
        return
    end
    local dst = toHead:FindFirstChild("face") or toHead:FindFirstChild("Face") or toHead:FindFirstChildOfClass("Decal")
    if dst then
        dst.Texture = src.Texture
    else
        src:Clone().Parent = toHead
    end
end

local function copyBodyLooks(fromChar, toChar)
    for _, part in ipairs(toChar:GetChildren()) do
        if part:IsA("BasePart") then
            local src = fromChar:FindFirstChild(part.Name)
            if src and src:IsA("BasePart") then
                part.Color = src.Color
                part.Material = src.Material
                if src:IsA("MeshPart") and part:IsA("MeshPart") then
                    pcall(function()
                        part.TextureID = src.TextureID
                    end)
                end
            end
        end
    end
end

local function cloneCosmetics(fromChar, toChar, hum)
    for _, c in ipairs(fromChar:GetChildren()) do
        if c:IsA("Accessory") or c:IsA("Hat") then
            local clone = c:Clone()
            local ok = pcall(function()
                hum:AddAccessory(clone)
            end)
            if not ok or clone.Parent == nil then
                clone.Parent = toChar
            end
        elseif c:IsA("Shirt") or c:IsA("Pants") or c:IsA("ShirtGraphic") or c:IsA("BodyColors") or c:IsA("CharacterMesh") then
            c:Clone().Parent = toChar
        end
    end
    copyFace(fromChar:FindFirstChild("Head"), toChar:FindFirstChild("Head"))
    copyBodyLooks(fromChar, toChar)
end

local function applyDescription(hum, desc)
    local ok = pcall(function()
        if hum.ApplyDescriptionClientServer then
            hum:ApplyDescriptionClientServer(desc)
        else
            hum:ApplyDescription(desc)
        end
    end)
    return ok
end

local function getDescription(targetPlayer, username)
    if targetPlayer then
        local tChar = targetPlayer.Character
        local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
        if tHum then
            local ok, desc = pcall(function()
                return tHum:GetAppliedDescription()
            end)
            if ok and desc then
                return desc
            end
        end
        local ok, desc = pcall(Players.GetHumanoidDescriptionFromUserId, Players, targetPlayer.UserId)
        if ok then
            return desc
        end
    end
    local ok, userId = pcall(Players.GetUserIdFromNameAsync, Players, username)
    if not ok or not userId then
        return nil
    end
    local ok2, desc = pcall(Players.GetHumanoidDescriptionFromUserId, Players, userId)
    if ok2 then
        return desc
    end
    return nil
end

local function apply_avatar(username)
    task.spawn(function()
        username = trim(username)
        if username == "" then
            setStatus("Enter a player name", Color3.fromRGB(255, 170, 70))
            return
        end

        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hum = char:WaitForChild("Humanoid", 10)
        if not hum then
            setStatus("Humanoid not found", Color3.fromRGB(255, 90, 90))
            return
        end

        local targetPlayer = findPlayer(username)
        setStatus("Applying...", Color3.fromRGB(170, 190, 255))

        local desc = getDescription(targetPlayer, username)
        if desc then
            applyDescription(hum, desc)
            task.wait(0.15)
        end

        local targetChar = targetPlayer and targetPlayer.Character
        if targetChar and targetChar:FindFirstChildOfClass("Humanoid") then
            clearCosmetics(char)
            cloneCosmetics(targetChar, char, hum)
            lastUsername = targetPlayer.Name
            setStatus("Copied " .. targetPlayer.DisplayName, Color3.fromRGB(110, 220, 140))
            return
        end

        if not desc then
            setStatus("User not found", Color3.fromRGB(255, 90, 90))
            return
        end

        lastUsername = username
        setStatus("Applied " .. username, Color3.fromRGB(110, 220, 140))
    end)
end

local function start(username)
    username = trim(username)
    if username == "" then
        setStatus("Enter a player name", Color3.fromRGB(255, 170, 70))
        return
    end
    lastUsername = username
    apply_avatar(username)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if not lastUsername then
        return
    end
    char:WaitForChild("Humanoid", 10)
    task.wait(0.65)
    apply_avatar(lastUsername)
end)

Button.MouseEnter:Connect(function()
    Button.BackgroundColor3 = Color3.fromRGB(95, 150, 255)
end)
Button.MouseLeave:Connect(function()
    Button.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
end)
Button.MouseButton1Click:Connect(function()
    start(TextBox.Text)
end)
TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        start(TextBox.Text)
    end
end)

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local open = true
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end
    if input.KeyCode == Enum.KeyCode.RightShift then
        open = not open
        Frame.Visible = open
    end
end)
