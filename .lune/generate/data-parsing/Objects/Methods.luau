--!strict

local ParseFunction = require("../../object-data/raw-pilot-data/Parse/Function")
local Read = require("../../object-data/raw-pilot-data/ReadRaw")

local Types = require("../../modules/Types")

local function ImplementMethods(objectName: string, output: { [string]: Types.ObjectData })
	local object = Read.getObject(objectName)
	local objectData = object.data

	if not objectData.methods then
		return
	end

	local objectOutput = output[objectName]

	for name, data in objectData.methods do
		local method = ParseFunction.parse(data, name, objectName, true)

		local memberReference = {
			Name = name,
			Group = "Methods",
			Reference = method,
			Source = objectName,
		}

		objectOutput.Members[name] = memberReference :: any
		objectOutput.Methods[name] = method
	end
end

return ImplementMethods
