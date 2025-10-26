local Depth = 6
local TargetSpeed = 40

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local ClonePart = RootPart:Clone()

ClonePart.Parent = Character
RootPart.RootJoint.Enabled = false
RootPart.Name = "RHumanoidRootPart"
RootPart.Transparency = 0
local Highlight = Instance.new("Highlight", RootPart)

-- Keep player near ground.
workspace.Gravity = 1000
Humanoid.JumpPower = 0
Character.Animate.Disabled = true

local currentPitch = 0
while task.wait() do
    Humanoid.WalkSpeed = TargetSpeed
    local velocity = ClonePart.AssemblyLinearVelocity
    local horizontalSpeed = Vector2.new(velocity.X, velocity.Z).Magnitude
    local targetPitch = 0
    if horizontalSpeed > 0.1 then
        targetPitch = math.atan2(velocity.Y, horizontalSpeed)
    end

    currentPitch = currentPitch + (targetPitch - currentPitch) * 0.1
    local rotation = CFrame.Angles(math.rad(90) + currentPitch, 0, 0)
    
    RootPart.CFrame = ClonePart.CFrame * CFrame.new(0, -Depth, 0) * rotation
    RootPart.Velocity = Vector3.zero
end
