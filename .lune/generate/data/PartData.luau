local serde = require("@lune/serde")
local fs = require("@lune/fs")

local Types = require("../Types")

-- OH MY GOD _G

return function(): Types.ObjectData
	if _G.cached == nil then
		_G.cached = serde.decode("json", fs.readFile(".lune/generate/documentation.json"))
	end

	return _G.cached
end
