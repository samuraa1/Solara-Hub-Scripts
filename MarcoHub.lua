local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
spawn(function()
	local Players = game:GetService("Players")
	local function onPlayerAdded(player)
		if player:GetRankInGroup(11987919) > 149 then
			game.Players.LocalPlayer:Kick("Auto Kicked Due to Staff Member " .. player.Name .. " joined your game")
		else
			warn(player.Name, "just joined the game")
		end
	end
end)
spawn(function()
	warn("Anti Staff is now running")
	while wait() do
		for i, v in pairs(game.Players:GetPlayers()) do
			if v:GetRankInGroup(11987919) > 149 then
				game.Players.LocalPlayer:Kick("Auto Kicked Due to Staff Member " .. v.Name .. " is in your game")
			end
		end
		wait(5)
	end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Marco Hub",
    Center = true,
    AutoShow = true,
	Footer = 'Taxi Boss Script'
})

local MainTab = Window:AddTab("Main", "house", "Main features")
local TeleportsTab = Window:AddTab("Teleports", "map-pin", "Teleport locations")
local MiscTab = Window:AddTab("Miscellaneous", "settings", "Additional features")

local states = {
    candy = false,
    partcollector = false,
    test2 = false,
    customersfarm = false,
    Trophies = false,
    medals = false,
    ofs = false,
    donut = false
}

local function safeSpawn(func)
    task.spawn(function()
        local success, err = pcall(func)
        if not success then
            warn("Error in spawned function:", err)
        end
    end)
end

local FarmingGroup = MainTab:AddLeftGroupbox("Auto Farming", "tractor")
local OtherFeaturesGroup = MainTab:AddRightGroupbox("Other Features", "star")

local AutoDestroyToggle = FarmingGroup:AddToggle("AutoDestroyPumpkins", {
    Text = "Auto Destroy Pumpkins",
    Default = false,
    Tooltip = "Automatically destroys pumpkins with your car",
    Callback = function(State)
        states.candy = State
        if State then
            safeSpawn(function()
                local function findCar()
                    local car = nil
                    for i, v in pairs(workspace.Vehicles:GetChildren()) do
                        if v:GetAttribute("owner") == game.Players.LocalPlayer.UserId then
                            car = v
                            break
                        end
                    end
                    return car
                end
                
                while states.candy do
                    task.wait(0.5)
                    local car = findCar()
                    if car and car.PrimaryPart then
                        for i, v in pairs(workspace.Pumpkins:GetDescendants()) do
                            if not states.candy then break end
                            if v.Name == "TouchInterest" and v.Parent then
                                firetouchinterest(car.PrimaryPart, v.Parent, 0)
                                firetouchinterest(car.PrimaryPart, v.Parent, 1)
                                task.wait(0.1)
                            end
                        end
                    end
                end
            end)
        end
    end
})

local AutoCollectToggle = FarmingGroup:AddToggle("AutoCollectParts", {
    Text = "Auto Collect Parts",
    Default = false,
    Tooltip = "Automatically collects parts around the map",
    Callback = function(State)
        states.partcollector = State
        if State then
            safeSpawn(function()
                while states.partcollector do
                    task.wait(0.5)
                    if not game.Players.LocalPlayer.Character then
                        continue
                    end
                    
                    local char = game.Players.LocalPlayer.Character
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if not root then continue end
                    
                    for _, location in pairs(workspace.ItemSpawnLocations:GetChildren()) do
                        if not states.partcollector then break end
                        
                        char:PivotTo(location.CFrame + Vector3.new(0, 251, 0))
                        task.wait(0.5)
                        
                        for _, item in pairs(workspace.ItemSpawnLocations:GetDescendants()) do
                            if not states.partcollector then break end
                            if item.Name == "TouchInterest" and item.Parent then
                                firetouchinterest(root, item.Parent, 0)
                                firetouchinterest(root, item.Parent, 1)
                                task.wait(0.05)
                            end
                        end
                    end
                end
            end)
        end
    end
})

