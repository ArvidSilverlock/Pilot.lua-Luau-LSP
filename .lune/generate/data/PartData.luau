local serde = require("@lune/serde")
local fs = require("@lune/fs")

local Types = require("../Types")

local yieldingThreads = {}

-- OH MY GOD _G

return function(documentationFileType: ("json" | "yaml")?): Types.ObjectData
	if documentationFileType == nil and _G.cached == nil then
		table.insert(yieldingThreads, coroutine.running())
		coroutine.yield()
	elseif documentationFileType then
		_G.cached =
			serde.decode(documentationFileType, fs.readFile(`.lune/generate/documentation.{documentationFileType}`))

		for _, thread in yieldingThreads do
			coroutine.resume(thread)
		end
		table.clear(yieldingThreads)
	end

	return _G.cached
end
