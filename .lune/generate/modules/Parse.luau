--!strict

local PilotData = require("./PilotData")
local Types = require("./Types")

local Parse = {}

function Parse.parseParameter(value: string | { string })
	local nameAndType: string, description: string?
	if typeof(value) == "table" then
		nameAndType, description = value[1], value[2]
	else
		nameAndType, description = value, nil
	end

	local parameterName, typeString = nameAndType:match("^([_%a][_%w]*):%s*(.+)$")

	return {
		Name = parameterName,
		Type = typeString or nameAndType,
		Description = description,
	}
end

function Parse.iterateParentClasses(objectName: string)
	local object = PilotData.getObject(objectName)
	local data = object.data

	local extends = if data.extends == nil and object.category == "objects"
		then { "PilotObject" }
		elseif typeof(data.extends) == "string" then { data.extends }
		elseif typeof(data.extends) == "table" then data.extends
		else {}

	return next, extends, nil
end

function Parse.parseDescribable(value: Types.Describable, output: { [string]: any }?)
	if output then
		output.Description = value.description
		output.IsDeprecated = value.deprecated == true
		output.CodeSample = value.codesample
		output.LearnMoreLink = value.learnmore
		return output
	else
		return {
			Description = value.description,
			IsDeprecated = value.deprecated == true,
			CodeSample = value.codesample,
			LearnMoreLink = value.learnmore,
		}
	end
end

function Parse.parseType(input: any)
	if typeof(input) == "table" then
		if
			#input > 0
			and typeof(input[1]) == "string"
			and (input[1]:match("^and%??$") or input[1]:match("^or%??$"))
		then
			local operation = input[1]
			local output = {}

			for index = 2, #input do
				table.insert(output, Parse.parseType(input[index]))
			end

			local concatenation = table.concat(output, if operation:match("^and") then " & " else " | ")
			return if operation:sub(-1, -1) == "?" then `({concatenation})?` else concatenation
		elseif typeof((next(input))) == "string" then
			local output = {}

			for key, value in input do
				local formattedKey = if key:match("^[_%a][_%w]*$") then key else `[{string.format("%q", key)}]`
				table.insert(output, `{formattedKey}: {Parse.parseType(value)}`)
			end

			return `\{ {table.concat(output, ", ")} }`
		else
			local output = {}
			for _, string: string in input :: any do
				table.insert(output, string.format("%q", string))
			end
			return table.concat(output, " | ")
		end
	else
		return input
	end
end

function Parse.parseFunction(data: Types.FunctionObject, within: string?)
	local output = Parse.parseDescribable(data, {
		Parameters = if within then { { Name = "self", Type = within } } else {},
		Returns = {},
	})

	if data.parameters then
		for _, parameter in data.parameters do
			table.insert(output.Parameters, Parse.parseParameter(parameter))
		end
	end

	if data.returns then
		for _, returnValue in data.returns do
			table.insert(output.Returns, Parse.parseParameter(returnValue))
		end
	end
end

return Parse