local AutoMoneyToggle = FarmingGroup:AddToggle("AutoMoney", {
    Text = "Auto Money",
    Default = false,
    Tooltip = "Automatically completes contracts for money",
    Callback = function(State)
        states.test2 = State
        if State then
            safeSpawn(function()
                while states.test2 do
                    task.wait(1)
                    
                    pcall(function()
                        local activeQuest = game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChildOfClass("StringValue")
                        if activeQuest then
                            game:GetService("ReplicatedStorage").Quests.Contracts.CancelContract:InvokeServer(activeQuest.Name)
                        end
                    end)
                    
                    if not game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChild("contractBuildMaterial") then
                        game:GetService("ReplicatedStorage").Quests.Contracts.StartContract:InvokeServer("contractBuildMaterial")
                        task.wait(1)
                    end
                    
                    local quest = game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChild("contractBuildMaterial")
                    if quest and quest.Value == "!pw5pi3ps2" then
                        game:GetService("ReplicatedStorage").Quests.Contracts.CompleteContract:InvokeServer()
                        task.wait(1)
                    else
                        for i = 1, 3 do
                            if not states.test2 then break end
                            pcall(function()
                                game:GetService("ReplicatedStorage").Quests.DeliveryComplete:InvokeServer("contractMaterial")
                            end)
                            task.wait(0.1)
                        end
                    end
                end
            end)
        end
    end
})

local AutoCustomersToggle = FarmingGroup:AddToggle("AutoCustomers", {
    Text = "Auto Customers [Beta]",
    Default = false,
    Tooltip = "Automatically picks up and delivers customers",
    Callback = function(State)
        states.customersfarm = State
        if State then
            safeSpawn(function()
                pcall(function() game:GetService("Workspace").GaragePlate:Destroy() end)
                for _, v in pairs(game:GetService("Workspace").World.Industrial.Port:GetChildren()) do
                    if string.find(v.Name, "Container") then
                        pcall(function() v:Destroy() end)
                    end
                end
                
                local numbers = 0
                local stuck = 0
                
                while states.customersfarm do
                    task.wait(0.5)
                    
                    local character = game.Players.LocalPlayer.Character
                    if not character then continue end
                    
                    local humanoid = character:FindFirstChild("Humanoid")
                    if not humanoid then continue end
                    
                    if humanoid.SeatPart == nil then
                        pcall(function()
                            game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(
                                game:GetService("Players").LocalPlayer.variables.carId.Value
                            )
                            task.wait(0.5)
                            game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
                        end)
                        continue
                    end
                    
                    local car = humanoid.SeatPart.Parent.Parent
                    local inMission = game:GetService("Players").LocalPlayer.variables.inMission.Value
                    local destination = game:GetService("Workspace").ParkingMarkers:FindFirstChild("destinationPart")
                    
                    if inMission and destination then
                        local distance = game.Players.LocalPlayer:DistanceFromCharacter(destination.Position)
                        
                        if distance < 50 then
                            car:SetPrimaryPartCFrame(destination.CFrame + Vector3.new(0, 3, 0))
                            car.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
                            task.wait(1)
                            
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                            task.wait(0.5)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
                            
                            numbers = numbers + 1
                            print("Completed delivery #" .. numbers)
                        else
                            local direction = (destination.Position - car.PrimaryPart.Position).Unit
                            car.PrimaryPart.Velocity = direction * 50
                        end
                    elseif not inMission then
                        local bestCustomer = nil
                        local bestDistance = math.huge
                        
                        for _, customer in pairs(game:GetService("Workspace").NewCustomers:GetDescendants()) do
                            if customer.Name == "Part" and customer:GetAttribute("GroupSize") then
                                local groupSize = customer:GetAttribute("GroupSize")
                                local rating = customer:GetAttribute("Rating")
                                local seatAmount = game:GetService("Players").LocalPlayer.variables.seatAmount.Value
                                local vehicleRating = game:GetService("Players").LocalPlayer.variables.vehicleRating.Value
                                
                                if seatAmount > groupSize and rating < vehicleRating then
                                    local dist = (customer.Position - car.PrimaryPart.Position).Magnitude
                                    if dist < bestDistance then
                                        bestDistance = dist
                                        bestCustomer = customer
                                    end
                                end
                            end
                        end
                        
                        if bestCustomer then
                            car:SetPrimaryPartCFrame(bestCustomer.CFrame * CFrame.new(0, 3, 0))
                            task.wait(1)
                            
                            local prompt = bestCustomer:FindFirstChild("Client")
                            if prompt and prompt:FindFirstChild("PromptPart") then
                                fireproximityprompt(prompt.PromptPart.CustomerPrompt)
                                task.wait(2)
                            end
                        end
                    end
                end
            end)
        end
    end
})

