task.wait(0.2)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")

Player = Players.LocalPlayer
repeat
	task.wait()
until Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("Torso")

PlayerGui = Player.PlayerGui
Cam = Workspace.CurrentCamera
Backpack = Player.Backpack
Character = Player.Character
Humanoid = Character.Humanoid
Mouse = Player:GetMouse()
RootPart = Character.HumanoidRootPart
Torso = Character.Torso
Head = Character.Head
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart.RootJoint
Neck = Torso.Neck
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]

local sick = Instance.new("Sound")
sick.SoundId = "rbxassetid://462506896"
sick.Looped = true
sick.Pitch = 1
sick.Volume = 5
sick.Parent = Character
sick:Play()

IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor

function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id=" .. MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id=" .. TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = ANCHOR ~= false
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

Player_Size = 1
Animation_Speed = 3
Frame_Speed = 1 / 60

local Speed = 16
local Disable_Jump = false

local function weldBetween(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end

function createaccessory(attachmentpart, mesh, texture, scale, offset, color)
	local acs = Instance.new("Part")
	acs.CanCollide = false
	acs.Anchored = false
	acs.Size = Vector3.new(0, 0, 0)
	acs.CFrame = attachmentpart.CFrame
	acs.Parent = Character
	acs.BrickColor = color
	local meshs = Instance.new("SpecialMesh")
	meshs.MeshId = mesh
	meshs.TextureId = texture
	meshs.Parent = acs
	meshs.Scale = scale
	meshs.Offset = offset
	weldBetween(attachmentpart, acs)
end

function createbodypart(TYPE, COLOR, PART, OFFSET, SIZE)
	if TYPE == "Gem" then
		local acs = CreatePart(3, Character, "Plastic", 0, 0, COLOR, "Part", VT(0, 0, 0))
		acs.Anchored = false
		acs.CanCollide = false
		acs.CFrame = PART.CFrame
		CreateMesh("SpecialMesh", acs, "FileMesh", "9756362", "", SIZE, OFFSET)
		weldBetween(PART, acs)
	elseif TYPE == "Skull" then
		local acs = CreatePart(3, Character, "Plastic", 0, 0, COLOR, "Part", VT(0, 0, 0))
		acs.Anchored = false
		acs.CanCollide = false
		acs.CFrame = PART.CFrame
		CreateMesh("SpecialMesh", acs, "FileMesh", "4770583", "", SIZE, OFFSET)
		weldBetween(PART, acs)
	elseif TYPE == "Eye" then
		local acs = CreatePart(3, Character, "Neon", 0, 0, COLOR, "Part", VT(0, 0, 0))
		acs.Anchored = false
		acs.CanCollide = false
		acs.CFrame = PART.CFrame
		CreateMesh("SpecialMesh", acs, "Sphere", "", "", SIZE, OFFSET)
		weldBetween(PART, acs)
	end
end

local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local ANIM = "Idle"
local ATTACK = false
local HOLD = false
local Rooted = false
local SINE = 0
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local WALK = 0
local HITFLOOR = nil
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
local WEAPONGUI = IT("ScreenGui")
WEAPONGUI.Name = "Weapon GUI"
WEAPONGUI.ResetOnSpawn = false
WEAPONGUI.Parent = PlayerGui
local Weapon = IT("Model")
Weapon.Name = "Adds"
local Delete = IT("Model")
Delete.Name = "Banlist"
Delete.Parent = Character
local Effects = IT("Folder")
Effects.Name = "Effects"
Effects.Parent = Weapon
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character:FindFirstChild("Animate")
local UNANCHOR = true
local SKILLTEXTCOLOR = C3(0, 0, 0)
local MATHS = {"0", "1"}

ArtificialHB = Instance.new("BindableEvent")
ArtificialHB.Name = "ArtificialHB"
ArtificialHB.Parent = Character

local frame = Frame_Speed
local tf = 0

ArtificialHB:Fire()

RunService.Heartbeat:Connect(function(s)
	tf += s
	if tf >= frame then
		local steps = math.floor(tf / frame)
		for _ = 1, steps do
			ArtificialHB:Fire()
		end
		tf -= frame * steps
	end
end)

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return Workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		ArtificialHB.Event:Wait()
	else
		for _ = 1, NUMBER do
			ArtificialHB.Event:Wait()
		end
	end
end

function QuaternionFromCFrame(cf)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = cf:components()
	local trace = m00 + m11 + m22
	if trace > 0 then
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m11 > m00 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s
			return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end

function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end

function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp
	if cosTheta >= 0.0001 then
		if (1 - cosTheta) > 0.0001 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	else
		if (1 + cosTheta) > 0.0001 then
			local theta = ACOS(-cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((t - 1) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = t - 1
			finishInterp = t
		end
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end

function Clerp(a, b, t)
	local qa = {QuaternionFromCFrame(a)}
	local qb = {QuaternionFromCFrame(b)}
	local ax, ay, az = a.X, a.Y, a.Z
	local bx, by, bz = b.X, b.Y, b.Z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end

function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frameObj = IT("Frame")
	frameObj.BackgroundTransparency = TRANSPARENCY
	frameObj.BorderSizePixel = BORDERSIZEPIXEL
	frameObj.Position = POSITION
	frameObj.Size = SIZE
	frameObj.BackgroundColor3 = COLOR
	frameObj.BorderColor3 = BORDERCOLOR
	frameObj.Name = NAME
	frameObj.Parent = PARENT
	return frameObj
end

function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IT("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end

function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end

function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IT(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end

local SOUND = IT("Sound")

function CreateSound(ID, PARENT, VOLUME, PITCH)
	local NEWSOUND = nil
	task.spawn(function()
		NEWSOUND = SOUND:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id=" .. ID
		Swait()
		NEWSOUND:Play()
		Debris:AddItem(NEWSOUND, 10)
	end)
	return NEWSOUND
end

function CreateWave(SIZE, WAIT, CFRAME, DOESROT, ROT, COLOR, GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0.5, BRICKC(COLOR), "Effect", VT(0, 0, 0))
	local mesh = IT("SpecialMesh")
	mesh.MeshType = "FileMesh"
	mesh.MeshId = "http://www.roblox.com/asset/?id=20329976"
	mesh.Scale = SIZE
	mesh.Offset = VT(0, 0, -SIZE.X / 8)
	mesh.Parent = wave
	wave.CFrame = CFRAME
	task.spawn(function()
		for _ = 1, WAIT do
			Swait()
			mesh.Scale += GROW
			mesh.Offset = VT(0, 0, -(mesh.Scale.X / 8))
			if DOESROT == true then
				wave.CFrame *= CFrame.fromEulerAnglesXYZ(0, ROT, 0)
			end
			wave.Transparency += 0.5 / WAIT
			if wave.Transparency > 0.99 then
				wave:Destroy()
				return
			end
		end
	end)
end

function MagicSphere(SIZE, WAIT, CFRAME, COLOR, GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Effect", VT(1, 1, 1), true)
	local mesh = IT("SpecialMesh")
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = VT(0, 0, 0)
	mesh.Parent = wave
	wave.CFrame = CFRAME
	task.spawn(function()
		for _ = 1, WAIT do
			Swait()
			mesh.Scale += GROW
			wave.Transparency += 1 / WAIT
			if wave.Transparency > 0.99 then
				wave:Destroy()
				return
			end
		end
	end)
end

function MakeForm(PART, TYPE)
	if TYPE == "Cyl" then
		IT("CylinderMesh", PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Wedge"
	end
end

local ProjectileNames = {"Water", "Arrow", "Projectile", "Effect", "Rail", "Lightning", "Bullet"}

function CheckTableForString(Table, String)
	local lowerString = string.lower(String)
	for _, v in pairs(Table) do
		if string.find(lowerString, string.lower(v)) then
			return true
		end
	end
	return false
end

function CheckIntangible(Hit)
	if Hit and Hit.Parent then
		if (not Hit.CanCollide or CheckTableForString(ProjectileNames, Hit.Name)) and not Hit.Parent:FindFirstChild("Humanoid") then
			return true
		end
	end
	return false
end

function CastZapRay(StartPos, Vec, Length, Ignore, DelayIfHit)
	local Direction = CFrame.new(StartPos, Vec).LookVector
	Ignore = (type(Ignore) == "table" and Ignore) or {Ignore}
	local RayHit, RayPos, RayNormal = Workspace:FindPartOnRayWithIgnoreList(Ray.new(StartPos, Direction * Length), Ignore)
	if RayHit and CheckIntangible(RayHit) then
		if DelayIfHit then
			task.wait()
		end
		RayHit, RayPos, RayNormal = CastZapRay(RayPos + (Vec * 0.01), Vec, Length - (StartPos - RayPos).Magnitude, Ignore, DelayIfHit)
	end
	return RayHit, RayPos, RayNormal
end

function turnto(position)
	RootPart.CFrame = CFrame.new(RootPart.CFrame.p, VT(position.X, RootPart.Position.Y, position.Z))
end

local HandlePart = CreatePart(3, Weapon, "SmoothPlastic", 0, 0, "Really black", "Handle", VT(0, 0, 0), false)
CreateMesh("SpecialMesh", HandlePart, "FileMesh", "10604848", "10605252", VT(1, 1, 1), VT(0, 2.7, 0))
local HandleWeld = CreateWeldOrSnapOrMotor("Weld", HandlePart, RightArm, HandlePart, CF(0, -0.8, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)), CF(0, 0, 0))

for _, c in pairs(Weapon:GetChildren()) do
	if c:IsA("BasePart") then
		c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
	end
end

Weapon.Parent = Character

Humanoid.Died:Connect(function()
	ATTACK = true
end)

local SKILL1FRAME = CreateFrame(WEAPONGUI, 0.5, 2, UD2(0.13, 0, 0.80, 0), UD2(0.26, 0, 0.07, 0), C3(0, 0, 0), C3(0, 0, 0), "Skill 1 Frame")
local SKILL2FRAME = CreateFrame(WEAPONGUI, 0.5, 2, UD2(0.60, 0, 0.80, 0), UD2(0.26, 0, 0.07, 0), C3(0, 0, 0), C3(0, 0, 0), "Skill 2 Frame")

CreateLabel(SKILL1FRAME, "[CLICK+HOLD] Ban Slam", SKILLTEXTCOLOR, 7, "Garamond", 0, 2, 1, "Text 1")
CreateLabel(SKILL2FRAME, "[B] Teleport", SKILLTEXTCOLOR, 8, "Garamond", 0, 2, 1, "Text 2")

function BAN(CHARACTER)
	local BANFOLDER = IT("Folder")
	BANFOLDER.Parent = Effects
	local naeeym2 = Instance.new("BillboardGui")
	naeeym2.AlwaysOnTop = false
	naeeym2.Size = UDim2.new(5, 35, 2, 35)
	naeeym2.StudsOffset = Vector3.new(0, 1, 0)
	naeeym2.Name = "AAAA"
	naeeym2.Parent = BANFOLDER
	local tecks2 = Instance.new("TextLabel")
	tecks2.BackgroundTransparency = 1
	tecks2.TextScaled = true
	tecks2.BorderSizePixel = 0
	tecks2.Text = "BANNED"
	tecks2.Font = Enum.Font.Code
	tecks2.TextSize = 30
	tecks2.TextStrokeTransparency = 1
	tecks2.TextColor3 = Color3.new(1, 0, 0)
	tecks2.TextStrokeColor3 = Color3.new(1, 0, 0)
	tecks2.Size = UDim2.new(1, 0, 0.5, 0)
	tecks2.Parent = naeeym2
	for _, v in ipairs(CHARACTER:GetChildren()) do
		if (v:IsA("Part") or v:IsA("MeshPart")) and v.Name ~= "HumanoidRootPart" then
			local BOD = v:Clone()
			BOD.CanCollide = false
			BOD.Anchored = true
			BOD.CFrame = v.CFrame
			BOD.Parent = BANFOLDER
			BOD.Material = Enum.Material.Neon
			BOD.Color = C3(1, 0, 0)
			local decal = BOD:FindFirstChildOfClass("Decal")
			if decal then
				decal:Destroy()
			end
			if BOD.Name == "Head" then
				naeeym2.Adornee = BOD
			end
			if BOD:IsA("MeshPart") then
				BOD.TextureID = ""
			end
		end
	end
	CHARACTER:Destroy()
	task.spawn(function()
		for _ = 1, 50 do
			Swait()
			for _, v in ipairs(BANFOLDER:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 1
				end
			end
			naeeym2.Enabled = false
			Swait()
			for _, v in ipairs(BANFOLDER:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 0
				end
			end
			naeeym2.Enabled = true
		end
		BANFOLDER:Destroy()
	end)
end

function BANNEAREST(POS, RANGE)
	for _, v in ipairs(Workspace:GetChildren()) do
		if v ~= Character and v:FindFirstChildOfClass("Humanoid") then
			for _, bodyPart in ipairs(v:GetChildren()) do
				if (bodyPart:IsA("Part") or bodyPart:IsA("MeshPart") or bodyPart:IsA("BasePart")) and (bodyPart.Position - POS).Magnitude < RANGE then
					BAN(v)
					if Players:FindFirstChild(v.Name) then
						local Value = IT("BoolValue")
						Value.Name = v.Name
						Value.Parent = Delete
					end
					break
				end
			end
		end
	end
end

function CreateDebreeRing(FLOOR, POSITION, SIZE, BLOCKSIZE, SWAIT)
	if FLOOR ~= nil then
		task.spawn(function()
			local PART = CreatePart(3, Effects, "Plastic", 0, 1, "Pearl", "DebreeCenter", VT(0, 0, 0))
			PART.CFrame = CF(POSITION)
			for i = 1, 45 do
				local RingPiece = CreatePart(3, Effects, "Plastic", 0, 0, "Pearl", "DebreePart", BLOCKSIZE)
				RingPiece.Material = FLOOR.Material
				RingPiece.Color = FLOOR.Color
				RingPiece.CFrame = PART.CFrame * ANGLES(RAD(0), RAD(i * 8), RAD(0)) * CF(SIZE * 4, 0, 0) * ANGLES(RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)), RAD(MRANDOM(-360, 360)))
				Debris:AddItem(RingPiece, SWAIT / 100)
			end
			PART:Destroy()
		end)
	end
end

function BANSLAM()
	ATTACK = true
	Rooted = false
	repeat
		for i = 0, 0.2, 0.1 / Animation_Speed do
			Swait()
			HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -0.8, 0) * ANGLES(RAD(-90), RAD(-45), RAD(0)), 2 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 7) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(25), RAD(0), RAD(0)), 2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, 0.5) * ANGLES(RAD(250), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1, 0.5, 0.5) * ANGLES(RAD(250), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 2 / Animation_Speed)
		end
		for i = 0, 0.08, 0.1 / Animation_Speed do
			Swait()
			HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -1, 0) * ANGLES(RAD(-90), RAD(-45), RAD(0)), 2 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 2) * ANGLES(RAD(75), RAD(0), RAD(0)), 2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, -1) * ANGLES(RAD(120), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1, 0.5, -1) * ANGLES(RAD(120), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
		end
		for i = 0, 0.08, 0.1 / Animation_Speed do
			Swait()
			HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -1, 0) * ANGLES(RAD(-70), RAD(-45), RAD(0)), 2 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 2) * ANGLES(RAD(75), RAD(0), RAD(0)), 2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, -1) * ANGLES(RAD(60), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1, 0.5, -1) * ANGLES(RAD(60), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
		end
		CreateSound("147722910", Effects, 10, 1)
		BANNEAREST(RootPart.CFrame * CF(0, 0, -6).p, 25)
		if HITFLOOR ~= nil then
			CreateSound("289842971", HandlePart, 10, 1)
			CreateDebreeRing(HITFLOOR, RootPart.CFrame * CF(0, -5, -6).p, 5, VT(8, 8, 8), 35)
		end
		local slamCF = RootPart.CFrame * CF(0, -5, -6)
		CreateWave(VT(25, 0, 25), 45, slamCF, true, 2, "Really red", VT(0, 3, 0))
		CreateWave(VT(25, 0, 25), 45, slamCF, true, -2, "Really red", VT(0, 3, 0))
		for i = 0, 0.1, 0.1 / Animation_Speed do
			Swait()
			HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -1, 0) * ANGLES(RAD(-70), RAD(-45), RAD(0)), 2 / Animation_Speed)
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 1.8) * ANGLES(RAD(75), RAD(0), RAD(0)), 2 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 2 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, -1) * ANGLES(RAD(60), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1, 0.5, -1) * ANGLES(RAD(60), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
		end
		if HOLD == true then
			for i = 0, 0.08, 0.1 / Animation_Speed do
				Swait()
				if HOLD == false then
					break
				end
				HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -1, 0) * ANGLES(RAD(-90), RAD(-45), RAD(0)), 2 / Animation_Speed)
				RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 2) * ANGLES(RAD(75), RAD(0), RAD(0)), 2 / Animation_Speed)
				Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 2 / Animation_Speed)
				RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, -1) * ANGLES(RAD(120), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
				LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1, 0.5, -1) * ANGLES(RAD(120), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2 / Animation_Speed)
				RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
				LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
			end
		end
	until HOLD == false
	for i = 0, 1, 0.1 / Animation_Speed do
		Swait()
		HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -1, 0) * ANGLES(RAD(-70), RAD(-45), RAD(0)), 2 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 1.8) * ANGLES(RAD(75), RAD(0), RAD(0)), 2 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-25), RAD(0), RAD(0)), 2 / Animation_Speed)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1, 0.5, -1) * ANGLES(RAD(60), RAD(0), RAD(-45)) * RIGHTSHOULDERC0, 2 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1, 0.5, -1) * ANGLES(RAD(60), RAD(0), RAD(45)) * LEFTSHOULDERC0, 2 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(25)), 0.5 / Animation_Speed)
	end
	for i = 0, 5, 0.1 / Animation_Speed do
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0, 0) * ANGLES(RAD(200), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 0.2 / Animation_Speed)
		HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -0.8, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)), 0.2 / Animation_Speed)
		RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
		RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
		LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
	end
	ATTACK = false
	Rooted = false
