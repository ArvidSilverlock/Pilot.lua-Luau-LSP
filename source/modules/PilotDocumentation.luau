local fs = require("@lune/fs")
local serde = require("@lune/serde")

local luauTypes = require("../modules/LuauType")

local documentation = serde.decode("yaml", fs.readFile("documentation/documentation.yaml")) :: any

documentation.configurations = {}

for className, class in documentation.classes do
	local hydrator = class.hydrator
	if typeof(hydrator) == "table" then
		if hydrator.configurables then
			local configurationTypeName = className .. "Configuration"
			documentation.configurations[configurationTypeName] = {
				documentation = `The configuration of the <code>{className}</code> object.`,
				type = { [{ "string" }] = { type = "any" } }, -- yeah, i know
			}

			for configurable, configurableData in hydrator.configurables do
				documentation.configurations[configurationTypeName].type[configurable] =
					luauTypes.setNullable(configurableData, true)
			end
		end
	end
end

return documentation
