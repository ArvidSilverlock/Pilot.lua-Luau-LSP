--!strict

local Types = require("../../modules/Types")

local Parse = {}

local function parseFunctionParameters(data, output, isPlainLuau: boolean?)
	for index, returnValue in data.Parameters do
		local stringForm = if returnValue.Name ~= "self" or isPlainLuau
			then Parse.parseParameterName(returnValue)
			else "self"

		table.insert(output, stringForm)
		if index < #data.Parameters then
			table.insert(output, ", ")
		end
	end
end

local function parseFunctionType(data: Types.FunctionData, name: string?, isPlainLuau: boolean?)
	local outputText = {
		(if not isPlainLuau and name then `function {name}` elseif isPlainLuau and name then `{name}: ` else ""),
		"(",
	}

	parseFunctionParameters(data, outputText, isPlainLuau)

	if isPlainLuau then
		table.insert(
			outputText,
			if #data.Returns > 1 then ") -> (" elseif #data.Returns > 0 then ") -> " else ") -> ()"
		)
	else
		table.insert(outputText, if #data.Returns > 1 then "): (" elseif #data.Returns > 0 then "): " else ")")
	end

	for _, returnValue in data.Returns do
		table.insert(outputText, returnValue.Type)
	end

	if #data.Returns > 1 then
		table.insert(outputText, ")")
	end

	return table.concat(outputText, "")
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

function Parse.parseDescribable<T>(value: Types.DescribableRaw, _output: T?): Types.Describable & T
	local output = (_output or {}) :: any

	output.Description = value.description
	output.Deprecated = if typeof(value.deprecated) == "string" then value.deprecated else value.deprecated == true
	output.CodeSample = value.codesample
	output.LearnMoreLink = value.learnmore

	return output :: any
end

function Parse.parseParameterName(parameter)
	return if parameter.Name then `{parameter.Name}: {parameter.Type}` else parameter.Type
end

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

function Parse.parseFunction(
	data: Types.FunctionObject,
	name: string?,
	within: string?,
	isPlainLuau: boolean?,
	isMethod: boolean?
)
	local output = Parse.parseDescribable(data, {
		Parameters = if within and isMethod then { { Name = "self", Type = within } } else {},
		Returns = {},
	}) :: any

	if data.unknowntype then
		table.insert(output.Parameters, { Name = "...", Type = "any" })
		table.insert(output.Returns, { Type = "...any" })
	else
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

	if data.generate then
		local generator = (require :: any)(`../../generators/types/{data.generate}.luau`)
		output.Type = generator("Function", name, data, within)
	else
		output.Type = {
			Definition = `{if not within then "declare " else ""}{parseFunctionType(output, name, isPlainLuau)}`,
			Luau = parseFunctionType(output, name, isPlainLuau),
		}
	end

	return output
end

return Parse
