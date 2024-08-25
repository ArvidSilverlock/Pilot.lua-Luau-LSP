local Types = require("../../../modules/Types")

local Parameter = {}

function Parameter.typedName(parameter: Types.ParameterData): string
	return if parameter.Name then `{parameter.Name}: {parameter.Type.Luau}` else parameter.Type.Luau
end

function Parameter.invertedTypedName(parameter: Types.ParameterData): string
	return if parameter.Name == "..."
		then `*...{parameter.Type.Luau}*`
		elseif parameter.Name then `*{parameter.Type.Luau}* {parameter.Name}`
		else parameter.Type.Luau
end

function Parameter.parse(value: string | { string }): Types.ParameterData
	local nameAndType: string, description: string?
	if typeof(value) == "table" then
		nameAndType, description = value[1], value[2]
	else
		nameAndType, description = value, nil
	end

	local parameterName, typeString = nameAndType:match("^([_%a][_%w]*):%s*(.+)$")

	return {
		Name = parameterName,
		Type = {
			Luau = typeString or nameAndType,
			Definition = nil,
			Unknown = false,
		},
		Description = description,
	}
end

return Parameter
