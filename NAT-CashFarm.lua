-- made by @kylosilly on discord [dm/add me if any issues]
local character = game:GetService("Players").LocalPlayer.Character

local map = game:GetService("Workspace").Map
local treasures = map.Treasures
local obby_land = map.ObbyLand

getgenv().settings = {
    auto_farm = true,
    farm_treasures = true
}

function get_time()
    return os.date("%X")
end

if (settings.auto_farm) then
    repeat
        local teleporters = obby_land.Teleporters
        local finish = obby_land.Finish
        if (#teleporters:GetChildren() == 0) or (#finish:GetChildren() == 0) then
            print("[Auto Farm] Teleporter or finish folder is empty. Attempting to fix. "..get_time())
            character:SetPrimaryPartCFrame(CFrame.new(obby_land.Model:GetPivot().Position))
            print("[Auto Farm] Empty folders fixed. "..get_time())
            task.wait(2)
        end
        local final_obby_teleporter = teleporters["11"]
        local final_obby_finish = finish["11"]
        character:SetPrimaryPartCFrame(CFrame.new(final_obby_teleporter.Position))
        print("[Auto Farm] Starting last obby. "..get_time())
        task.wait(.5)
        fireproximityprompt(final_obby_teleporter.ProximityPrompt)
        task.wait(5)
        character:SetPrimaryPartCFrame(CFrame.new(final_obby_finish.Position))
        print("[Auto Farm] Teleported to the end. "..get_time())
        task.wait(.5)
        fireproximityprompt(final_obby_finish.ProximityPrompt)
        print("[Auto Farm] Claimed 20k. "..get_time())
        task.wait(.5)
        if (#treasures:GetChildren() < 3) then
            continue
        end
        print("[Auto Farm] Collecting treasures. "..get_time())
        for _, v in treasures:GetChildren() do
            local prompt = v:FindFirstChildWhichIsA("ProximityPrompt")
            if (not prompt) then
                continue
            end
            character:SetPrimaryPartCFrame(CFrame.new(v.Position + Vector3.new(0, 20, 0)))
            task.wait(.5)
            fireproximityprompt(prompt)
        end
    until (not settings.auto_farm)
end
