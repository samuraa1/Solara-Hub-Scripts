local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local lastUsername = nil
local dragging = false
local dragInput, dragStart, startPos
local open = true
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

local BODY_PARTS = {
    HumanoidRootPart = true,
    Head = true,
    Torso = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    UpperTorso = true,
    LowerTorso = true,
    LeftUpperArm = true,
    LeftLowerArm = true,
    LeftHand = true,
    RightUpperArm = true,
    RightLowerArm = true,
    RightHand = true,
    LeftUpperLeg = true,
    LeftLowerLeg = true,
    LeftFoot = true,
    RightUpperLeg = true,
    RightLowerLeg = true,
    RightFoot = true,
}

local COSMETIC = {
    Accessory = true,
    Hat = true,
    Accoutrement = true,
    BodyColors = true,
    CharacterMesh = true,
    Shirt = true,
    Pants = true,
    ShirtGraphic = true,
}

local SCALE_NAMES = {
    "BodyWidthScale",
    "BodyHeightScale",
    "BodyDepthScale",
    "HeadScale",
    "BodyProportionScale",
    "BodyTypeScale",
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AvatarChangerGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local UIScale = Instance.new("UIScale")
UIScale.Scale = isMobile and 1.15 or 1
UIScale.Parent = ScreenGui

local Frame = Instance.new("Frame")
Frame.Name = "Main"
Frame.Size = UDim2.new(0, 300, 0, 176)
Frame.Position = UDim2.new(0.5, -150, 0.5, -88)
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
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 14)
TitleFix.Position = UDim2.new(0, 0, 1, -14)
TitleFix.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -52, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextColor3 = Color3.fromRGB(240, 240, 245)
Title.Text = "Avatar Changer"
Title.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "Close"
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 62)
CloseBtn.BorderSizePixel = 0
CloseBtn.AutoButtonColor = false
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.fromRGB(230, 230, 235)
CloseBtn.Text = "×"
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -28, 0, 40)
TextBox.Position = UDim2.new(0, 14, 0, 56)
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
Button.Size = UDim2.new(1, -28, 0, 40)
Button.Position = UDim2.new(0, 14, 0, 104)
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
Status.Position = UDim2.new(0, 14, 0, 148)
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.TextXAlignment = Enum.TextXAlignment.Left
Status.TextColor3 = Color3.fromRGB(150, 150, 165)
Status.Text = "Enter a player name"
Status.Parent = Frame

local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "Reopen"
OpenBtn.Size = UDim2.new(0, 128, 0, 36)
OpenBtn.Position = UDim2.new(0, 16, 0, 80)
OpenBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
OpenBtn.BorderSizePixel = 0
OpenBtn.AutoButtonColor = false
OpenBtn.Visible = false
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 13
OpenBtn.TextColor3 = Color3.fromRGB(240, 240, 245)
OpenBtn.Text = "Avatar Changer"
OpenBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 10)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(70, 130, 255)
OpenStroke.Thickness = 1
OpenStroke.Parent = OpenBtn

local function setOpen(state)
    open = state
    Frame.Visible = state
    OpenBtn.Visible = not state
end

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

local function clearWelds(inst)
    for _, w in ipairs(inst:GetDescendants()) do
        if w:IsA("Weld") or w:IsA("WeldConstraint") or w:IsA("Motor6D") or w:IsA("RigidConstraint") then
            w:Destroy()
        end
    end
end

local function findAttachment(char, name, ignore)
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("Attachment") and d.Name == name and not d:IsDescendantOf(ignore) then
            return d
        end
    end
end

local function weldAccessory(char, accessory)
    local handle = accessory:FindFirstChild("Handle")
    accessory.Parent = char
    if not handle or not handle:IsA("BasePart") then
        return
    end

    clearWelds(accessory)
    handle.CanCollide = false
    handle.Massless = true
    handle.Anchored = false

    local handleAtt = handle:FindFirstChildOfClass("Attachment")
    local targetAtt = handleAtt and findAttachment(char, handleAtt.Name, accessory)
    local targetPart = (targetAtt and targetAtt.Parent) or char:FindFirstChild("Head")
    if not targetPart or not targetPart:IsA("BasePart") then
        return
    end

    if targetAtt and handleAtt then
        local weld = Instance.new("Weld")
        weld.Name = "AccessoryWeld"
        weld.Part0 = targetPart
        weld.Part1 = handle
        weld.C0 = targetAtt.CFrame
        weld.C1 = handleAtt.CFrame
        weld.Parent = handle
    else
        local weld = Instance.new("Weld")
        weld.Name = "AccessoryWeld"
        weld.Part0 = targetPart
        weld.Part1 = handle
        weld.Parent = handle
    end
end

local function retargetWelds(clone, fromChar, toChar)
    for _, w in ipairs(clone:GetDescendants()) do
        if w:IsA("Weld") or w:IsA("Motor6D") or w:IsA("WeldConstraint") then
            local function remap(part)
                if not part then
                    return nil
                end
                if part == fromChar or fromChar:IsAncestorOf(part) then
                    if BODY_PARTS[part.Name] then
                        return toChar:FindFirstChild(part.Name)
                    end
                end
                return part
            end
            if w:IsA("WeldConstraint") then
                w.Part0 = remap(w.Part0)
                w.Part1 = remap(w.Part1)
            else
                w.Part0 = remap(w.Part0)
                w.Part1 = remap(w.Part1)
            end
        end
    end
