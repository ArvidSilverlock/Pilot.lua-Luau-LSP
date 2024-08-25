--!strict

local ParseEvent = require("../../object-data/raw-pilot-data/Parse/Event")
local Read = require("../../object-data/raw-pilot-data/ReadRaw")

local Types = require("../../modules/Types")

local function ImplementEvents(objectName: string, output: { [string]: Types.ObjectData })
	local object = Read.getObject(objectName)
	local rawData = object.data

	if not rawData.events then
		return
	end

	local outputData = output[objectName]

	for name, _data in rawData.events do
		local member, reference = ParseEvent.parse(name, _data, objectName)
		outputData.Events[name] = member
		outputData.Members[name] = reference
	end
end

return ImplementEvents
