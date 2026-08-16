local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local lastName

local gui = Instance.new("ScreenGui")
gui.Name = "AvatarChangerGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = LP:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 148)
frame.Position = UDim2.new(0.5, -130, 0.5, -74)
frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 36)
title.BackgroundTransparency = 1
title.Text = "Avatar Changer"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local pad = Instance.new("UIPadding", title)
pad.PaddingLeft = UDim.new(0, 14)

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -34, 0, 4)
close.BackgroundColor3 = Color3.fromRGB(50, 50, 62)
close.Text = "×"
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.BorderSizePixel = 0
close.Parent = frame
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 8)

local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -28, 0, 34)
box.Position = UDim2.new(0, 14, 0, 42)
box.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
box.PlaceholderText = "Username or display name"
box.Text = ""
box.TextColor3 = Color3.new(1, 1, 1)
box.Font = Enum.Font.Gotham
box.TextSize = 14
box.ClearTextOnFocus = false
box.BorderSizePixel = 0
box.Parent = frame
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -28, 0, 34)
btn.Position = UDim2.new(0, 14, 0, 84)
btn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
btn.Text = "Apply Avatar"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.BorderSizePixel = 0
btn.Parent = frame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -28, 0, 18)
status.Position = UDim2.new(0, 14, 0, 122)
status.BackgroundTransparency = 1
status.Text = "Enter a player name"
status.TextColor3 = Color3.fromRGB(150, 150, 165)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = frame

local mini = Instance.new("TextButton")
mini.Size = UDim2.new(0, 120, 0, 32)
mini.Position = UDim2.new(0, 16, 0, 80)
mini.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
mini.Text = "Avatar Changer"
mini.TextColor3 = Color3.new(1, 1, 1)
mini.Font = Enum.Font.GothamBold
mini.TextSize = 12
mini.Visible = false
mini.BorderSizePixel = 0
mini.Parent = gui
Instance.new("UICorner", mini).CornerRadius = UDim.new(0, 8)

local function say(t, c)
    status.Text = t
    status.TextColor3 = c or Color3.fromRGB(150, 150, 165)
end

local function findPlayer(q)
    q = tostring(q or ""):gsub("^%s+", ""):gsub("%s+$", ""):gsub("^@", ""):lower()
    if q == "" then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower() == q or p.DisplayName:lower() == q then
            return p
        end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower():find(q, 1, true) or p.DisplayName:lower():find(q, 1, true) then
            return p
        end
    end
end

local function remap(part, clone, dst)
    if not part then return end
    if part == clone or part:IsDescendantOf(clone) then return part end
    return dst:FindFirstChild(part.Name) or dst:FindFirstChild("Head")
end

local function copyLook(src, dst)
    for _, v in ipairs(dst:GetChildren()) do
        if v:IsA("Accessory") or v:IsA("Hat") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
            v:Destroy()
        end
    end

    for _, v in ipairs(src:GetChildren()) do
        if v:IsA("Accessory") or v:IsA("Hat") then
            local c = v:Clone()
            c.Parent = dst
            for _, w in ipairs(c:GetDescendants()) do
                if w:IsA("Weld") or w:IsA("Motor6D") then
                    w.Part0 = remap(w.Part0, c, dst)
                    w.Part1 = remap(w.Part1, c, dst)
                elseif w:IsA("RigidConstraint") and w.Attachment1 then
                    for _, d in ipairs(dst:GetDescendants()) do
                        if d:IsA("Attachment") and d.Name == w.Attachment1.Name and not d:IsDescendantOf(c) then
                            w.Attachment1 = d
                            break
                        end
                    end
                end
            end
        elseif v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("BodyColors") or v:IsA("CharacterMesh") then
            v:Clone().Parent = dst
        end
    end

    for _, p in ipairs(dst:GetChildren()) do
        if p:IsA("BasePart") then
            local s = src:FindFirstChild(p.Name)
            if s and s:IsA("BasePart") then
                p.Color = s.Color
            end
        end
    end

    local a, b = src:FindFirstChild("Head"), dst:FindFirstChild("Head")
    if a and b then
        local d1, d2 = a:FindFirstChildOfClass("Decal"), b:FindFirstChildOfClass("Decal")
        if d1 and d2 then
            d2.Texture = d1.Texture
        end
    end
end

local function apply(name)
    local plr = findPlayer(name)
    local char = LP.Character
    if not char then
        say("No character", Color3.fromRGB(255, 90, 90))
        return
    end
    if not plr or not plr.Character then
        say("Player not in this server", Color3.fromRGB(255, 90, 90))
        return
    end
    lastName = plr.Name
    copyLook(plr.Character, char)
    say("Copied " .. plr.DisplayName, Color3.fromRGB(110, 220, 140))
end

btn.MouseButton1Click:Connect(function()
    apply(box.Text)
end)
box.FocusLost:Connect(function(enter)
    if enter then apply(box.Text) end
end)

close.MouseButton1Click:Connect(function()
    frame.Visible = false
    mini.Visible = true
end)
mini.MouseButton1Click:Connect(function()
    frame.Visible = true
    mini.Visible = false
end)

LP.CharacterAdded:Connect(function(char)
    if lastName then
        task.wait(0.7)
        local plr = Players:FindFirstChild(lastName)
        if plr and plr.Character then
            copyLook(plr.Character, char)
        end
    end
end)

local dragging, startIn, startPos
local function drag(who)
    who.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = who
            startIn = input.Position
            startPos = who.Position
        end
    end)
end
drag(frame)
drag(mini)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - startIn
        dragging.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = nil
    end
end)
