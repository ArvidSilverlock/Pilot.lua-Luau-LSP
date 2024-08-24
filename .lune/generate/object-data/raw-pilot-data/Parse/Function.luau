local Utility = require("../../../modules/Utility")
local Types = require("../../../modules/Types")

local ParseMiscellaneous = require("./Miscellaneous")
local ParseParameter = require("./Parameter")

local Function = {}

local function parseFunctionType(data: Types.FunctionData, name: string?, isPlainLuau: boolean?)
	local output = {
		if not name then "" elseif isPlainLuau then `{name}: ` else `function {name}`,
		"(",
	}

	for index, parameterValue in data.Parameters do
		local stringForm = if parameterValue.Name ~= "self" or isPlainLuau
			then ParseParameter.typedName(parameterValue)
			else "self"

		table.insert(output, stringForm)
		if index < #data.Parameters then
			table.insert(output, ", ")
		end
	end

	if isPlainLuau then
		table.insert(output, if #data.Returns > 1 then ") -> (" elseif #data.Returns > 0 then ") -> " else ") -> ()")
	else
		table.insert(output, if #data.Returns > 1 then "): (" elseif #data.Returns > 0 then "): " else ")")
	end

	for index, returnValue in data.Returns do
		table.insert(output, returnValue.Type.Luau)
		if index < #data.Parameters then
			table.insert(output, ", ")
		end
	end

	if #data.Returns > 1 then
		table.insert(output, ")")
	end

	return table.concat(output)
end

local function generateWikiType(name: string, data: Types.FunctionData)
	if data.Type.Unknown then
		return `*undocumented* {name}`
	end

	local output = { `{name}(` }

	for index: number, parameterValue in data.Parameters do
		if parameterValue.Name == "self" then
			continue
		end

		local stringForm = ParseParameter.invertedTypedName(parameterValue)

		table.insert(output, Utility.escapeMarkdown(stringForm))
		if index < #data.Parameters then
			table.insert(output, ", ")
		end
	end

	table.insert(output, if #data.Returns > 1 then ") → (" elseif #data.Returns > 0 then ") → " else ")")

	for index, returnValue in data.Returns do
		table.insert(output, Utility.escapeMarkdown(`*{returnValue.Type.Luau}*`))
		if index < #data.Parameters then
			table.insert(output, ", ")
		end
	end

	if #data.Returns > 1 then
		table.insert(output, ")")
	end

	return table.concat(output)
end

local function generateWikiDescription(name: string, data: Types.FunctionData)
	local output = {}

	table.insert(output, `- {generateWikiType(name, data)}`)

	local description = ParseMiscellaneous.plainDescription(data, true)
	if description then
		table.insert(output, `  - {description}`)
	end

	return table.concat(output, "\n")
end

function Function.parse(
	data: Types.FunctionObject,
	name: string?,
	within: string?,
	isPlainLuau: boolean?,
	isMethod: boolean?
)
	local output = ParseMiscellaneous.describable(data, {
		Parameters = if within and isMethod then { { Name = "self", Type = within } } else {},
		Returns = {},
	}) :: any

	if data.unknowntype then
		table.insert(output.Parameters, { Name = "...", Type = { Luau = "any", Unknown = true } })
		table.insert(output.Returns, { Type = { Luau = "...any", Unknown = true } })
	else
		if data.parameters then
			for _, parameter in data.parameters do
				table.insert(output.Parameters, ParseParameter.parse(parameter))
			end
		end

		if data.returns then
			for _, returnValue in data.returns do
				table.insert(output.Returns, ParseParameter.parse(returnValue))
			end
		end
	end

	if data.generate then
		local generator = (require :: any)(`../../../generators/types/{data.generate}.luau`)
		output.Type = generator("Function", name, data, within)
	else
		output.Type = { Unknown = data.unknowntype == true }

		local functionType = parseFunctionType(output, name, isPlainLuau)
		output.Type.Definition = `{if not within then "declare " else ""}{functionType}`
		output.Type.Luau = functionType

		if name then
			output.Type.Wiki = generateWikiDescription(name, output)
		end
	end

	return output
end

return Function
