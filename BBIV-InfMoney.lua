for i = 1, 10 do
    coroutine.wrap(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("elasticitylevel", 100)
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("frictionlevel", 100)
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("cooldownlevel", 100)
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("fuellevel", 100)
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("jumplevel", 100)
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("speedlevel", 100)
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("breakslevel", 100)
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("sprainslevel", 100)
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("flightlevel", 100)
        game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer("dislocationslevel", 100)
    end)()
end

local args = {
    [1] = "money",
    [2] = 1500000000000000
}

game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer(unpack(args))

local args2 = {
    [1] = "Gravity Bubble",
    [2] = 5,
    [3] = true
}

game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer(unpack(args2))

local args3 = {
    [1] = "utility",
    [2] = "Gravity Bubble",
    [3] = true
}

game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("UpdateStat"):InvokeServer(unpack(args3))

task.wait(0.5)
game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
