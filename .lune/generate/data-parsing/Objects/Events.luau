--!strict

local Parse = require("../../object-data/raw-pilot-data/ParseRaw")
local Read = require("../../object-data/raw-pilot-data/ReadRaw")
local PILOT_DATA = require("../../object-data/raw-pilot-data/RawData")

local EVENT_TEMPLATE_CACHE = {}

local function ImplementEvents(objectName, output)
	local object = Read.getObject(objectName)
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

			local event: any = Parse.parseDescribable(data, {
				Parameters = {},
				Deprecated = data.deprecated == true,
			})

			local memberReference = {
				Name = name,
				Group = "Events",
				Reference = event,
				Source = objectName,
			}

			if data.unknowntype then
				table.insert(event.Parameters, { Type = "...any" })
			elseif data.parameters then
				for _, parameter in data.parameters do
					table.insert(event.Parameters, Parse.parseParameter(parameter))
				end
			end

			if #event.Parameters == 0 then
				event.Type = `{name}: Event<{string.format("%q", name)}>`
			else
				local namedParameters, parameterTypes = {}, {}
				for index, returnValue in event.Parameters do
					table.insert(namedParameters, Parse.parseParameterName(returnValue))
					table.insert(parameterTypes, returnValue.Type)
				end

				local eventName = string.format("%q", name)
				local names = table.concat(namedParameters, ", ")
				local types = table.concat(parameterTypes, ", ")

				event.Type = `{name}: Event<{eventName}, ({names}) -> (), {types}>`
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