local AutoTrophiesToggle = OtherFeaturesGroup:AddToggle("AutoTrophies", {
    Text = "Auto Trophies",
    Default = false,
    Tooltip = "Automatically farms trophies",
    Callback = function(State)
        states.Trophies = State
        if State then
            safeSpawn(function()
                game:GetService("ReplicatedStorage").Race.LeaveRace:InvokeServer()
                
                local function updateRepUI()
                    while states.Trophies do
                        task.wait(1)
                        local moneyGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
                        if moneyGui and moneyGui:FindFirstChild("Money") then
                            local moneyFrame = moneyGui.Money
                            
                            if not moneyFrame:FindFirstChild("Rep") then
                                local repLabel = moneyFrame.CashLabel:Clone()
                                repLabel.Name = "Rep"
                                repLabel.Text = "Rep: " .. game:GetService("Players").LocalPlayer.variables.rep.Value
                                repLabel.Position = UDim2.new(0, 0, 0, 30)
                                repLabel.Parent = moneyFrame
                            else
                                moneyFrame.Rep.Text = "Rep: " .. game:GetService("Players").LocalPlayer.variables.rep.Value
                            end
                        end
                    end
                    
                    local moneyGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
                    if moneyGui and moneyGui:FindFirstChild("Money") then
                        local repLabel = moneyGui.Money:FindFirstChild("Rep")
                        if repLabel then
                            repLabel:Destroy()
                        end
                    end
                end
                
                safeSpawn(updateRepUI)
                
                while states.Trophies do
                    task.wait(0.5)
                    
                    local character = game.Players.LocalPlayer.Character
                    if not character then continue end
                    
                    local humanoid = character:FindFirstChild("Humanoid")
                    if not humanoid then continue end
                    
                    if humanoid.Sit then
                        if game:GetService("Players").LocalPlayer.variables.race.Value == "none" then
                            game:GetService("ReplicatedStorage").Race.TimeTrial:InvokeServer("circuit", 5)
                            task.wait(1)
                        else
                            for _, vehicle in pairs(game:GetService("Workspace").Vehicles:GetDescendants()) do
                                if vehicle.Name == "Player" and vehicle.Value == game.Players.LocalPlayer then
                                    local car = vehicle.Parent.Parent
                                    
                                    local circuit = game:GetService("Workspace").Races["circuit"]
                                    if circuit then
                                        for _, checkpoint in pairs(circuit.detects:GetChildren()) do
                                            if not states.Trophies then break end
                                            if checkpoint:IsA("Part") and checkpoint:FindFirstChild("TouchInterest") then
                                                checkpoint.CFrame = car.PrimaryPart.CFrame
                                                firetouchinterest(car.PrimaryPart, checkpoint, 0)
                                                firetouchinterest(car.PrimaryPart, checkpoint, 1)
                                                task.wait(0.1)
                                            end
                                        end
                                        
                                        local finish = circuit.timeTrial:FindFirstChildOfClass("IntValue")
                                        if finish and finish:FindFirstChild("finish") then
                                            finish.finish.CFrame = car.PrimaryPart.CFrame
                                            firetouchinterest(car.PrimaryPart, finish.finish, 0)
                                            firetouchinterest(car.PrimaryPart, finish.finish, 1)
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    else
                        pcall(function()
                            game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(
                                game:GetService("Players").LocalPlayer.variables.carId.Value
                            )
                            task.wait(0.5)
                            game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
                        end)
                    end
                end
            end)
        end
    end
})

