--[[
	INPUT FUNCTION EXECUTOR ROBLOX
	 -FOR EXECUTOR NOT SUPPORT-
]]

local Executor = {
	HttpsRequestModule = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request;
}

local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Converter =  {
	[Enum.KeyCode.Unknown] = 0x00,
	[Enum.KeyCode.Backspace] = 0x08,
	[Enum.KeyCode.Tab] = 0x09,
	[Enum.KeyCode.Clear] = 0x0C,
	[Enum.KeyCode.Return] = 0x0D,
	[Enum.KeyCode.Pause] = 0x13,
	[Enum.KeyCode.Escape] = 0x1B,
	[Enum.KeyCode.Space] = 0x20,
	[Enum.KeyCode.Quote] = 0xDE,
	[Enum.KeyCode.Comma] = 0xBC,
	[Enum.KeyCode.Minus] = 0xBD,
	[Enum.KeyCode.Period] = 0xBE,
	[Enum.KeyCode.Slash] = 0xBF,
	[Enum.KeyCode.Zero] = 0x30,
	[Enum.KeyCode.One] = 0x31,
	[Enum.KeyCode.Two] = 0x32,
	[Enum.KeyCode.Three] = 0x33,
	[Enum.KeyCode.Four] = 0x34,
	[Enum.KeyCode.Five] = 0x35,
	[Enum.KeyCode.Six] = 0x36,
	[Enum.KeyCode.Seven] = 0x37,
	[Enum.KeyCode.Eight] = 0x38,
	[Enum.KeyCode.Nine] = 0x39,
	[Enum.KeyCode.Semicolon] = 0xBA,
	[Enum.KeyCode.Equals] = 0xBB,
	[Enum.KeyCode.A] = 0x41,
	[Enum.KeyCode.B] = 0x42,
	[Enum.KeyCode.C] = 0x43,
	[Enum.KeyCode.D] = 0x44,
	[Enum.KeyCode.E] = 0x45,
	[Enum.KeyCode.F] = 0x46,
	[Enum.KeyCode.G] = 0x47,
	[Enum.KeyCode.H] = 0x48,
	[Enum.KeyCode.I] = 0x49,
	[Enum.KeyCode.J] = 0x4A,
	[Enum.KeyCode.K] = 0x4B,
	[Enum.KeyCode.L] = 0x4C,
	[Enum.KeyCode.M] = 0x4D,
	[Enum.KeyCode.N] = 0x4E,
	[Enum.KeyCode.O] = 0x4F,
	[Enum.KeyCode.P] = 0x50,
	[Enum.KeyCode.Q] = 0x51,
	[Enum.KeyCode.R] = 0x52,
	[Enum.KeyCode.S] = 0x53,
	[Enum.KeyCode.T] = 0x54,
	[Enum.KeyCode.U] = 0x55,
	[Enum.KeyCode.V] = 0x56,
	[Enum.KeyCode.W] = 0x57,
	[Enum.KeyCode.X] = 0x58,
	[Enum.KeyCode.Y] = 0x59,
	[Enum.KeyCode.Z] = 0x5A,
}

local converter2 = {
	[0x30] = Enum.KeyCode.Zero,
	[0x31] = Enum.KeyCode.One,
	[0x32] = Enum.KeyCode.Two,
	[0x33] = Enum.KeyCode.Three,
	[0x34] = Enum.KeyCode.Four,
	[0x35] = Enum.KeyCode.Five,
	[0x36] = Enum.KeyCode.Six,
	[0x37] = Enum.KeyCode.Seven,
	[0x38] = Enum.KeyCode.Eight,
	[0x39] = Enum.KeyCode.Nine,
	[0x41] = Enum.KeyCode.A,
	[0x42] = Enum.KeyCode.B,
	[0x43] = Enum.KeyCode.C,
	[0x44] = Enum.KeyCode.D,
	[0x45] = Enum.KeyCode.E,
	[0x46] = Enum.KeyCode.F,
	[0x47] = Enum.KeyCode.G,
	[0x48] = Enum.KeyCode.H,
	[0x49] = Enum.KeyCode.I,
	[0x4A] = Enum.KeyCode.J,
	[0x4B] = Enum.KeyCode.K,
	[0x4C] = Enum.KeyCode.L,
	[0x4D] = Enum.KeyCode.M,
	[0x4E] = Enum.KeyCode.N,
	[0x4F] = Enum.KeyCode.O,
	[0x50] = Enum.KeyCode.P,
	[0x51] = Enum.KeyCode.Q,
	[0x52] = Enum.KeyCode.R,
	[0x53] = Enum.KeyCode.S,
	[0x54] = Enum.KeyCode.T,
	[0x55] = Enum.KeyCode.U,
	[0x56] = Enum.KeyCode.V,
	[0x57] = Enum.KeyCode.W,
	[0x58] = Enum.KeyCode.X,
	[0x59] = Enum.KeyCode.Y,
	[0x5A] = Enum.KeyCode.Z,
}


function Executor:HttpRequest(UrlTarget:string,INDEX:{unknown},cstome:string)
	cstome = cstome or "POST"
	if typeof(INDEX) == "table" then
		INDEX = game:GetService('HttpService'):JSONEncode(INDEX)
	end
	
	UrlTarget = tostring(UrlTarget)
	
	return Executor.HttpsRequestModule({
		Url = UrlTarget,
		Headers = {["Content-Type"] = "application/json"},
		Method = cstome,
		Body = INDEX,
	});
end

function Executor:ScreenClick(index:Vector2)
	index = index or Vector2.new(1000,1000)
	return VirtualUser:ClickButton1(index);
end

function Executor:KeyPress(index:Enum.KeyCode|number)
	if typeof(index) == "number" then
		index = converter2[index]
		if not index then
			return false
		end
	end
	
	local FoundKEY = false
	local Chcker = game:GetService('UserInputService').InputBegan:Connect(function(input)
		if input.KeyCode == index then
			FoundKEY = true
		end
	end)
	
	local _error = pcall(function()
		VirtualInputManager:SendKeyEvent(true, index, false, game)
		task.wait()
		VirtualInputManager:SendKeyEvent(false, index, false, game)
	end)
	
	if not FoundKEY then
		pcall(function()
			local cc = Converter[index]
			if cc then
				keypress(cc)
				task.wait()
				keyrelease(cc)
				FoundKEY = true
			end
		end)
		if not FoundKEY then
			print('Executor not support Keypress and VirtualInputManager')
		end
	end
	if Chcker then
		Chcker:Disconnect()
		Chcker = nil
	end
	
	return FoundKEY;
end

return Executor;
