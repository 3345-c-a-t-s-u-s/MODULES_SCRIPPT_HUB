local FileSave = {}
local MainInfo = {}
local HttpsService = game:GetService('HttpService')

function FileSave:SetupData(info)
	MainInfo = info
end

function FileSave:CreateFile(__Name__)
	local jsonName = "data_location.txt"
	if not isfolder(__Name__) then
		makefolder(__Name__)
	end

	wait()

	if isfolder(__Name__) then
		local path = tostring(__Name__).."/"..tostring(jsonName)

		if isfile(path) then
			delfile(path)
		end

		writefile(path,tostring(HttpsService:JSONEncode(MainInfo)))
	end
end

function FileSave:LoadFile(__name__)
	local jsonName = "data_location.txt"
	local Path = tostring(__name__).."/"..tostring(jsonName)
	if isfile(Path) then
		local stringF = readfile(Path)
		if stringF then
			local Ecode = HttpsService:JSONDecode(stringF)
			return Ecode
		end
	end
	return nil
end


local function ImageMain(__Name__,Url,imgname,filetype)
	filetype = filetype or "jpg"
	filetype = filetype:upper()
	imgname = imgname or "Image_"..tostring(__Name__)
	imgname = imgname..tostring('.')..tostring(filetype)

	local ImgPath = tostring(__Name__)..tostring("/")..tostring(imgname)

	if not isfile(ImgPath) then
		writefile(ImgPath,game:HttpGet(tostring(Url)))
	end

	if isfile(ImgPath) then
		local asset = getcustomasset(ImgPath)
		return asset
	end

	return nil
end

function FileSave:CheckFile(__name__)
	local jsonName = "data_location.txt"
	local Path = tostring(__name__).."/"..tostring(jsonName)
	if isfolder(__name__) then
		if isfile(Path) then
			return true
		end
	end
	return false
end

function FileSave:LoadImageFromUrl(__Name__,Url,imgname,filetype)
	local screened = Instance.new('ScreenGui',game:FindFirstChild('CoreGui')) screened.Enabled = true
	local Png = Instance.new('ImageLabel',screened) Png.Size = UDim2.new(0.1,0,0,0.1) Png.Name = "png"
	local Jpg = Instance.new('ImageLabel',screened) Jpg.Size = UDim2.new(0.1,0,0,0.1) Jpg.Name = "jpg"
	local Jpeg = Instance.new('ImageLabel',screened) Jpeg.Size = UDim2.new(0.1,0,0,0.1) Jpeg.Name = "jpeg"

	local FolderForImage = "ImageCollection"
	local ImC = __Name__..tostring('/')..tostring(FolderForImage)

	makefolder(ImC)

	repeat task.wait()

		local PngId = ImageMain(ImC,Url,imgname,'PNG')
		local JpgId = ImageMain(ImC,Url,imgname,'JPG')
		local JpegId = ImageMain(ImC,Url,imgname,'JPEG')

		Png.Image = PngId
		Jpg.Image = JpgId
		Jpeg.Image = JpegId

	until Png.IsLoaded or Jpg.IsLoaded or Jpeg.IsLoaded
	local a = {Png,Jpg,Jpeg}
	local main 

	for _,v in ipairs(a) do
		if v.IsLoaded then
			main = v
			break
		end
	end

	if main then
		coroutine.wrap(function()
			wait(0.5)
			screened:Destroy()
		end)()
		return main.Image
	end
end

return FileSave
