local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local TouchFootball = Library:NewWindow("Touch Football V2")
local sec = TouchFootball:NewSection("Ball Options")
local sect = TouchFootball:NewSection("Others")

local ball = game:GetService("Workspace").FootballField.SoccerBall
local root = game.Players.LocalPlayer.Character.HumanoidRootPart
local kickArgs = {Vector3.new(0), Vector3.new(0), Vector3.new(0), 0, "djhtelkds"}

sec:CreateButton("Bring Ball", function()
    ball.CFrame = root.CFrame
end)

sec:CreateButton("Loop Bring Ball", function()
    while wait() do ball.CFrame = root.CFrame end
end)

sec:CreateButton("Freeze Ball", function()
    while wait() do
        ball.Anchored = true
        game:GetService("ReplicatedStorage").KickBall:FireServer(unpack(kickArgs))
    end
end)

sec:CreateButton("Freeze Ball 2 (Can't be stopped)", function()
    while wait() do
        game:GetService("ReplicatedStorage").KickBall:FireServer(unpack(kickArgs))
    end
end)

sec:CreateButton("Delete Ball (Ban Risk!)", function()
    while wait() do
        game:GetService("ReplicatedStorage").KickBall:FireServer(unpack(kickArgs))
        ball.Anchored = true
    end
end)

local function scoreGoal(team)
    game:GetService("ReplicatedStorage").KickBall:FireServer(unpack(kickArgs))
    wait(0.5)
    game:GetService("ReplicatedStorage").GoalEvent:FireServer(team)
end

sect:CreateButton("Goal A Team", function() scoreGoal("A") end)
sect:CreateButton("Goal B Team", function() scoreGoal("B") end)
