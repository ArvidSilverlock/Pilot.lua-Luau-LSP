local Types = require("../Modules/Types")

-- Forced module caching. _G usage...
if _G._pilotData then
	return (_G._pilotData :: any) :: Types.PilotData
end

local fs = require("@lune/fs")

local PILOT_DATA = require("../object-data/raw-pilot-data/Data")

local data = {
	Raw = PILOT_DATA,
}

local function runParser(name)
	local path = if fs.isDir(`.lune/generate/data-parsing/{name}`)
		then `../data-parsing/{name}/init.luau`
		else `../data-parsing/{name}.luau`

	local parser = require(path)
	parser.parse(PILOT_DATA, data)
end

for _, parser in
	{
		"GlobalFunctions",
		"GlobalValues",
		"Types",
		"Objects",
	}
do
	runParser(parser)
end

_G._pilotData = data

return (data :: any) :: Types.PilotData
