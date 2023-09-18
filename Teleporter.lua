--[[ MAKE BY XCAT SUS]] --
-- Luau

local BloxFruitTeleporter = {
	Teleport = false,
	Target = nil,
	MobModel = {}
}

BloxFruitTeleporter.TeleportSpeed = 300
BloxFruitTeleporter.MaxDistance = 50

local TweenService = game:GetService('TweenService')
local Player = game:GetService('Players').LocalPlayer
local lastSpawm = workspace:GetServerTimeNow()
local RootPart = "HumanoidRootPart"

local function GetNormalPhysicalProperties()
	return PhysicalProperties.new(0.85,0.4,0.6,1.1,1.1)
end

local function NoPhysics()
	if Player.Character then
		for i,v:BasePart?|UnionOperation? in ipairs(Player.Character:GetChildren()) do
			if v:isA('BasePart') or v:isA('UnionOperation') then
				v.Velocity = Vector3.new(0,0,0)
				v.CustomPhysicalProperties = GetNormalPhysicalProperties()
			end
		end
	end
end

function BloxFruitTeleporter:Start(target:BasePart?|Instance?|Model?|Vector3?|CFrame?,ModelTarget)
	if (workspace:GetServerTimeNow() - lastSpawm) < 1 then
		return 
	end 

	if typeof(target)=="Instance" then
		if target:isA("Model") then
			target = target:GetPivot()
		else
			target = target.CFrame
		end
	end

	if typeof(target)=="Vector3" then
		target = CFrame.new(target)
	end

	ModelTarget = ModelTarget or Player.Character

	if ModelTarget == Player.Character then
		BloxFruitTeleporter.Target = target
		BloxFruitTeleporter.Teleport = true
	else
		BloxFruitTeleporter.MobModel[ModelTarget] = {}
		BloxFruitTeleporter.MobModel[ModelTarget].Target = target
		BloxFruitTeleporter.MobModel[ModelTarget].Teleport = true
	end

	local RootPart = ModelTarget:FindFirstChild(RootPart) or ModelTarget.PrimaryPart
	local Distance = (RootPart.Position - target.Position).Magnitude

	NoPhysics()

	if math.floor(Distance) >= BloxFruitTeleporter.MaxDistance then
		local Time = (Distance / BloxFruitTeleporter.TeleportSpeed)
		local Funtion = TweenService:Create(RootPart,TweenInfo.new(Time,Enum.EasingStyle.Linear),{CFrame = target})

		repeat task.wait(0.1)
			NoPhysics()
			Funtion:Play()
		until math.floor((RootPart.Position - target.Position).Magnitude) <= BloxFruitTeleporter.MaxDistance or (not BloxFruitTeleporter.Teleport and  ModelTarget == Player.Character) or (target ~= BloxFruitTeleporter.Target and  ModelTarget == Player.Character)

		Funtion:Pause()

		if BloxFruitTeleporter.Teleport and target == BloxFruitTeleporter.Target then
			TweenService:Create(RootPart,TweenInfo.new(0.3),{CFrame = target}):Play()
		end

	else
		if  math.floor(Distance) >= BloxFruitTeleporter.MaxDistance / 2 then
			TweenService:Create(RootPart,TweenInfo.new(0.3),{CFrame = target}):Play()
		else
			RootPart.CFrame = target
			NoPhysics()
		end
	end

	if BloxFruitTeleporter.MobModel[ModelTarget] then
		BloxFruitTeleporter.MobModel[ModelTarget].Target = target
		BloxFruitTeleporter.MobModel[ModelTarget].Teleport = false
	end

	BloxFruitTeleporter.Teleport = true
end

function BloxFruitTeleporter:Stop()
	BloxFruitTeleporter.Target = nil
	BloxFruitTeleporter.Teleport = false
end

function BloxFruitTeleporter:ConfixPart(name)
	RootPart = name
end

return BloxFruitTeleporter
