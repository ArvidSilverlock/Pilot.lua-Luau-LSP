local ParseMiscellaneous = require("./Miscellaneous")
local ParseType = require("./Type")

local Utility = require("../../../modules/Utility")
local Types = require("../../../modules/Types")

local function stringify(value: any)
	if typeof(value) == "table" then
		return "[" .. table.concat(value, ", ") .. "]"
	else
		return tostring(value)
	end
end

local function generateWikiDescription(name: string, data: Types.PropertyData)
	local output = {}

	local wikiType = Utility.escapeMarkdown((data.Type.Luau:gsub("^Enum", "Enum.")))
	table.insert(output, `- *{wikiType}* {Utility.escapeMarkdown(name)}`)

	local description = ParseMiscellaneous.plainDescription(data, true)
	if description then
		table.insert(output, `  - {description}`)
	end

	if typeof(data.Deprecated) == "string" then
		table.insert(output, `  - {Utility.escapeMarkdown(data.Deprecated)}`)
	end

	local increment = if data.Step then ` (increments by {data.Step})` else ""

	if data.Minimum and data.Maximum then
		table.insert(output, `  - Range: {data.Minimum} to {data.Maximum}{increment}`)
	elseif data.Minimum then
		table.insert(output, `  - Minimum: {data.Minimum}{increment}`)
	elseif data.Maximum then
		table.insert(output, `  - Maximum: {data.Maximum}{increment}`)
	end

	if data.Default and not (typeof(data.Default) == "string" and #data.Default == 0) then
		table.insert(output, `  - Default: {Utility.escapeMarkdown(stringify(data.Default))}`)
	end

	if data.CodeSample then
		table.insert(output, "```lua\n" .. data.CodeSample .. "\n```")
	end

	return table.concat(output, "\n")
end

local Property = {}

function Property.parse(
	name: string,
	data: Types.PropertyObject,
	within: string
): (string, Types.PropertyData, Types.MemberData)
	local outputGroup = if data.readonly then "Properties" else "Configurables"

	local property = ParseMiscellaneous.describable(data)

	local memberReference = {
		Name = name,
		Group = outputGroup,
		Reference = property,
		Source = within,
	}

	local constraints = data.constraints
	if constraints then
		property.Minimum = constraints.min
		property.Maximum = constraints.max
		property.Step = constraints.step
		property.Default = constraints.default
	end

	property.Type = { Unknown = data.unknowntype == true }

	if data.unknowntype then
		property.Type.Luau = "any?"
		property.Type.Wiki = `- *undocumented* {name}`
	else
		property.Type.Luau = ParseType.parse(data.type)
		property.Type.Wiki = generateWikiDescription(name, property)
	end

	return outputGroup, property :: any, memberReference :: any
end

return Property
