local KeyEnumToSeting =  {
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

local VsKeeyToEnum = {
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

local a = {}

function a:ConvertToVs(k:Enum.KeyCode)
	if KeyEnumToSeting[k] then
		return KeyEnumToSeting[k]
	end
	return 0
end

function a:ConvertToEnum(k:Enum.KeyCode)
	if VsKeeyToEnum[k] then
		return VsKeeyToEnum[k]
	end
	return Enum.KeyCode.One
end

return a
