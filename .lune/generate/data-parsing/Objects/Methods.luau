local PilotData = require("../../modules/PilotData")
local Parse = require("../../modules/Parse")

local function ImplementMethods(objectName, output)
	local object = PilotData.getObject(objectName)
	local objectData = object.data

	if not objectData.methods then
		return
	end

	local objectOutput = output[objectName]

	for name, data in objectData.methods do
		local method = Parse.parseFunction(data, objectName)

		local memberReference = {
			Name = name,
			Group = "Methods",
			Reference = method,
			Source = objectName,
		}

		objectOutput.Members[name] = memberReference
		objectOutput.Methods[name] = method
	end
end

return ImplementMethods