local AutoMedalsToggle = OtherFeaturesGroup:AddToggle("AutoMedals", {
    Text = "Auto TimeTrial Medals",
    Default = false,
    Tooltip = "Automatically farms time trial medals",
    Callback = function(State)
        states.medals = State
        if State then
            safeSpawn(function()
                game:GetService("ReplicatedStorage").Race.LeaveRace:InvokeServer()
                
                while states.medals do
                    task.wait(0.5)
                    
                    local character = game.Players.LocalPlayer.Character
                    if not character then continue end
                    
                    local humanoid = character:FindFirstChild("Humanoid")
                    if not humanoid then continue end
                    
                    if humanoid.Sit then
                        for round = 1, 3 do
                            for _, raceFolder in pairs(game:GetService("Workspace").Races:GetChildren()) do
                                if not states.medals then break end
                                
                                if raceFolder.ClassName == "Folder" then
                                    game:GetService("ReplicatedStorage").Race.TimeTrial:InvokeServer(raceFolder.Name, round)
                                    task.wait(1)
                                    
                                    if game:GetService("Players").LocalPlayer.variables.race.Value ~= "none" then
                                        for _, vehicle in pairs(game:GetService("Workspace").Vehicles:GetDescendants()) do
                                            if not states.medals then break end
                                            
                                            if vehicle.Name == "Player" and vehicle.Value == game.Players.LocalPlayer then
                                                local car = vehicle.Parent.Parent
                                                
                                                repeat
                                                    task.wait(0.1)
                                                    local race = game:GetService("Workspace").Races[raceFolder.Name]
                                                    if race then
                                                        for _, checkpoint in pairs(race.detects:GetChildren()) do
                                                            if checkpoint:IsA("Part") and checkpoint:FindFirstChild("TouchInterest") then
                                                                checkpoint.CFrame = car.PrimaryPart.CFrame
                                                                firetouchinterest(car.PrimaryPart, checkpoint, 0)
                                                                firetouchinterest(car.PrimaryPart, checkpoint, 1)
                                                            end
                                                        end
                                                    end
                                                until game:GetService("Workspace").Races[raceFolder.Name].timeTrial:FindFirstChildOfClass("IntValue") or not states.medals
                                                
                                                repeat
                                                    task.wait(0.1)
                                                    local timeTrial = game:GetService("Workspace").Races[raceFolder.Name].timeTrial:FindFirstChildOfClass("IntValue")
                                                    if timeTrial and timeTrial:FindFirstChild("finish") then
                                                        timeTrial.finish.CFrame = car.PrimaryPart.CFrame
                                                        firetouchinterest(car.PrimaryPart, timeTrial.finish, 0)
                                                        firetouchinterest(car.PrimaryPart, timeTrial.finish, 1)
                                                    end
                                                until game:GetService("Players").LocalPlayer.variables.race.Value == "none" or not states.medals
                                                
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        pcall(function()
                            game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(
                                game:GetService("Players").LocalPlayer.variables.carId.Value
                            )
                            task.wait(0.5)
                            game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
                        end)
                    end
                end
            end)
        end
    end
})

local AutoUpgradeToggle = OtherFeaturesGroup:AddToggle("AutoUpgrade", {
    Text = "Auto Upgrade Office",
    Default = false,
    Tooltip = "Automatically upgrades your office",
    Callback = function(State)
        states.ofs = State
        if State then
            safeSpawn(function()
                while states.ofs do
                    task.wait(1)
                    
                    if not game:GetService("Players").LocalPlayer:FindFirstChild("Office") then
                        pcall(function()
                            game:GetService("ReplicatedStorage").Company.StartOffice:InvokeServer()
                        end)
                        task.wait(1)
                    end
                    
                    local office = game:GetService("Players").LocalPlayer:FindFirstChild("Office")
                    if office and office:GetAttribute("level") and office:GetAttribute("level") < 16 then
                        pcall(function()
                            game:GetService("ReplicatedStorage").Company.SkipOfficeQuest:InvokeServer()
                            game:GetService("ReplicatedStorage").Company.UpgradeOffice:InvokeServer()
                        end)
                    end
                end
            end)
        end
    end
})

FarmingGroup:AddDivider()
OtherFeaturesGroup:AddDivider()