end

function MouseDown()
	HOLD = true
	if ATTACK == false then
		BANSLAM()
	end
end

function MouseUp()
	HOLD = false
end

function KeyDown(Key)
	KEYHOLD = true
	if Key == "b" and ATTACK == false then
		local pos = RootPart.Position
		RootPart.CFrame = CF(Mouse.Hit.p + VT(0, 3, 0), pos)
		CreateSound("769380905", Torso, 10, 1)
	end
	if Key == "t" then
		CreateSound("1058417264", Head, 10, 1)
		Delete:ClearAllChildren()
	end
end

function KeyUp()
	KEYHOLD = false
end

Mouse.Button1Down:Connect(MouseDown)
Mouse.Button1Up:Connect(MouseUp)
Mouse.KeyDown:Connect(KeyDown)
Mouse.KeyUp:Connect(KeyUp)

function unanchor()
	if UNANCHOR == true then
		for _, child in ipairs(Character:GetChildren()) do
			if child:IsA("BasePart") then
				child.Anchored = false
			end
		end
	end
end

Humanoid.Changed:Connect(function(Jump)
	if Jump == "Jump" and Disable_Jump == true then
		Humanoid.Jump = false
	end
end)

Speed = 23

if ANIMATE then
	ANIMATE.Parent = nil
