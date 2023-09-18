local data = {}

local HtpsRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request;

function data:Request(UrlTarget,BodyData)
	if typeof(BodyData) == "table" then
		BodyData = game:GetService('HttpService'):JSONEncode(BodyData)
	end
	return HtpsRequest({
		Url = UrlTarget,
		Headers = {["Content-Type"] = "application/json"},
		Method = "POST",
		Body = BodyData,
	})
end

function data:GetRequest()
	return HtpsRequest
end

return data;