local TeleportTabbox = TeleportsTab:AddLeftTabbox("Teleport Locations")
local TeleportTab1 = TeleportTabbox:AddTab("Set 1")
local TeleportTab2 = TeleportTabbox:AddTab("Set 2")
local TeleportTab3 = TeleportTabbox:AddTab("Set 3")

local function teleportToLocation(cframe)
    local character = game.Players.LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if humanoid.SeatPart == nil then
        character:PivotTo(cframe + Vector3.new(0, 5, 0))
    else
        local car = humanoid.SeatPart.Parent.Parent
        car:PivotTo(cframe + Vector3.new(0, 10, 0))
    end
    
    Library:Notify("Teleported!", 2)
end

local locationsSet1 = {
    {"Beechwood", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Beechwood")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Beechwood Beach", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Beechwood Beach")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Boss Airport", function() return CFrame.new(-637.13, 39.00, 4325.23) end},
    {"Bridgeview", function() return CFrame.new(1354.46, 10.30, 1278.80) end},
    {"Cedar Side", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Cedar Side")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Central Bank", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Central Bank")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Central City", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Central City")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end}
}

for _, loc in ipairs(locationsSet1) do
    TeleportTab1:AddButton({
        Text = loc[1],
        Func = function()
            local cframe = loc[2]()
            teleportToLocation(cframe)
        end
    })
end

local locationsSet2 = {
    {"City Park", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("City Park")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Coconut Park", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Coconut Park")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Country Club", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Country Club")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Da Hills", function() return CFrame.new(2348.35, 73.11, -1537.32) end},
    {"Doge Harbor", function() return CFrame.new(3335.74, 24.96, 2773.04) end},
    {"Gas Station", function() return CFrame.new(103.70, 0, -640.60) end},
    {"Gas Station 2", function() return CFrame.new(930.70, 0, 643.40) end}
}

for _, loc in ipairs(locationsSet2) do
    TeleportTab2:AddButton({
        Text = loc[1],
        Func = function()
            local cframe = loc[2]()
            teleportToLocation(cframe)
        end
    })
end