end

local IDLEANIMATION = ANIMATOR:LoadAnimation(ROBLOXIDLEANIMATION)
IDLEANIMATION.Looped = true
IDLEANIMATION:Play()

local lerpIdle = 0.15 / Animation_Speed
local lerpWalk = 0.2 / Animation_Speed
local lerpArm = 0.2 / Animation_Speed

while true do
	Swait()
	if not IDLEANIMATION.IsPlaying then
		IDLEANIMATION:Play()
	end
	SINE += CHANGE
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).Magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.Y
	HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).LookVector, 4 * Player_Size, Character)
	local WALKSPEEDVALUE = 6 / (Humanoid.WalkSpeed / 16)
	if ATTACK == false then
		RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0, 0) * ANGLES(RAD(200), RAD(90), RAD(0)) * RIGHTSHOULDERC0, lerpArm)
		HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -0.8, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)), lerpArm)
	end
	if ANIM == "Walk" and TORSOVELOCITY > 1 and ATTACK == false then
		local walkMul = 2 * (Humanoid.WalkSpeed / 16) / Animation_Speed
		local walkLerp = 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, -0.15 * COS(SINE / (WALKSPEEDVALUE / 2)) * Player_Size) * ANGLES(RAD(0), RAD(0) - RootPart.RotVelocity.Y / 75, RAD(0)), walkMul)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5 * Player_Size, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - Head.RotVelocity.Y / 30), walkLerp)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5 * Player_Size, 0.875 * Player_Size - 0.125 * SIN(SINE / WALKSPEEDVALUE) * Player_Size, -0.125 * COS(SINE / WALKSPEEDVALUE) * Player_Size) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0) - RightLeg.RotVelocity.Y / 75, RAD(0), RAD(76 * COS(SINE / WALKSPEEDVALUE))), walkLerp)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5 * Player_Size, 0.875 * Player_Size + 0.125 * SIN(SINE / WALKSPEEDVALUE) * Player_Size, 0.125 * COS(SINE / WALKSPEEDVALUE) * Player_Size) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0) + LeftLeg.RotVelocity.Y / 75, RAD(0), RAD(76 * COS(SINE / WALKSPEEDVALUE))), walkLerp)
	else
		RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), lerpWalk)
		Neck.C1 = Clerp(Neck.C1, CF(0, -0.5 * Player_Size, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)), lerpWalk)
		RightHip.C1 = Clerp(RightHip.C1, CF(0.5 * Player_Size, 1 * Player_Size, 0) * ANGLES(RAD(0), RAD(90), RAD(0)), lerpWalk)
		LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5 * Player_Size, 1 * Player_Size, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)), lerpWalk)
	end
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), lerpArm)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-20), RAD(0), RAD(0)), lerpArm)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-40), RAD(0), RAD(-20)) * LEFTSHOULDERC0, lerpArm)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.3) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-20)), lerpArm)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, -0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(20)), lerpArm)
		end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), lerpArm)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(20), RAD(0), RAD(0)), lerpArm)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-60)) * LEFTSHOULDERC0, lerpArm)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), lerpArm)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), lerpArm)
		end
	elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
		ANIM = "Idle"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), lerpIdle)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(-2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), lerpIdle)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, lerpIdle)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), lerpIdle)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), lerpIdle)
		end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		WALK += 1 / Animation_Speed
		if WALK >= 15 - (5 * (Humanoid.WalkSpeed / 16 / Player_Size)) then
			WALK = 0
			WALKINGANIM = not WALKINGANIM
		end
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, -0.1) * ANGLES(RAD(5), RAD(0), RAD(0)), lerpIdle)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0) * ANGLES(RAD(5 - 8 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0)), lerpIdle)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-60 * COS(SINE / WALKSPEEDVALUE)), RAD(0), RAD(-5)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.15 * COS(SINE / WALKSPEEDVALUE * 2), -0.2 + 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-15)), 2 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.15 * COS(SINE / WALKSPEEDVALUE * 2), -0.2 + -0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(15)), 2 / Animation_Speed)
		end
	end
	unanchor()
	Humanoid.MaxHealth = math.huge
	Humanoid.Health = math.huge
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	else
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	local nameBuf = table.create(18)
	for i = 1, 18 do
		nameBuf[i] = MATHS[MRANDOM(1, 2)]
	end
	Humanoid.Name = table.concat(nameBuf)
	Humanoid.PlatformStand = false
	for _, PLAY in ipairs(Players:GetPlayers()) do
		if PLAY.Character and Delete:FindFirstChild(PLAY.Name) then
			PLAY.Character:Destroy()
		end
	end
end
