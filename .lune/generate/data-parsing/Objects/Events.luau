local PilotData = require("../../modules/PilotData")
local Parse = require("../../modules/Parse")

local PILOT_DATA = require("../../object-data/PilotRaw")
local EVENT_TEMPLATE_CACHE = {}

local function ImplementEvents(objectName, output)
	local object = PilotData.getObject(objectName)
	local objectData = object.data

	if not objectData.events then
		return
	end

	local objectOutput = output[objectName]

	for name, _data in objectData.events do
		if _data == true and EVENT_TEMPLATE_CACHE[name] then
			table.insert(objectOutput.Events, EVENT_TEMPLATE_CACHE[name])
		else
			local data = if _data == true then PILOT_DATA.events[name] else _data

			local event = Parse.parseDescribable(data, {
				Parameters = {},
				IsDeprecated = data.deprecated == true,
			})

			local memberReference = {
				Name = name,
				Group = "Events",
				Reference = event,
				Source = objectName,
			}

			if data.parameters then
				for _, parameter in data.parameters do
					table.insert(event.Parameters, Parse.parseParameter(parameter))
				end
			end

			objectOutput.Members[name] = memberReference
			objectOutput.Events[name] = event

			if _data == true then
				EVENT_TEMPLATE_CACHE[name] = event
			end
		end
	end
end

return ImplementEvents
