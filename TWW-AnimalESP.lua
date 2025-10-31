local ws = game.Workspace
local function addHL(model)
    if model:FindFirstChildOfClass("Highlight") then return end
    local hl = Instance.new("Highlight")
    hl.Name = "ESP_Highlight"
    hl.Adornee = model
    hl.FillColor = Color3.new(1, 0, 0)
    hl.FillTransparency = 0.3
    hl.OutlineColor = Color3.new(1, 0, 0)
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = model
end
local function remHL(model)
    local hl = model:FindFirstChild("ESP_Highlight")
    if hl then hl:Destroy() end
end
while true do
    local ent = ws:FindFirstChild("WORKSPACE_Entities")
    if ent then
        local animals = ent:FindFirstChild("Animals")
        if animals then
            for _, a in pairs(animals:GetChildren()) do
                remHL(a)
            end
            for _, a in pairs(animals:GetChildren()) do
                addHL(a)
            end
        end
    end
    wait(5)
end
