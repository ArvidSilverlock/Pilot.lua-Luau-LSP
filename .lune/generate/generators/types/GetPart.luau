local Utility = require("../../modules/Utility")
local Types = require("../../modules/Types")

local PILOT_DATA = require("../../object-data/raw-pilot-data/RawData")

local BASE_TYPES = {
	GetPart = "type _GetPart<T, U> = (object: T) -> U?",
	GetPartFromPort = "type _GetPartFromPort<T, U> = (port: (number | Port)?, object: T) -> U?",
	GetParts = "type _GetParts<T, U> = (object: T) -> { U }",
	GetPartsFromPort = "type _GetPartsFromPort<T, U> = (port: (number | Port)?, object: T) -> { U }",
}

return function(valueType: "Function", name: string, data: Types.FunctionData, within: string?)
	assert(valueType == "Function", `the 'GetPart' generator only works for 'Function's, got '{valueType}'`)
	assert(BASE_TYPES[name], `the 'GetPart' generator only works for the 4 part getting functions`)
	assert(within == nil, "the 'GetPart' generator does not work for methods")

	local lines = {}

	local index = 1
	for objectName, _ in PILOT_DATA.classes.objects do
		local className = string.format("%q", objectName)
		local typeName = Utility.sanitiseName(objectName)
		table.insert(lines, `\t{if index == 1 then " " else "&"} _{name}<{className}, {typeName}>`)
		index += 1
	end
	table.insert(lines, `\t& _{name}<string?, PilotObject>`)

	local overloads = table.concat(lines, "\n")
	local definitionType = `declare {name}:\n{overloads}`
	local luauType = `local {name} = ( nil :: any ) :: \n{overloads}`

	return {
		Definition = definitionType,
		Luau = luauType,
		InsertDefinition = function(output: Types.DefinitionOutput)
			table.insert(output.LocalTypes, BASE_TYPES[name])
		end,
		InsertVanilla = function(output: Types.DefinitionOutput)
			table.insert(output.LocalTypes, BASE_TYPES[name])
		end,
	}
end