local locationsSet3 = {
    {"Harborview", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Harborview")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Hawthorn Park", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Hawthorn Park")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Hospital", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Hospital")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Industrial District", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Industrial District")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Logistic District", function() return CFrame.new(588.29, 53.58, 2529.95) end},
    {"Master Hotel", function() return CFrame.new(2736.16, 15.86, -202.10) end},
    {"Military Base", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Military Base")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end}
}

for _, loc in ipairs(locationsSet3) do
    TeleportTab3:AddButton({
        Text = loc[1],
        Func = function()
            local cframe = loc[2]()
            teleportToLocation(cframe)
        end
    })
end

local MoreTeleportsGroup = TeleportsTab:AddRightGroupbox("More Locations", "map")

local moreLocations = {
    {"Noll Cliffs", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Noll Cliffs")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Nuclear Power Plant", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Nuclear Power Plant")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"OFF ROAD Test Track", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("OFF ROAD Test Track")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Ocean Viewpoint", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Ocean Viewpoint")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Oil Refinery", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Oil Refinery")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Old Town", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Old Town")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end}
}

for _, loc in ipairs(moreLocations) do
    MoreTeleportsGroup:AddButton({
        Text = loc[1],
        Func = function()
            local cframe = loc[2]()
            teleportToLocation(cframe)
        end
    })
end

local EvenMoreTeleportsGroup = TeleportsTab:AddRightGroupbox("Extra Locations", "navigation")

local extraLocations = {
    {"Popular Street", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Popular Street")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Small Town", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Small Town")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"St. Noll Viewpoint", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("St. Noll Viewpoint")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Sunny Elementary", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Sunny Elementary")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Sunset Grove", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Sunset Grove")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end},
    {"Taxi Central", function() 
        local place = game:GetService("ReplicatedStorage").Places:FindFirstChild("Taxi Central")
        if place then return CFrame.new(place.Position) end
        return CFrame.new(0, 0, 0)
    end}
}

for _, loc in ipairs(extraLocations) do
    EvenMoreTeleportsGroup:AddButton({
        Text = loc[1],
        Func = function()
            local cframe = loc[2]()
            teleportToLocation(cframe)
        end
    })
end

local VehicleGroup = MiscTab:AddLeftGroupbox("Vehicle", "car")
local PlayerGroup = MiscTab:AddRightGroupbox("Player", "user")

local vehicleInput = VehicleGroup:AddInput("VehicleInput", {
    Text = "Vehicle Name",
    Default = "",
    Placeholder = "Enter vehicle name...",
    Tooltip = "Enter vehicle name to buy"
})

VehicleGroup:AddButton({
    Text = "Buy Vehicle",
    Func = function()
        local vehicleName = vehicleInput.Value
        if vehicleName and vehicleName ~= "" then
            local carList = require(game:GetService("ReplicatedStorage").ModuleLists.CarList)
            for _, vehicle in pairs(carList) do
                if string.find(vehicle.name:lower(), vehicleName:lower()) then
                    game:GetService("ReplicatedStorage").DataStore.PurchaseVehicle:InvokeServer(vehicle.id)
                    Library:Notify("Purchasing: " .. vehicle.name, 3)
                    return
                end
            end
            Library:Notify("Vehicle not found!", 3)
        end
    end,
    Tooltip = "Buy vehicle by name"
})

VehicleGroup:AddButton({
    Text = "Unlock Taxi Radar",
    Func = function()
        game:GetService("Players").LocalPlayer.variables.vip.Value = true
        Library:Notify("Taxi Radar Unlocked!", 3)
    end,
    Tooltip = "Unlocks the taxi radar feature"
})

PlayerGroup:AddButton({
    Text = "Show Players Stats",
    Func = function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "F9", false, game)
        task.wait(0.1)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "F9", false, game)
        print("\n=== PLAYERS STATS ===")
        for _, player in pairs(game.Players:GetPlayers()) do
            print("\n--- " .. player.Name .. " ---")
            
            if player:FindFirstChild("variables") then
                local vars = player.variables
                print("Candy: " .. (vars.candy and vars.candy.Value or "N/A"))
                print("Rep: " .. (vars.rep and vars.rep.Value or "N/A"))
            end
            if player:FindFirstChild("Data") then
                local data = player.Data
                print("Coconuts: " .. (data.coconuts and data.coconuts.Value or "N/A"))
                local ownedCars = {}
                if data:FindFirstChild("OwnedCars") then
                    for _, car in pairs(data.OwnedCars:GetChildren()) do
                        if car:IsA("BoolValue") and car.Value then
                            table.insert(ownedCars, car.Name)
                        end
                    end
                    print("Owned Cars: " .. table.concat(ownedCars, ", "))
                end
            end
        end
        print("\n=== END STATS ===\n")  
        Library:Notify("Players stats printed to console!", 3)
    end,
    Tooltip = "Shows all players stats in console"
})

PlayerGroup:AddButton({
    Text = "Reset Character",
    Func = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            character:BreakJoints()
            Library:Notify("Character reset!", 2)
        end
    end,
    Tooltip = "Resets your character"
})

VehicleGroup:AddButton({
    Text = "Remove Ai Vehicles",
    Func = function()
        local tracks = game:GetService("Workspace"):FindFirstChild("Tracks")
        if tracks then
            tracks:Destroy()
            Library:Notify("AI Vehicles Removed!", 3)
        else
            Library:Notify("No AI Vehicles found!", 3)
        end
    end,
    Tooltip = "Removes all AI vehicles from the game"
})

VehicleGroup:AddButton({
    Text = "Remove Locked Area Barriers",
    Func = function()
        local areaLocked = game:GetService("Workspace"):FindFirstChild("AreaLocked")
        if areaLocked then
            areaLocked:Destroy()
            Library:Notify("Area Barriers Removed!", 3)
        else
            Library:Notify("No Area Barriers found!", 3)
        end
    end,
    Tooltip = "Removes locked area barriers"
})

Library:Notify({
    Title = "Taxi Boss Script",
    Description = "Successfully loaded!",
    Time = 3
})
