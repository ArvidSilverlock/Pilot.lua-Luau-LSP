local Utility = require("../../modules/Utility")

local PILOT_DATA = require("../../object-data/PilotRaw")

local BASE_TYPES = {
	GetPart = "type _GetPart<T, U> = (object: T) -> U?",
	GetPartFromPort = "type _GetPartFromPort<T, U> = (port: (number | Port)?, object: T) -> U?",
	GetParts = "type _GetParts<T, U> = (object: T) -> { U }",
	GetPartsFromPort = "type _GetPartsFromPort<T, U> = (port: (number | Port)?, object: T) -> { U }",
}

return function(valueType: "Function", options)
	assert(valueType == "Function", `the 'partgetters' generator only works for 'Function's, got '{valueType}'`)
	assert(BASE_TYPES[options.name], `the 'partgetters' generator only works for the 4 part getting functions`)

	local output = options.output

	local lines = { `declare {options.name}:` }

	local index = 1
	for objectName, _ in PILOT_DATA.classes.objects do
		local className = string.format("%q", objectName)
		local typeName = Utility.sanitiseName(objectName)
		table.insert(lines, `\t{if index == 1 then " " else "&"} _{options.name}<{className}, {typeName}>`)
		index += 1
	end
	table.insert(lines, `\t& _{options.name}<string?, PilotObject>`)

	if output.generatedTypes.partGetters then
		table.insert(output.generatedTypes.partGetters, BASE_TYPES[options.name])
	else
		output.generatedTypes.partGetters = { BASE_TYPES[options.name] }
	end

	return table.concat(lines, "\n")
end
