local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character, RootPart

local AlreadyFound = {}
local function FindGunSpawner(GunName)
    if AlreadyFound[GunName] ~= nil then
        return AlreadyFound[GunName], true
    end
	for i,v in pairs(workspace:GetChildren()) do
		if v.Name == "TouchGiver" then
			if v:GetAttribute("ToolName") == GunName then
                AlreadyFound[GunName] = v.TouchGiver
				return v.TouchGiver, false
			end
		end
	end
end

local function GetTool(ToolName)
    return LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild(ToolName) or LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(ToolName)
end


local function GetGun(GunName)
    local Giver, Found = FindGunSpawner(GunName)
    if not Found then
        local CloneGiver = Giver:Clone()
        CloneGiver.Parent = Giver.Parent
        Giver.Parent = workspace.Folder
        Giver.CanCollide = false
        Giver.Transparency = 1
    end
    repeat task.wait()
        Giver.CFrame = RootPart.CFrame * CFrame.new(math.random(-2, 2),0,0)
    until GetTool(GunName)
end

local function DoorsHandler()
    local Doors = workspace:FindFirstChild("Doors")
    for i,v in pairs(Doors:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.Transparency = 0.6
        end
    end
    local CellDoors = workspace:FindFirstChild("CellDoors")
    for i,v in pairs(CellDoors:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.Transparency = 0.6
        end
    end
end

local Gun1 = "AK-47"
local Gun2 = "Remington 870"

RunService.Heartbeat:Connect(function()
    Character = LocalPlayer.Character
    RootPart = Character.HumanoidRootPart
    Humanoid = Character.Humanoid
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    if not GetTool(Gun1) then
        GetGun(Gun1)
    end
    if not GetTool(Gun2) then
        GetGun(Gun2)
    end
    DoorsHandler()
end)
