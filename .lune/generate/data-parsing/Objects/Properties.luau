--!strict

local ParseProperty = require("../../object-data/raw-pilot-data/Parse/Property")
local Read = require("../../object-data/raw-pilot-data/ReadRaw")

local Types = require("../../modules/Types")

local function ImplementProperties(objectName: string, output: { [string]: Types.ObjectData })
	local object = Read.getObject(objectName)
	local objectData = object.data

	if not objectData.properties then
		return
	end

	local outputData = output[objectName]

	for name, data in objectData.properties do
		local group, member, reference = ParseProperty.parse(name, data, objectName);
		(outputData :: any)[group][name], outputData.Members[name] = member, reference
	end
end

return ImplementProperties
