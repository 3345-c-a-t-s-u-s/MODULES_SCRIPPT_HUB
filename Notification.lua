-- [UI notification]

local nofs = {}

function nofs:Create()
	local nof = Instance.new("ScreenGui")
	local pos = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	nof.Name = "nof"
	nof.Parent = game:FindFirstChild('CoreGui') or game.Players.LocalPlayer:WaitForChild("PlayerGui")
	nof.ResetOnSpawn = false

	pos.Name = "pos"
	pos.Parent = nof
	pos.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	pos.BackgroundTransparency = 1.000
	pos.BorderColor3 = Color3.fromRGB(0, 0, 0)
	pos.BorderSizePixel = 0
	pos.Position = UDim2.new(0.834357083, 0, 0.349864125, 0)
	pos.Size = UDim2.new(0.152579874, 0, 0.300000012, 0)

	UIListLayout.Parent = pos
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.Padding = UDim.new(0, 4)

	return function(OwnerString,TitleString,TimeToDel)
		TimeToDel = TimeToDel or 1.5
		OwnerString = OwnerString or "Notification"
		if TitleString then
			local Frame = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local Owner = Instance.new("TextLabel")
			local Title = Instance.new("TextLabel")
			local Time = Instance.new("Frame")
			local UICorner_2 = Instance.new("UICorner")

			Frame.Parent = pos
			Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BackgroundTransparency = 0.250
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.ClipsDescendants = true
			Frame.Size = UDim2.new(0.949999988, 0, 0, 0)

			UICorner.CornerRadius = UDim.new(0, 3)
			UICorner.Parent = Frame

			UIStroke.Thickness = 1.500
			UIStroke.Transparency = 0.750
			UIStroke.Color = Color3.fromRGB(255, 255, 255)
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = Frame

			Owner.Name = "Owner"
			Owner.Parent = Frame
			Owner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Owner.BackgroundTransparency = 1.000
			Owner.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Owner.BorderSizePixel = 0
			Owner.Position = UDim2.new(0.0250000004, 0, 0.0500000007, 0)
			Owner.Size = UDim2.new(0.899999976, 0, 0.300000012, 0)
			Owner.Font = Enum.Font.GothamBold
			Owner.Text =  OwnerString or "Owner"
			Owner.TextColor3 = Color3.fromRGB(255, 255, 255)
			Owner.TextScaled = true
			Owner.TextSize = 14.000
			Owner.TextTransparency = 0.470
			Owner.TextWrapped = true
			Owner.TextXAlignment = Enum.TextXAlignment.Left

			Title.Name = "Title"
			Title.Parent = Frame
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.0249998029, 0, 0.342496932, 0)
			Title.Size = UDim2.new(0.900000036, 0, 0.469837189, 0)
			Title.Font = Enum.Font.GothamBold
			Title.Text = TitleString
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			Time.Name = "Time"
			Time.Parent = Frame
			Time.AnchorPoint = Vector2.new(0, 1)
			Time.BackgroundColor3 = Color3.fromRGB(111, 111, 111)
			Time.BackgroundTransparency = 0.300
			Time.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Time.BorderSizePixel = 0
			Time.Position = UDim2.new(0, 0, 1, 0)
			Time.Size = UDim2.new(0, 0, 0.150000006, 0)

			UICorner_2.CornerRadius = UDim.new(0, 3)
			UICorner_2.Parent = Time
			
			local isccoe = false
			
			local function CloseNof()
				wait(0.3)
				game:GetService('TweenService'):Create(Frame,TweenInfo.new(0.5),{
					Size = UDim2.new(0.95, 0,0, 0),
					BackgroundTransparency = 1,
				}):Play()

				game:GetService('TweenService'):Create(Title,TweenInfo.new(0.3),{
					TextTransparency = 1,
				}):Play()

				game:GetService('TweenService'):Create(Owner,TweenInfo.new(0.3),{
					TextTransparency = 1,
				}):Play()

				game:GetService('TweenService'):Create(UIStroke,TweenInfo.new(0.3),{
					Transparency = 1,
				}):Play()

				wait(0.55)
				Frame:Destroy()
			end
			
			coroutine.wrap(function()
				game:GetService('TweenService'):Create(Frame,TweenInfo.new(0.5,Enum.EasingStyle.Back),{
					Size = UDim2.new(0.95, 0,0.2, 0)
				}):Play()
				wait(0.55)
				local tween = game:GetService('TweenService'):Create(Time,TweenInfo.new(TimeToDel,Enum.EasingStyle.Linear),{
					Size = UDim2.new(1,0,0.15,0)
				})
				tween:Play()
				tween.Completed:Wait()
				if isccoe then
					return
				end
				CloseNof()
			end)()
			
			Frame.InputBegan:Connect(function(a)
				if a.UserInputType == Enum.UserInputType.Touch or a.UserInputType == Enum.UserInputType.MouseButton1 then
					if isccoe then
						return
					end
					
					if TitleString:lower():find("https") then
						pcall(function()
							setclipboard(tostring(TitleString))
						end)
					end
					
					CloseNof()
				end
			end)
			
			return false
		end
	end
end

return nofs