end

local function clearCosmetics(char)
    for _, c in ipairs(char:GetChildren()) do
        if COSMETIC[c.ClassName] or c:IsA("Accoutrement") then
            c:Destroy()
        elseif c:IsA("BasePart") and not BODY_PARTS[c.Name] then
            c:Destroy()
        elseif c:IsA("Folder") then
            for _, nested in ipairs(c:GetChildren()) do
                if nested:IsA("Accoutrement") then
                    nested:Destroy()
                end
            end
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

local function copyHeadMesh(fromHead, toHead)
    if not fromHead or not toHead then
        return
    end
    local srcMesh = fromHead:FindFirstChildOfClass("SpecialMesh")
    if srcMesh then
        local dstMesh = toHead:FindFirstChildOfClass("SpecialMesh")
        if dstMesh then
            dstMesh.MeshId = srcMesh.MeshId
            dstMesh.TextureId = srcMesh.TextureId
            dstMesh.Scale = srcMesh.Scale
            dstMesh.Offset = srcMesh.Offset
            dstMesh.MeshType = srcMesh.MeshType
        else
            srcMesh:Clone().Parent = toHead
        end
    end
end

local function copyWrapTargets(fromChar, toChar)
    for _, srcPart in ipairs(fromChar:GetChildren()) do
        if srcPart:IsA("BasePart") then
            local dstPart = toChar:FindFirstChild(srcPart.Name)
            if dstPart and dstPart:IsA("BasePart") then
                local wrap = srcPart:FindFirstChildOfClass("WrapTarget")
                if wrap and not dstPart:FindFirstChildOfClass("WrapTarget") then
                    wrap:Clone().Parent = dstPart
                end
            end
        end
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
                        part.MeshId = src.MeshId
                    end)
                    pcall(function()
                        part.TextureID = src.TextureID
                    end)
                end
            end
        end
    end
end

local function copyScales(fromHum, toHum)
    for _, name in ipairs(SCALE_NAMES) do
        local src = fromHum:FindFirstChild(name)
        local dst = toHum:FindFirstChild(name)
        if src and dst and src:IsA("NumberValue") and dst:IsA("NumberValue") then
            dst.Value = src.Value
        end
    end
end

local function eachAccessory(char, fn)
    for _, c in ipairs(char:GetChildren()) do
        if c:IsA("Accoutrement") then
            fn(c)
        elseif c:IsA("Folder") then
            for _, nested in ipairs(c:GetChildren()) do
                if nested:IsA("Accoutrement") then
                    fn(nested)
                end
            end
        end
    end
end

local function cloneCosmetics(fromChar, toChar, hum)
    copyWrapTargets(fromChar, toChar)
    copyScales(fromChar:FindFirstChildOfClass("Humanoid"), hum)

    eachAccessory(fromChar, function(acc)
        local clone = acc:Clone()
        weldAccessory(toChar, clone)
    end)

    for _, c in ipairs(fromChar:GetChildren()) do
        if c:IsA("Shirt") or c:IsA("Pants") or c:IsA("ShirtGraphic") or c:IsA("BodyColors") or c:IsA("CharacterMesh") then
            local old = toChar:FindFirstChild(c.Name)
            if old and (old.ClassName == c.ClassName) then
                old:Destroy()
            end
            c:Clone().Parent = toChar
        elseif c:IsA("BasePart") and not BODY_PARTS[c.Name] then
            local clone = c:Clone()
            clone.Parent = toChar
            retargetWelds(clone, fromChar, toChar)
        end
    end

    local fromHead = fromChar:FindFirstChild("Head")
    local toHead = toChar:FindFirstChild("Head")
    copyFace(fromHead, toHead)
    copyHeadMesh(fromHead, toHead)
    copyBodyLooks(fromChar, toChar)
end

local function applyDescription(hum, desc)
    return pcall(function()
        if hum.ApplyDescriptionClientServer then
            hum:ApplyDescriptionClientServer(desc)
        else
            hum:ApplyDescription(desc)
        end
    end)
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
            task.wait(0.2)
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

CloseBtn.MouseEnter:Connect(function()
    CloseBtn.BackgroundColor3 = Color3.fromRGB(190, 70, 70)
end)
CloseBtn.MouseLeave:Connect(function()
    CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 62)
end)
CloseBtn.MouseButton1Click:Connect(function()
    setOpen(false)
end)
OpenBtn.MouseButton1Click:Connect(function()
    setOpen(true)
end)

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function beginDrag(input, target)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = target.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end

TitleBar.InputBegan:Connect(function(input)
    beginDrag(input, Frame)
end)
OpenBtn.InputBegan:Connect(function(input)
    beginDrag(input, OpenBtn)
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
OpenBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        if Frame.Visible then
            update(input)
        else
            local delta = input.Position - dragStart
            OpenBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        setOpen(not open)
    end
end)
