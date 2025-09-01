local luauTypes = require("../../../modules/LuauType")
local MarkdownSnippet = require("../../../modules/MarkdownSnippet")

local numberToOrdinalWord = require("../NumberToOrdinalWord")
local determineIndefiniteArticle = require("../DetermineIndefiniteArticle")
local sortedIterate = require("../SortedIterate")

local LuauTypeStrings = require("../LuauTypeStrings")

local function writeUnionType(output, context, base)
	if context.isString then
		if context.isOpenString then
			output:Push(" can be any string, some <i>example</i> possibilities include: ")
		else
			output:Push(" is a string that can be ")
		end
		for index, value in base.value do
			if index == #base.value then
				if #base.value > 2 then
					output:Push(", ")
				end
				output:Push(" or ")
			elseif index > 1 then
				output:Push(", ")
			end
			output:InlineCode(string.format("%q", value):sub(2, -2))
		end
	else
		output:Push(" can be any of the following types:\n"):BulletPointUp()
		for _, value in base.value do
			output:InlineCode(LuauTypeStrings.getMarkdownType(value)):NewLine()
		end
		output:BulletPointDown():Push("\n")
	end
end

local function writeTableType(output, context, base)
	local indexer, value = next(base.value)
	assert(indexer, "never")

	output
		:Push(" is a dictionary with keys that are ")
		:InlineCode(indexer[1])
		:Push("s and values that are ")
		:InlineCode(LuauTypeStrings.getMarkdownType(value))
		:Push("s.")
end

local function writeStandardType(output, context, base)
	if base.value == "any" then
		output:Push(" can be anything.")
	elseif context.isArray then
		output:Push(" is an array of ", determineIndefiniteArticle(base.value), " "):InlineCode(base.value):Push("s.")
	elseif context.isString then
		output:Push(" is the string "):InlineCode(base.value):Push(".")
	else
		output:Push(" is ", determineIndefiniteArticle(base.value), " "):InlineCode(base.value):Push(".")
	end
end

local function writeMapType(output, context, base)
	output:PushLine(" is a dictionary:")
	output:BulletPointUp()
	for key, value in sortedIterate(base.value) do
		local t = LuauTypeStrings.getMarkdownType(value)
		output:InlineCode(key):Push(" is ", determineIndefiniteArticle(t), " "):InlineCode(t):PushLine(".")
	end
	output:BulletPointDown()
end

local function writeParameters(
	output: MarkdownSnippet.MarkdownSnippet,
	objectName,
	memberName,
	parameters,
	groupName,
	groupNamePlural
)
	for parameterIndex, parameter in parameters do
		if #parameters == 1 then
			output:Push("\n\nThe ")
			if parameter.name == "..." then
				output:Push(`variadic {groupName}`)
			elseif parameter.name then
				output:Push(`<b>{parameter.name}</b> {groupName}`)
			else
				output:Push(`only {groupName}`)
			end
		else
			if parameterIndex == 1 then
				output:Push("\n\nThe ", groupNamePlural, " for "):InlineCode(memberName):PushLine(" are as follows:")
			end

			output:Push("- The ")
			if parameter.name == "..." then
				output:Push(`variadic {groupName}`)
			elseif parameter.name then
				output:Push(`<b>{parameter.name}</b> {groupName}`)
			else
				output:Push(`{numberToOrdinalWord(parameterIndex)} {groupName}`)
			end
		end

		local description = if typeof(parameter.documentation) == "table"
			then parameter.documentation.description
			else parameter.documentation
		if description then
			output:Push(" is ", description:gsub("^%u", string.lower):gsub("\n+", " "), " It")
		end

		local base = assert(
			luauTypes.getTypeState(parameter, {
				isRoot = true,
				name = parameter.name or "_" .. tostring(parameterIndex),
				context = "type",
				define = false,
			}),
			"no type state"
		).base
		local context = base.context

		if context.style == "union" then
			writeUnionType(output, context, base)
		elseif context.style == "type" and typeof(base.value) == "table" and typeof((next(base.value))) == "table" then
			writeTableType(output, context, base)
		elseif context.style == "type" and typeof(base.value) == "string" then
			writeStandardType(output, context, base)
		elseif context.style == "type" then
			writeMapType(output, context, base)
		elseif context.style == "function" then
			output:Push(" is a function of type "):InlineCode(LuauTypeStrings.getMarkdownType(parameter)):Push(".")
		else
			error(`{objectName}.{groupNamePlural}.{parameter.name or parameterIndex}`)
		end

		if context.isNullable then
			if output._lines[#output._lines]:sub(-1, -1) ~= "\n" then
				output:Push(" ")
			end
			output:Push("It can also be <code>nil</code>.")
		end

		output:Push("\n")

		-- output:Push(luauType)
	end
end

return writeParameters
