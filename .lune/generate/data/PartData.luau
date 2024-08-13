local serde = require("@lune/serde")
local fs = require("@lune/fs")

local Types = require("../Types")

local yieldingThreads = {}
local cached: Types.ObjectData

return function(documentationFileType: ("json" | "yaml")?)
	if not documentationFileType and not cached then
		table.insert(yieldingThreads, coroutine.running())
		coroutine.yield()
	elseif documentationFileType then
		cached =
			serde.decode(documentationFileType, fs.readFile(`.lune/generate/documentation.{documentationFileType}`))

		for _, thread in yieldingThreads do
			coroutine.resume(thread)
		end
		table.clear(yieldingThreads)
	end

	return cached
end
