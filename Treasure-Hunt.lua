local ws = game:GetService("Workspace")
for _, v in pairs(ws:GetDescendants()) do
    if v:IsA("Highlight") and v.Name == "SpecialMeshHighlight" then
        v:Destroy()
    end
end
local folder = ws:FindFirstChild("SandBlocks")
if not folder then return end
for _, v in pairs(folder:GetDescendants()) do
    if v:IsA("BasePart") or v:IsA("Part") then
        if v:FindFirstChildOfClass("SpecialMesh") then
            local hl = Instance.new("Highlight")
            hl.Name = "SpecialMeshHighlight"
            hl.Adornee = v
            hl.FillColor = Color3.fromRGB(255, 0, 0)
            hl.OutlineColor = Color3.fromRGB(255, 100, 100)
            hl.FillTransparency = 0.7
            hl.OutlineTransparency = 0.5
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = ws
        end
    end
end
