local function LoadScript(ID)
    local success, err = pcall(function()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Mana-scripts/Neverlose-UI/refs/heads/main/Games/"..tostring(ID)..".lua"))()
    end)
    if not success then
        warn("Something went wrong | ", err)
    end
end
LoadScript(game.PlaceId)
