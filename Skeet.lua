--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 
]=]

local G2L = {};

-- StarterGui.new
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[new]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
G2L["1"]["ResetOnSpawn"] = false;

-- StarterGui.new.baza
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(40, 41, 41);
G2L["2"]["Size"] = UDim2.new(0, 607, 0, 401);
G2L["2"]["Position"] = UDim2.new(0.41645, 0, 0.41567, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[baza]];

-- StarterGui.new.baza.zadnica
G2L["3"] = Instance.new("Frame", G2L["2"]);
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(13, 13, 13);
G2L["3"]["Size"] = UDim2.new(0, 595, 0, 391);
G2L["3"]["Position"] = UDim2.new(0.00988, 0, 0.01071, 0);
G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["Name"] = [[zadnica]];

-- StarterGui.new.baza.zadnica.UIStroke
G2L["4"] = Instance.new("UIStroke", G2L["3"]);
G2L["4"]["Transparency"] = 0.86;
G2L["4"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
G2L["4"]["Color"] = Color3.fromRGB(255, 255, 255);

-- StarterGui.new.baza.zadnica.ImageLabel
G2L["5"] = Instance.new("ImageLabel", G2L["3"]);
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["Image"] = [[rbxassetid://95272865678017]];
G2L["5"]["Size"] = UDim2.new(0, 595, 0, 2);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["BackgroundTransparency"] = 1;

-- StarterGui.new.baza.zadnica.ImageLabel.animation
G2L["6"] = Instance.new("LocalScript", G2L["5"]);
G2L["6"]["Name"] = [[animation]];

-- StarterGui.new.baza.zadnica.backgroundimage
G2L["7"] = Instance.new("ImageLabel", G2L["3"]);
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["ImageTransparency"] = 0.93;
G2L["7"]["Image"] = [[http://www.roblox.com/asset/?id=14675747337]];
G2L["7"]["Size"] = UDim2.new(0, 574, 0, -365);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["BackgroundTransparency"] = 1;
G2L["7"]["Name"] = [[backgroundimage]];
G2L["7"]["Position"] = UDim2.new(0.01681, 0, 0.96931, 0);

-- StarterGui.new.baza.zadnica.prikol
G2L["8"] = Instance.new("Frame", G2L["3"]);
G2L["8"]["BorderSizePixel"] = 0;
G2L["8"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["8"]["Size"] = UDim2.new(0, 1, 0, 365);
G2L["8"]["Position"] = UDim2.new(0.17647, 0, 0.03581, 0);
G2L["8"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["8"]["Name"] = [[prikol]];
G2L["8"]["BackgroundTransparency"] = 0.85;

-- StarterGui.new.baza.zadnica.buttons
G2L["9"] = Instance.new("Frame", G2L["3"]);
G2L["9"]["BorderSizePixel"] = 0;
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["9"]["Size"] = UDim2.new(0, 101, 0, 391);
G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9"]["Name"] = [[buttons]];
G2L["9"]["BackgroundTransparency"] = 1;

-- StarterGui.new.baza.zadnica.buttons.UIListLayout
G2L["a"] = Instance.new("UIListLayout", G2L["9"]);
G2L["a"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

local buttonConfigs = {
    {name = "rage", image = "rbxassetid://8547236654", size = UDim2.new(0, 78, 0, 71), pos = UDim2.new(0.16, 0, 0.17647, 0)},
    {name = "visuals", image = "rbxassetid://8547254518", size = UDim2.new(0, 67, 0, 71), pos = UDim2.new(0.16, 0, 0.17647, 0)},
    {name = "movement", image = "rbxassetid://110954096488294", size = UDim2.new(0, 54, 0, 51), pos = UDim2.new(0.22, 0, 0.29412, 0)},
    {name = "info", image = "http://www.roblox.com/asset/?id=18754976792", size = UDim2.new(0, 43, 0, 41), pos = UDim2.new(0.28, 0, 0.35294, 0)}
}

for _, config in ipairs(buttonConfigs) do
    local button = Instance.new("TextButton", G2L["9"])
    button.BorderSizePixel = 0
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    button.Size = UDim2.new(0, 100, 0, 85)
    button.BackgroundTransparency = 1
    button.Name = config.name
    button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    button.Text = ""

    local imageLabel = Instance.new("ImageLabel", button)
    imageLabel.BorderSizePixel = 0
    imageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    imageLabel.ImageTransparency = 0.47
    imageLabel.Image = config.image
    imageLabel.Size = config.size
    imageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Position = config.pos
end

-- StarterGui.new.baza.zadnica.buttons.rage.LocalScript
G2L["d"] = Instance.new("LocalScript", G2L["9"]["rage"])

-- StarterGui.new.baza.zadnica.buttons.visuals.LocalScript
G2L["10"] = Instance.new("LocalScript", G2L["9"]["visuals"])

-- StarterGui.new.baza.zadnica.buttons.movement.LocalScript
G2L["13"] = Instance.new("LocalScript", G2L["9"]["movement"])

-- StarterGui.new.baza.zadnica.buttons.info.LocalScript
G2L["15"] = Instance.new("LocalScript", G2L["9"]["info"])

local frameConfigs = {
    {name = "combat_f", visible = true},
    {name = "visuals_f", visible = false},
    {name = "movement_f", visible = false},
    {name = "info_f", visible = false}
}

for _, config in ipairs(frameConfigs) do
    G2L[config.name] = Instance.new("Frame", G2L["3"])
    G2L[config.name].Visible = config.visible
    G2L[config.name].BorderSizePixel = 0
    G2L[config.name].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    G2L[config.name].Size = UDim2.new(0, 54, 0, 41)
    G2L[config.name].Position = UDim2.new(-0.01008, 0, -0.01279, 0)
    G2L[config.name].BorderColor3 = Color3.fromRGB(0, 0, 0)
    G2L[config.name].Name = config.name
    G2L[config.name].BackgroundTransparency = 1
end

local buttonData = {
    combat_f = {
        {pos = UDim2.new(2.31481, 0, 0.4878, 0), text = "KillAura", script = "1f"},
        {pos = UDim2.new(2.31481, 0, 1.92683, 0), text = "Kill All", script = "27"},
        {pos = UDim2.new(2.31481, 0, 3.4878, 0), text = "AimBot ( keycode e )", script = "2f"}
    },
    visuals_f = {
        {pos = UDim2.new(2.31481, 0, 0.4878, 0), text = "ESP", script = "38"},
        {pos = UDim2.new(2.31481, 0, 1.92683, 0), text = "FOV changer", script = "40"}
    },
    movement_f = {
        {pos = UDim2.new(2.31481, 0, 0.4878, 0), text = "Speed", script = "49"},
        {pos = UDim2.new(2.31481, 0, 1.92683, 0), text = "Inf Jump", script = "51"},
        {pos = UDim2.new(2.31481, 0, 3.39024, 0), text = "Fly", script = "59"},
        {pos = UDim2.new(2.31481, 0, 4.87805, 0), text = "No clip", script = "61"},
        {pos = UDim2.new(2.31481, 0, 6.31707, 0), text = "Ctrl + left click tp", script = "69"}
    },
    info_f = {
        {pos = UDim2.new(2.31481, 0, 0.4878, 0), text = "My discord: pianino2", script = "72"},
        {pos = UDim2.new(2.31481, 0, 1.92683, 0), text = "Discord server: https://discord.gg/gfevbcDyzm", script = "7a"}
    }
}

for frameName, buttons in pairs(buttonData) do
    for i, btnConfig in ipairs(buttons) do
        local knopka = Instance.new("Frame", G2L[frameName])
        knopka.BorderSizePixel = 0
        knopka.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
        knopka.Size = UDim2.new(0, 465, 0, 47)
        knopka.Position = btnConfig.pos
        knopka.BorderColor3 = Color3.fromRGB(0, 0, 0)
        knopka.Name = "knopka"

        local uiStroke = Instance.new("UIStroke", knopka)
        uiStroke.Transparency = 0.86
        uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        uiStroke.Color = Color3.fromRGB(255, 255, 255)

        local imageLabel = Instance.new("ImageLabel", knopka)
        imageLabel.BorderSizePixel = 0
        imageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        imageLabel.Image = "rbxassetid://95272865678017"
        imageLabel.Size = UDim2.new(0, 465, 0, 2)
        imageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        imageLabel.BackgroundTransparency = 1

        local animationScript = Instance.new("LocalScript", imageLabel)
        animationScript.Name = "animation"

        local textLabel = Instance.new("TextLabel", knopka)
        textLabel.BorderSizePixel = 0
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 14
        textLabel.FontFace = Font.new("rbxassetid://12187360881", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.BackgroundTransparency = 1
        textLabel.Size = UDim2.new(0, 287, 0, 45)
        textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.Text = btnConfig.text
        textLabel.Position = UDim2.new(0.03226, 0, 0.04255, 0)

        local textButton = Instance.new("TextButton", knopka)
        textButton.BorderSizePixel = 0
        textButton.TextSize = 14
        textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        textButton.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
        textButton.FontFace = Font.new("rbxassetid://12187360881", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        textButton.Size = UDim2.new(0, 109, 0, 28)
        textButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
        textButton.Text = "Click!"
        textButton.Position = UDim2.new(0.74839, 0, 0.21277, 0)

        local btnStroke = Instance.new("UIStroke", textButton)
        btnStroke.Transparency = 0.86
        btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        btnStroke.Color = Color3.fromRGB(255, 255, 255)

        local localScript = Instance.new("LocalScript", textButton)
        G2L[btnConfig.script] = localScript
    end
end

-- StarterGui.new.baza.UIStroke
G2L["7b"] = Instance.new("UIStroke", G2L["2"])
G2L["7b"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border

-- StarterGui.new.baza.LocalScript
G2L["7c"] = Instance.new("LocalScript", G2L["2"])

-- SCRIPTS
-- StarterGui.new.baza.zadnica.ImageLabel.animation
local function C_6()
local script = G2L["6"]
    local notifications = script.Parent
    local TweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)
    local transparencyTween = TweenService:Create(notifications, tweenInfo, { ImageTransparency = 1 })
    transparencyTween:Play()
end
task.spawn(C_6)

local function C_d()
local script = G2L["d"]
    script.Parent.MouseButton1Click:Connect(function()
        script.Parent.Parent.rage.ImageLabel.ImageTransparency = 0
        script.Parent.Parent.visuals.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.movement.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.info.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.Parent.combat_f.Visible = true
        script.Parent.Parent.Parent.info_f.Visible = false
        script.Parent.Parent.Parent.movement_f.Visible = false
        script.Parent.Parent.Parent.visuals_f.Visible = false
    end)
end
task.spawn(C_d)

local function C_10()
local script = G2L["10"]
    script.Parent.MouseButton1Click:Connect(function()
        script.Parent.Parent.rage.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.visuals.ImageLabel.ImageTransparency = 0
        script.Parent.Parent.movement.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.info.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.Parent.combat_f.Visible = false
        script.Parent.Parent.Parent.info_f.Visible = false
        script.Parent.Parent.Parent.movement_f.Visible = false
        script.Parent.Parent.Parent.visuals_f.Visible = true
    end)
end
task.spawn(C_10)

local function C_13()
local script = G2L["13"]
    script.Parent.MouseButton1Click:Connect(function()
        script.Parent.Parent.rage.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.visuals.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.movement.ImageLabel.ImageTransparency = 0
        script.Parent.Parent.info.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.Parent.combat_f.Visible = false
        script.Parent.Parent.Parent.info_f.Visible = false
        script.Parent.Parent.Parent.movement_f.Visible = true
        script.Parent.Parent.Parent.visuals_f.Visible = false
    end)
end
task.spawn(C_13)

local function C_15()
local script = G2L["15"]
    script.Parent.MouseButton1Click:Connect(function()
        script.Parent.Parent.rage.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.visuals.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.movement.ImageLabel.ImageTransparency = 0.5
        script.Parent.Parent.info.ImageLabel.ImageTransparency = 0
        script.Parent.Parent.Parent.combat_f.Visible = false
        script.Parent.Parent.Parent.info_f.Visible = true
        script.Parent.Parent.Parent.movement_f.Visible = false
        script.Parent.Parent.Parent.visuals_f.Visible = false
    end)
end
task.spawn(C_15)

local function createAnimationScript(parent)
    local script = Instance.new("LocalScript", parent)
    script.Name = "animation"
    script.Source = [[
        local notifications = script.Parent
        local TweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true)
        local transparencyTween = TweenService:Create(notifications, tweenInfo, { ImageTransparency = 1 })
        transparencyTween:Play()
    ]]
end

local function C_1f()
local script = G2L["1f"]
    script.Parent.MouseButton1Click:Connect(function()
        while wait () do
            for i, e in pairs(game.Players:GetChildren()) do
                if e ~= game.Players.LocalPlayer then
                    local meleeEvent = game:GetService("ReplicatedStorage").meleeEvent
                    meleeEvent:FireServer(e)
                end end end
    end)
end
task.spawn(C_1f)

local function C_27()
local script = G2L["27"]
    script.Parent.MouseButton1Click:Connect(function()
        spawn(function()
            while wait(0.1) do
                for i, v in next, game:GetService("Players"):GetChildren() do
                    pcall(function()
                        if v~= game:GetService("Players").LocalPlayer and not v.Character:FindFirstChildOfClass("ForceField") and v.Character.Humanoid.Health > 0 then
                            while v.Character:WaitForChild("Humanoid").Health > 0 do
                                wait();
                                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame;
                                for x, c in next, game:GetService("Players"):GetChildren() do
                                    if c ~= game:GetService("Players").LocalPlayer then game.ReplicatedStorage.meleeEvent:FireServer(c) end
                                end
                            end
                        end
                    end)
                    wait()
                end
            end
        end)
    end)
end
task.spawn(C_27)

local function C_2f()
local script = G2L["2f"]
    script.Parent.MouseButton1Click:Connect(function()
        local config = {
            TeamCheck = false,
            FOV = 150,
            Smoothing = 1,
            KeyToToggle = Enum.KeyCode.E,
        }
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local FOVring = Drawing.new("Circle")
        FOVring.Visible = true
        FOVring.Thickness = 1.5
        FOVring.Radius = config.FOV
        FOVring.Transparency = 1
        FOVring.Color = Color3.fromRGB(255, 128, 128)
        FOVring.Position = workspace.CurrentCamera.ViewportSize / 2
        local function getClosestVisiblePlayer(camera)
            local ray = Ray.new(camera.CFrame.Position, camera.CFrame.LookVector)
            local closestPlayer = nil
            local closestDistance = math.huge
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    local character = player.Character
                    if character and character:FindFirstChild("Head") then
                        local headPosition = character.Head.Position
                        local targetPosition = ray:ClosestPoint(headPosition)
                        local distance = (targetPosition - headPosition).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
            return closestPlayer
        end
        local aimbotEnabled = false
        local function toggleAimbot()
            aimbotEnabled = not aimbotEnabled
            FOVring.Visible = aimbotEnabled
        end
        local function updateAimbot()
            if aimbotEnabled then
                local currentCamera = workspace.CurrentCamera
                local crosshairPosition = currentCamera.ViewportSize / 2
                local closestPlayer = getClosestVisiblePlayer(currentCamera)
                if closestPlayer then
                    local headPosition = closestPlayer.Character.Head.Position
                    local headScreenPosition = currentCamera:WorldToScreenPoint(headPosition)
                    local distanceToCrosshair = (Vector2.new(headScreenPosition.X, headScreenPosition.Y) - crosshairPosition).Magnitude
                    if distanceToCrosshair < config.FOV then
                        currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.new(currentCamera.CFrame.Position, headPosition), config.Smoothing)
                    end
                end
            end
        end
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == config.KeyToToggle then
                toggleAimbot()
            end
        end)
        local aimbotConnection
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == config.KeyToToggle then
                if aimbotEnabled then
                    FOVring:Remove()
                    aimbotConnection:Disconnect()
                else
                    FOVring.Position = workspace.CurrentCamera.ViewportSize / 2
                    FOVring.Radius = config.FOV
                    aimbotConnection = RunService.RenderStepped:Connect(updateAimbot)
                end
            end
        end)
    end)
end
task.spawn(C_2f)

local function C_38()
local script = G2L["38"]
    script.Parent.MouseButton1Click:Connect(function()
        while wait(0.1) do
            for i, childrik in ipairs(workspace:GetDescendants()) do
                if childrik:FindFirstChild("Humanoid") then
                    if not childrik:FindFirstChild("EspBox") then
                        if childrik ~= game.Players.LocalPlayer.Character then
                            local esp = Instance.new("BoxHandleAdornment",childrik)
                            esp.Adornee = childrik
                            esp.ZIndex = 0
                            esp.Size = Vector3.new(4, 5, 1)
                            esp.Transparency = 0.65
                            esp.Color3 = Color3.fromRGB(255,48,48)
                            esp.AlwaysOnTop = true
                            esp.Name = "EspBox"
                        end
                    end
                end
            end
        end
    end)
end
task.spawn(C_38)

local function C_40()
local script = G2L["40"]
    local state = false
    script.Parent.MouseButton1Click:Connect(function()
        state = not state
        if state then 
            script.Parent.BackgroundTransparency = 0
            script.Parent.Text = "on"
            workspace.Camera.FieldOfView = 120
        else
            script.Parent.BackgroundTransparency = 1
            script.Parent.Text = "off"
            workspace.Camera.FieldOfView = 70
        end
    end)
end
task.spawn(C_40)

local function C_49()
local script = G2L["49"]
    script.Parent.MouseButton1Click:Connect(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end)
end
task.spawn(C_49)

local function C_51()
local script = G2L["51"]
    script.Parent.MouseButton1Click:Connect(function()
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            end
        end)
    end)
end
task.spawn(C_51)

local function C_59()
local script = G2L["59"]
    script.Parent.MouseButton1Click:Connect(function()
        local FLYING = false
        function sFLY(flyspeed, QEfly, vfly)
            repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            repeat wait() until game.Players.LocalPlayer:GetMouse()
            if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
            local Character = game.Players.LocalPlayer.Character
            local hrp = Character:FindFirstChild("HumanoidRootPart")
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            local mouse = game.Players.LocalPlayer:GetMouse()
            local moverParent = game.Workspace:FindFirstChildOfClass("Terrain")
            local moverAttachment = hrp.RootAttachment
            local T = hrp
            local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            local SPEED = 0
            local function FLY()
                FLYING = true
                local BG = Instance.new('AlignOrientation')
                BG.Mode = Enum.OrientationAlignmentMode.OneAttachment
                BG.RigidityEnabled = true
                BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                BG.CFrame = T.CFrame
                BG.Attachment0 = moverAttachment
                local BV = Instance.new('LinearVelocity')
                BV.VectorVelocity = Vector3.new(0, 0, 0)
                BV.MaxForce = 9e9
                BV.Attachment0 = moverAttachment
                BG.Parent = moverParent
                BV.Parent = moverParent
                task.spawn(function()
                    repeat wait()
                        if not vfly and hum then
                            hum.PlatformStand = true
                        end
                        if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                            SPEED = 50
                        elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                            SPEED = 0
                        end
                        if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                            BV.VectorVelocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                            lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                        elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                            BV.VectorVelocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                        else
                            BV.VectorVelocity = Vector3.new(0, 0, 0)
                        end
                        BG.CFrame = game.Workspace.CurrentCamera.CoordinateFrame
                    until not FLYING or Character.Parent == nil
                    CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                    lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                    SPEED = 0
                    BG:Destroy()
                    BV:Destroy()
                    if hum then
                        hum.PlatformStand = false
                    end
                end)
            end
            flyKeyDown = mouse.KeyDown:Connect(function(KEY)
                if KEY:lower() == 'w' then
                    CONTROL.F = flyspeed
                elseif KEY:lower() == 's' then
                    CONTROL.B = - flyspeed
                elseif KEY:lower() == 'a' then
                    CONTROL.L = - flyspeed
                elseif KEY:lower() == 'd' then 
                    CONTROL.R = flyspeed
                elseif QEfly and KEY:lower() == 'e' then
                    CONTROL.Q = flyspeed * 2
                elseif QEfly and KEY:lower() == 'q' then
                    CONTROL.E = - flyspeed * 2
                end
                pcall(function() game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
            end)
            flyKeyUp = mouse.KeyUp:Connect(function(KEY)
                if KEY:lower() == 'w' then
                    CONTROL.F = 0
                elseif KEY:lower() == 's' then
                    CONTROL.B = 0
                elseif KEY:lower() == 'a' then
                    CONTROL.L = 0
                elseif KEY:lower() == 'd' then
                    CONTROL.R = 0
                elseif KEY:lower() == 'e' then
                    CONTROL.Q = 0
                elseif KEY:lower() == 'q' then
                    CONTROL.E = 0
                end
            end)
            FLY()
        end
        sFLY(1, true, false)
    end)
end
task.spawn(C_59)

local function C_61()
local script = G2L["61"]
    script.Parent.MouseButton1Click:Connect(function()
        local Noclip = nil
        local Clip = nil
        function noclip()
            Clip = false
            local function Nocl()
                if Clip == false and game.Players.LocalPlayer.Character ~= nil then
                    for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                            v.CanCollide = false
                        end
                    end
                end
                wait(0.21)
            end
            Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
        end
        function clip()
            if Noclip then Noclip:Disconnect() end
            Clip = true
        end
        noclip()
    end)
end
task.spawn(C_61)

local function C_69()
local script = G2L["69"]
    script.Parent.MouseButton1Click:Connect(function()
        local UIS = game:GetService("UserInputService")
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()
        
        local connection
        connection = UIS.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPos = mouse.Hit.Position
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
                end
            end
        end)
    end)
end
task.spawn(C_69)

local function C_72()
local script = G2L["72"]
    script.Parent.MouseButton1Click:Connect(function()
        script.Parent.Text = "Copied to clipboard!"
        task.wait(2)
        script.Parent.Text = "Click!"
        setclipboard("pianino2")
    end)
end
task.spawn(C_72)

local function C_7a()
local script = G2L["7a"]
    script.Parent.MouseButton1Click:Connect(function()
        script.Parent.Text = "Copied to clipboard!"
        task.wait(2)
        script.Parent.Text = "Click!"
        setclipboard("https://discord.gg/gfevbcDyzm") 
    end)
end
task.spawn(C_7a)

local function C_7c()
local script = G2L["7c"]
    local UIS = game:GetService('UserInputService')
    local frame = script.Parent
    local dragToggle = nil
    local dragSpeed = 0.05
    local dragStart = nil
    local startPos = nil
    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
    end
    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragToggle then
                updateInput(input)
            end
        end
    end)
    local state = false
    UIS.InputBegan:connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then
            state = not state
            script.Parent.Visible = not state
        end
    end)
end
task.spawn(C_7c)

return G2L["1"], require
