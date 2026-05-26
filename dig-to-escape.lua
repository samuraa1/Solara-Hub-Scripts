local P = game:GetService("Players").LocalPlayer
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")

local Map = WS.Map
local Itms = Map.Functional.SpawnedItems
local Types = {"Common","Uncommon","Rare","Epic","Legendary"}

local S  = Vector3.new(95.03419, -7.15, 13.17359)      --// Sell spot
local Sp = Vector3.new(-56.4, -7.15, 58.1)            --// Spawn spot
local B  = Vector3.new(-18.22465, -6.81196, 56.97668) --// Bring spot

local function HRP()
    local C = P.Character or P.CharacterAdded:Wait()
    return C:WaitForChild("HumanoidRootPart")
end

local function Go(Pos)
    local H = HRP()
    H.CFrame = CFrame.new(Pos)
    RS.Heartbeat:Wait()
    H.Velocity = Vector3.new(0,0,0)
end

local function SellBtn()
    local NPCs = Map.Functional.SpawnedNPCs
    local S = NPCs and NPCs:FindFirstChild("Seller")
    if S then
        local A = S:FindFirstChild("Right Arm")
        local G = A and A:FindFirstChild("RightGripAttachment")
        return G and G:FindFirstChild("BuyPrompt")
    end
end

local function Sack()
    local Stats = P:FindFirstChild("hiddenstats")
    return Stats and Stats:FindFirstChild("MaxSackSize"), Stats and Stats:FindFirstChild("CurrentSackSize")
end

local function GetItms()
    local Fnd = {}
    for _, T in pairs(Types) do
        local F = Itms:FindFirstChild(T)
        if F then
            for _, I in pairs(F:GetChildren()) do
                if I:IsA("Model") then
                    table.insert(Fnd, I)
                end
            end
        end
    end
    return Fnd
end

local function PutItms(Itms)
    local Cnt = #Itms
    local Rng = 4
    for i, I in pairs(Itms) do
        local P = I:FindFirstChild("MeshPart") or I:FindFirstChildWhichIsA("BasePart")
        if P then
            local A = (i / Cnt) * math.pi * 2
            local X = math.cos(A) * Rng
            local Z = math.sin(A) * Rng
            local Pos = Vector3.new(B.X + X, B.Y, B.Z + Z)

            P.Anchored = false
            P.CFrame = CFrame.new(Pos)
            P.CanCollide = true

            for _, C in pairs(I:GetChildren()) do
                if C:IsA("BasePart") then
                    C.Anchored = false
                end
            end
        end
    end
end

local function Bring()
    local I = GetItms()
    if #I > 0 then
        PutItms(I)
    end
end

local function Sell()
    local Max, Cur = Sack()
    if not Max or not Cur then return end
    local Btn = SellBtn()
    if not Btn then return end

    if Cur.Value >= Max.Value then
        Go(S)
        while Cur.Value > 0 and Btn do
            fireproximityprompt(Btn)
            RS.Heartbeat:Wait()
        end
        Go(Sp)
    end
end

local Max, Cur = Sack()
Bring()

Cur.Changed:Connect(function()
    if Cur.Value >= Max.Value then
        Sell()
    end
end)
