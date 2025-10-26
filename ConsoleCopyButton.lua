local hui=game:GetService("CoreGui")
local govno=game:GetService("RunService")
local zalupa=game:GetService("TextService")
local function penis()
local dcmaster=hui:FindFirstChild("DevConsoleMaster")
if not dcmaster then return end
local dcwindow=dcmaster:FindFirstChild("DevConsoleWindow")
if not dcwindow then return end
local dcui=dcwindow:FindFirstChild("DevConsoleUI")
if not dcui then return end
local mainview=dcui:FindFirstChild("MainView")
if not mainview then return end
local clientlog=mainview:FindFirstChild("ClientLog")
if not clientlog then return end
local function addbaton(popka)
if popka:FindFirstChild("1") then return end
local baton=Instance.new("TextButton")
baton.Name="1"
baton.Size=UDim2.new(0,30,0,20)
baton.BackgroundTransparency=1
baton.Text="[C]"
baton.TextColor3=popka.TextColor3
baton.Font=popka.Font
baton.TextSize=popka.TextSize
baton.TextTransparency=0.5
baton.TextXAlignment=Enum.TextXAlignment.Left
baton.Parent=popka
local conn
conn=govno.RenderStepped:Connect(function()
if not baton.Parent then
conn:Disconnect()
return
end
local tb=popka.TextBounds
if tb.X>0 then
baton.AnchorPoint=Vector2.new(0,0.5)
if string.find(popka.Text,"\n") then
local last=popka.Text:match("([^\n]*)$")
local size=zalupa:GetTextSize(last,popka.TextSize,popka.Font,Vector2.new(popka.AbsoluteSize.X,math.huge))
baton.Position=UDim2.new(0,size.X+5,1,-popka.TextSize/2)
else
baton.Position=UDim2.new(0,tb.X+5,0.5,0)
end
conn:Disconnect()
end
end)
baton.MouseEnter:Connect(function() baton.TextTransparency=0 end)
baton.MouseLeave:Connect(function() baton.TextTransparency=0.5 end)
baton.MouseButton1Click:Connect(function()
setclipboard(popka.Text)
baton.Text="[✓]"
task.wait(0.3)
baton.Text="[C]"
end)
end
local function findpopka(obj)
for _,popka in pairs(obj:GetDescendants()) do
if popka:IsA("TextLabel") and not popka:FindFirstChild("1") then
addbaton(popka)
end
end
end
for _,frame in pairs(clientlog:GetChildren()) do
if frame:IsA("Frame") or frame:IsA("ScrollingFrame") then
findpopka(frame)
end
end
clientlog.ChildAdded:Connect(function(child)
task.wait(0.15)
if child then findpopka(child) end
end)
clientlog.DescendantAdded:Connect(function(desc)
if desc:IsA("TextLabel") and not desc:FindFirstChild("1") then
task.wait(0.05)
addbaton(desc)
end
end)
end
penis()
local timer=0
govno.Heartbeat:Connect(function(delta)
timer=timer+delta
if timer>1 then
timer=0
local m=hui:FindFirstChild("DevConsoleMaster")
if m and m:FindFirstChild("DevConsoleWindow") then penis() end
end
end)
