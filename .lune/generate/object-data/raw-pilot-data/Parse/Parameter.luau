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

function Parameter.parse(value: string | { string }, isReturnValue: boolean?): Types.ParameterData
	local nameAndType: string, description: string?
	if typeof(value) == "table" then
		nameAndType, description = value[1], value[2]
	else
		nameAndType, description = value, nil
	end

	local parameterName, typeString = nameAndType:match("^([_%a][_%w]*):%s*(.+)$")
	if not parameterName and not typeString then
		parameterName, typeString = nameAndType:match("^(%.%.%.):%s*(.+)$")
	end

	return {
		Name = parameterName,
		Type = {
			Luau = if parameterName == "..."
					and typeString
					and isReturnValue
				then `...{typeString}`
				else typeString or nameAndType,
			Definition = nil,
			Unknown = false,
		},
		Description = description,
	}
end

return Parameter
