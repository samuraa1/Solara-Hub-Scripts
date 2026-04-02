local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Nixks Hub", "DarkTheme")

-- MAIN
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Important")

MainSection:NewButton("Aimbot", "Lock onto people", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/TkzWLwHg'))()
end)

MainSection:NewButton("Esp", "see people lol", function()
    pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua'))() end)
end)


