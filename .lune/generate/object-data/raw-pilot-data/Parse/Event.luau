local PILOT_DATA = require("../RawData")
local ParseParameter = require("./Parameter")
local ParseMiscellaneous = require("./Miscellaneous")

local Types = require("../../../modules/Types")

local EVENT_TEMPLATE_CACHE: {
	[string]: { Member: Types.EventData, Reference: Types.MemberData },
} = {}

local function generateWikiDescription(name: string, data: Types.FunctionData)
	if data.Type.Unknown then
		return `- *undocumented* {name}`
	end

	local output = {}

	local parameters = {}
	for index, parameter in data.Parameters do
		table.insert(parameters, ParseParameter.invertedTypedName(parameter))
	end

	table.insert(output, `- {name}({table.concat(parameters, ", ")})`)

	local description = ParseMiscellaneous.plainDescription(data, true)
	if description then
		table.insert(output, `  - {description}`)
	end

	return table.concat(output, "\n")
end

local Event = {}

function Event.parse(
	name: string,
	_data: Types.EventObject | boolean,
	within: string
): (Types.EventData, Types.MemberData)
	if _data == true and EVENT_TEMPLATE_CACHE[name] then
		local cached = EVENT_TEMPLATE_CACHE[name]

		local duplicatedReference = table.clone(cached.Reference)
		duplicatedReference.Source = within

		return cached.Member, duplicatedReference
	end

	local data = if _data == true then PILOT_DATA.events[name] else _data
	if _data == true and not data then
		error(`expected to find an event template called {name}`)
	end

	local event: any = ParseMiscellaneous.describable(data, {
		Parameters = {},
		Deprecated = not not data.deprecated,
	})

	local memberReference = {
		Name = name,
		Group = "Events",
		Reference = event,
		Source = within,
	}

	if data.unknowntype then
		event.Type = { Unknown = true }
		table.insert(event.Parameters, {
			Type = { Luau = "...any", Unknown = true },
		})
	else
		event.Type = { Unknown = false }
	end

	if data.parameters then
		for _, parameter in data.parameters do
			table.insert(event.Parameters, ParseParameter.parse(parameter))
		end
	end

	if #event.Parameters == 0 then
		event.Type.Luau = `{name}: Event<{string.format("%q", name)}>`
	else
		local namedParameters, parameterTypes = {}, {}
		for index, parameter in event.Parameters do
			table.insert(namedParameters, ParseParameter.typedName(parameter))
			table.insert(parameterTypes, parameter.Type.Luau)
		end

		local eventName = string.format("%q", name)
		local names = table.concat(namedParameters, ", ")
		local types = table.concat(parameterTypes, ", ")

		event.Type.Luau = `{name}: Event<{eventName}, ({names}) -> (), {types}>`
	end

	event.Type.Wiki = generateWikiDescription(name, event)

	if _data == true then
		event.IsTemplate = true
		EVENT_TEMPLATE_CACHE[name] = { Member = event, Reference = memberReference }
	else
		event.IsTemplate = false
	end

	return event, memberReference
end

return Event
