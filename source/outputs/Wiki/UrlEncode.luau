-- Not actually real URL encoding, but this seems to work for docusaurus links, at least for the limited subset of symbols in the link names.
local function urlEncode(url: string)
	return url:gsub(" ", "%%20")
end

return urlEncode
