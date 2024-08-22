--!strict

local Parse = require("../object-data/raw-pilot-data/ParseRaw")
local Types = require("../modules/Types")

local function parseType(input: Types.RawPilotData, output: Types.PilotData, typeName: string, isGlobal: boolean)
	local group = if isGlobal then "Global" else "Local"
	local typeValue = if isGlobal then input.globals.types[typeName] else input.types[typeName]

	local typeObject = {
		Type = Parse.parseType(typeValue),
	}

	local reference = {
		Name = typeName,
		Group = group,
		Reference = typeObject,
	}

	output.Types[group][typeName] = typeObject
	output.Types.References[typeName] = reference
end

local LuauTypes = {}

function LuauTypes.parse(input: Types.RawPilotData, output: Types.PilotData)
	output.Types = {
		Global = {} :: any,
		Local = {} :: any,
		References = {} :: any,
	}

	for typeName, _ in input.globals.types do
		parseType(input, output, typeName, true)
	end

	for typeName, _ in input.types do
		parseType(input, output, typeName, false)
	end
end

return LuauTypes
