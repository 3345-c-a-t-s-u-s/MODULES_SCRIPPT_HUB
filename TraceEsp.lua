--[[ Tracer Esp Make By cat sus]]
export type confix = {
	Color : Color3,
}

export type Custom_Confix = {
	AutoDelete : boolean,
	Color : Color3,
	AutoUpdate : boolean
}

local Camera = workspace.CurrentCamera

local function GetLineOrigin(Camera)
	return Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y*.9)
end

local LineOrigin = GetLineOrigin(Camera)

local Gui = Instance.new("ScreenGui")

Gui.ResetOnSpawn = false

Gui.Name = tostring(math.random(0,9))..tostring(math.random(0,9))..tostring(math.random(0,9))..tostring(math.random(0,9))..tostring(math.random(0,9))..tostring(math.random(0,9))

Gui.Parent = game.CoreGui

Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	LineOrigin = GetLineOrigin(Camera)
end)

function Setline(Line, Width, Color, Origin, Destination)
	LineOrigin = GetLineOrigin(Camera)
	Origin = Origin or LineOrigin
	local Position = (Origin + Destination) / 2
	Line.Position = UDim2.new(0, Position.X, 0, Position.Y)
	local Length = (Origin - Destination).Magnitude
	Line.BackgroundColor3 = Color
	Line.BorderColor3 = Color
	Line.Size = UDim2.new(0, Length, 0, Width)
	Line.Rotation = math.deg(math.atan2(Destination.Y - Origin.Y, Destination.X - Origin.X))
end

local Tracer_Esp = {
	LineWidth = 0.1,
	AutoUpdate = true,
	TranDex = 0,
	Main = {},
	LOOP_BINDS = {}
}

local function IsInScreen(Position:Vector3)
	local Duration = (Position - workspace.CurrentCamera.CFrame.Position).Unit * 1000000000000
	local lOOK = workspace.CurrentCamera.CFrame.LookVector
	local mem = workspace.CurrentCamera.FieldOfView / 120

	if Duration:Dot(lOOK) > mem then
		return true
	else
		return false
	end
end

local function Find(line)
	for i,v in ipairs(Tracer_Esp.LOOP_BINDS) do
		if v[2]==line then
			return i,v
		end
	end
end

function Tracer_Esp:Tracer(Target:BasePart,CustomConfix:Custom_Confix)
	-- Target Only Part - Object not Support value CFrame - Vector
	if not Target or typeof(Target)=="Vector3" or typeof(Target)=="CFrame" then
		return
	end

	task.wait()

	CustomConfix = CustomConfix or {}
	CustomConfix.Color = CustomConfix.Color or Color3.fromRGB(255,255,255)
	CustomConfix.AutoDelete = CustomConfix.AutoDelete
	CustomConfix.AutoUpdate = CustomConfix.AutoUpdate

	local NewLine = Instance.new("Frame")
	NewLine.Name = tostring(Target)
	NewLine.AnchorPoint = Vector2.new(.5, .5)
	NewLine.Parent = Gui
	NewLine.Transparency = Tracer_Esp.TranDex

	local bx = {}
	local espui = nil

	if CustomConfix.AutoUpdate then
		table.insert(Tracer_Esp.LOOP_BINDS,{Target,NewLine,CustomConfix.Color})	
	end

	local function del()
		if not NewLine then
			return
		end

		NewLine.Visible = false
		NewLine:Destroy()

		if espui ~= nil then
			espui:Destroy()
		end

		pcall(function()
			if CustomConfix.AutoUpdate then
				local index = Find(NewLine)

				if index then
					table.remove(Tracer_Esp.LOOP_BINDS,index)
				end
			end
		end)

		pcall(function()
			for i,v in ipairs(bx) do
				if v then
					pcall(function()
						v:Disconnect()
					end)
				end
			end
		end)

		pcall(function()
			if NewLine then
				NewLine:Destroy()
			end
		end)

		return
	end

	table.insert(bx,Target.Changed:Connect(function()
		if not CustomConfix.AutoDelete then
			return
		end
		
		if not Target:IsDescendantOf(workspace) then
			del()
		end
	end))

	table.insert(bx,Target.AncestryChanged:Connect(function(lfr)
		if not CustomConfix.AutoDelete then
			return
		end
		
		if not Target:IsDescendantOf(workspace) then
			del()
		end
	end))

	local dex = {}

	function dex:Delete()
		del()
	end

	function dex:Edit(NewCustomConfix:Custom_Confix)
		NewCustomConfix = NewCustomConfix or {}
		NewCustomConfix.Color = NewCustomConfix.Color or Color3.fromRGB(255,255,255)
		NewCustomConfix.AutoDelete = NewCustomConfix.AutoDelete
		NewCustomConfix.AutoUpdate = NewCustomConfix.AutoUpdate

		CustomConfix.AutoUpdate = NewCustomConfix.AutoUpdate
		CustomConfix.AutoDelete = CustomConfix.AutoDelete

		for i,v in ipairs(Tracer_Esp.LOOP_BINDS) do
			if v[2] == NewLine then
				v[3] = NewCustomConfix.Color or CustomConfix.Color
				Tracer_Esp.LOOP_BINDS[i][3] = NewCustomConfix.Color or CustomConfix.Color
			end
		end
	end

	function dex:AddUIEsp(Name,Type,Color,On_Distance)
		Color = Color or Color3.fromRGB(255, 255, 255)
		local BillboardGui = Instance.new("BillboardGui")
		local TextLabel = Instance.new("TextLabel")

		BillboardGui.Parent = game:FindFirstChild('CoreGui') or Gui
		BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		BillboardGui.Active = true
		BillboardGui.Adornee = Target
		BillboardGui.AlwaysOnTop = true
		BillboardGui.LightInfluence = 1.000
		BillboardGui.Size = UDim2.new(7, 0, 1.5, 0)
		BillboardGui.StudsOffset = Vector3.new(0, 3.5, 0)

		TextLabel.Parent = BillboardGui
		TextLabel.AnchorPoint = Vector2.new(0, 0.5)
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(1, 0, 0.899999976, 0)
		TextLabel.Font = Enum.Font.SourceSansBold
		TextLabel.TextColor3 = Color3.fromRGB(254, 254, 254)
		TextLabel.TextScaled = true
		TextLabel.TextSize = 14.000
		TextLabel.TextWrapped = true

		espui = BillboardGui

		if On_Distance then
			coroutine.wrap(function()
				while true do task.wait(0.1)
					pcall(function()
						local disance = (workspace.CurrentCamera.CFrame.Position - Target.Position).Magnitude


						if Type then
							TextLabel.Text = tostring(Name)..tostring(" | ")..tostring(Type)..tostring(" | ")..tostring(math.ceil(disance))..tostring("M")

						else

							TextLabel.Text = tostring(Name)..tostring(" | ")..tostring(math.ceil(disance))..tostring("M")

						end
					end)
				end
			end)()

		else
			if Type then
				TextLabel.Text = tostring(Name)..tostring(" | ")..tostring(Type)

			else

				TextLabel.Text = tostring(Name)

			end
		end
	end

	return dex
