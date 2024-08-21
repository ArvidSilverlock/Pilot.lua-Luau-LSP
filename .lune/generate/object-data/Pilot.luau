local Types = require("../Modules/Types")

-- Forced module caching. _G usage...
if _G._pilotData then
	return (_G._pilotData :: any) :: Types.PilotData
end

local process = require("@lune/process")
local stdio = require("@lune/stdio")
local fs = require("@lune/fs")

local rawData = require("./PilotRaw")

local data = {
	raw = rawData,
}

local function runParser(name)
	local path = if fs.isDir(`.lune/generate/data-parsing/{name}`)
		then `../data-parsing/{name}/init.luau`
		else `../data-parsing/{name}.luau`

	local parser = require(path)
	parser.parse(rawData, data)
end

for _, parser in
	{
		"Objects",
	}
do
	runParser(parser)
end

_G._pilotData = data

return (data :: any) :: Types.PilotData
