local BEH = {}

local c = coroutine 

function BEH:NewThread(Function:func|nil) : RBXScriptSignal
	return c.wrap(function()
		Function()
	end)()
end

function BEH:NewLoop(FunctionCallback:func|nil,fpsta:number|nil) : nil | unknown
	_G.BEDOL_HUB_LOOP_FUNCTIONS = _G.BEDOL_HUB_LOOP_FUNCTIONS or 1
	
	_G.BEDOL_HUB_LOOP_FUNCTIONS += 1
	
	FunctionCallback = FunctionCallback or function() end
	
	BEH:NewThread(function()
		local DataName = tostring(math.random(0,9))..tostring(math.random(0,9))..tostring(math.random(0,9))
		_G[DataName] = true
		while (_G[DataName] or true) do task.wait()
			local Call,Error = pcall(function()
				FunctionCallback(true)
			end)
			if Error then
				print("Function Data: ["..tostring(DataName).."] | Found Error: "..tostring(Error)..tostring(" | Function Loop Number")..tostring(_G.BEDOL_HUB_LOOP_FUNCTIONS))
			end
			pcall(function()
				if fpsta then
					local Tiempo = tick()
					repeat wait(0.1)
						local Transcurrido = math.abs(Tiempo-tick())
						Tiempo = tick()
						local FPS = math.floor(1/Transcurrido)
					until FPS >= fpsta
				end
			end)
		end
	end)
end

function BEH:GetUserGamePass(Target:number):boolean
	Target = Target or 0
	local UserId = game:GetService('Players').LocalPlayer.UserId
	local API = "https://inventory.roblox.com/v1/users/"..tostring(UserId).."/items/GamePass/"..tostring(Target)
	if API then
		local Https = game:HttpGet(API)
		local Json = game:GetService('HttpService'):JSONDecode(Https)
		if Json then
			local Main = Json['data']
			local type_ = Main[1]['type'] or nil
			if type_ then
				return true
			else
				return false
			end
		end
	end
end

function BEH:GetUserProfile():{}
	local API = "https://users.roblox.com/v1/users/"..tostring(game.Players.LocalPlayer.UserId)
	local Https = game:HttpGet(API)
	local Json = game:GetService('HttpService'):JSONDecode(Https)
	return Json or {}
end

function BEH:GetPlayerBadges():{}
	local DataMainReturrn = {}
	local UserId = game.Players.LocalPlayer.UserId
	local API = "https://badges.roproxy.com/v1/users/"..tostring(UserId).."/badges?limit=100&sortOrder=Asc"
	local json = game:GetService('HttpService'):JSONDecode(API)
	
	local data = json["data"]
	
	local al_number = #data
	for i,v in ipairs(data) do
		local Id = v["id"]
		
		DataMainReturrn[Id] = {
			enabled = v['enabled'],
			id = Id,
			iconImageId = v['iconImageId'],
			description = v['description'],
			displayName = v['displayName'],
			updated = v['updated'],
			name = v['name'],
			created = v["created"],
			displayIconImageId = v['displayIconImageId'],
			statistics = {
				pastDayAwardedCount = v['statistics']['pastDayAwardedCount'],
				winRatePercentage = v['statistics']['winRatePercentage'],
				awardedCount = v['statistics']['awardedCount']
			},
			awarder = {
				id = v['awarder']['id'],
				Type = v["awarder"]['type']
			},
			displayDescription = v['displayDescription']
		}
	end
	
	return DataMainReturrn,al_number
end

return BEH