end



function Tracer_Esp:CreateTracer(name,target,confix:confix)
	if Tracer_Esp.Main[name] then
		warn("already haved data")
		return 
	end

	confix = confix or {}
	confix.Color = confix.Color or Color3.fromRGB(255,255,255)

	local target_Fixed = (typeof(target)=="CFrame" and target.Position) or ((typeof(target)=="Instance" and target.ClassName=="Model")and target:GetPivot().Position) or ((typeof(target)=="Instance" and target:isA"BasePart")and target.Position) or ((typeof(target)=="Instance" and target:isA"UnionOperation")and target.Position) or target

	local NewLine = Instance.new("Frame")
	NewLine.Name = name
	NewLine.AnchorPoint = Vector2.new(.5, .5)
	NewLine.Parent = Gui
	NewLine.Transparency = Tracer_Esp.TranDex

	Tracer_Esp.Main[name] = {}

	Tracer_Esp.Main[name]['Confix'] = confix

	Tracer_Esp.Main[name]['Frame'] = NewLine

	Tracer_Esp.Main[name]['Update'] = function()
		target_Fixed = (typeof(target)=="CFrame" and target.Position) or ((typeof(target)=="Instance" and target.ClassName=="Model")and target:GetPivot().Position) or ((typeof(target)=="Instance" and target:isA"BasePart")and target.Position) or ((typeof(target)=="Instance" and target:isA"UnionOperation")and target.Position) or target

		local ScreenPoint = Camera:WorldToScreenPoint(target_Fixed)
		local arge = {Vector2.new(ScreenPoint.X, ScreenPoint.Y),Tracer_Esp.Main[name]['Confix'].Color}
		if IsInScreen(target_Fixed) then
			NewLine.Visible = true
			Setline(NewLine, Tracer_Esp.LineWidth, arge[2], LineOrigin, arge[1])
		else
			NewLine.Visible = false
		end
	end

	return Tracer_Esp.Main[name]
end

function Tracer_Esp:ConfixTracer(name,Confix:confix)
	Confix = Confix or {}
	Confix.Color = Confix.Color or Color3.fromRGB(255,255,255)
	if Tracer_Esp.Main[name] then
		Tracer_Esp.Main[name].Confix = Confix
	end
end

function Tracer_Esp:Delete(name)
	if Tracer_Esp.Main[name] then
		local frame = Tracer_Esp.Main[name]['Frame']
		Tracer_Esp.Main[name] = nil

		if frame then
			frame:Destroy()
			return true
		end
	end
end

_G.TRACE_LOOP = true

coroutine.wrap(function()
	while _G.TRACE_LOOP do task.wait()
		pcall(function()
			if Tracer_Esp.AutoUpdate then
				for index,val in next,Tracer_Esp.Main do
					pcall(function()
						if Tracer_Esp.Main[index] then
							Tracer_Esp.Main[index].Update()
						end
					end)
				end
			end			
			LineOrigin = GetLineOrigin(Camera)
		end)
	end
end)()

game:GetService('RunService'):BindToRenderStep('LOOPED_ESP_TRRACE',3,function()
	for i,v in ipairs(Tracer_Esp.LOOP_BINDS) do
		local ScreenPoint = Camera:WorldToScreenPoint(v[1].Position)
		local arge = {Vector2.new(ScreenPoint.X, ScreenPoint.Y),v[3]}
		if IsInScreen(v[1].Position) then
			Setline(v[2], Tracer_Esp.LineWidth, arge[2], LineOrigin, arge[1])
			v[2].Visible = true
		else
			v[2].Visible = false
		end
	end
end)

return Tracer_Esp
