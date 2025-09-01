local luauTypes = require("../../../modules/LuauType")
local MarkdownSnippet = require("../../../modules/MarkdownSnippet")

local appendDocumentation = require("./AppendDocumentation")
local writeParameters = require("./Parameters")
local sortedIterate = require("../SortedIterate")
local urlEncode = require("../UrlEncode")

local writeIndividualTypeDescription

local function writeWithoutState(output, name, source: any, parent: luauTypes.State, depth, tableOfContents)
	local state = assert(luauTypes.getTypeState(source, parent), "no context found")
	writeIndividualTypeDescription(output, name, state, depth, tableOfContents)
end

local function writeDescription(output, documentation)
	if typeof(documentation) == "table" then
		if documentation.deprecated then
			output:AdmonitionStart("warning")
			output:Push("This method is deprecated.")
			if typeof(documentation.deprecated) == "string" then
				output:Push(" ", documentation.deprecated)
			end
			output:AdmonitionEnd()
		end

		if documentation.warning then
			output:AdmonitionStart("danger")
			if typeof(documentation.warning) == "string" then
				output:Push(" ", documentation.warning)
			else
				output:Push("This method may be dangerous.")
			end
			output:AdmonitionEnd()
		end

		if documentation.description then
			output:PushLine(documentation.description)
		end
	elseif typeof(documentation) == "string" then
		output:PushLine(documentation)
	end
end

local function writeStandardType(output, context, state, depth, tableOfContents)
	if typeof(state.base.value) == "table" then
		if context.isArray then
			output:PushLine("It is an array of dictionaries of the form:")
		end

		for memberName, memberValue in sortedIterate(state.base.value) do
			writeWithoutState(output, memberName, memberValue, state, depth + 1, tableOfContents)
		end
	elseif context.isString then
		output:Push("It is always ")
		if context.isArray then
			output:Push("an array of ")
		end
		output:Push("the string "):InlineCode(state.base.value):PushLine(".")
	else
		output:Push("It is ")
		if context.isArray then
			output:Push("an array whose values are ")
		end
		output:Push("of the type "):InlineCode(state.base.value):PushLine(".")
	end
end

local function writeFunctionType(output, source, name, state)
	local parameters = state.base.value.parameters
	local returns = state.base.value.returns

	if parameters and #parameters > 0 then
		writeParameters(output, source.name, name, parameters, "parameter", "parameters")
	else
		output:PushLine("\n\nIt has no parameters.")
	end

	if returns and #returns > 0 then
		writeParameters(output, source.name, name, returns, "return", "returns")
	else
		output:PushLine("\n\nIt has no return values.")
	end
end

local function writeStringUnionType(output, context, state)
	if context.isArray then
		output:Push("It is an array whose values ")
	else
		output:Push("It ")
	end
	if context.isOpenString then
		output:Push("can be any string, some "):Italic("example"):Push(" possibilities include: ")
	else
		output:Push("can be any of the following strings: ")
	end
	for index, memberValue in state.base.value do
		output:InlineCode(string.format("%q", memberValue))
		if index < #state.base.value then
			output:Push(", ")
		end
	end
	output:PushLine(".")
end

local function writeUnionType(output, context, state, depth, tableOfContents)
	if context.isString then
		writeStringUnionType(output, context, state)
		return
	end
	output:Push("It is ")
	if context.isArray then
		output:Push("an array whose values are all ")
	end
	output:PushLine("one (not all) of the following types:")
	for index, memberValue in state.base.value do
		writeWithoutState(output, `Subtype {string.char(64 + index)}`, memberValue, state, depth + 1, tableOfContents)
	end
end

local function writeIntersectionType(output, context, state, depth, tableOfContents)
	output:Push("It is ")
	if context.isArray then
		output:Push("an array whose values are all ")
	end
	output:PushLine("the combination of the following types:")
	for index, memberValue in state.base.value do
		writeWithoutState(output, `Subtype {string.char(64 + index)}`, memberValue, state, depth + 1, tableOfContents)
	end
end

function writeIndividualTypeDescription(
	output: MarkdownSnippet.MarkdownSnippet,
	key,
	state: luauTypes.State,
	depth,
	tableOfContents
)
	local context = state.base.context
	local source = state.source

	if context.style == "type" and state.base.value == "never" then
		return
	end

	local name = if typeof(key) == "table" then `[{key[1]}]` else key

	if depth > 1 then
		local headerText = if typeof(name) == "table" then `[{name[1]}]` else name

		if context.style == "function" then
			local parameterNames, returnNames = {}, {}

			if context.isMethod then
				table.insert(parameterNames, "self")
			end

			for index, parameter in state.base.value.parameters or {} do
				table.insert(parameterNames, parameter.name or `<i>{string.char(96 + index)}</i>`)
			end
			for index, value in state.base.value.returns or {} do
				table.insert(returnNames, value.name or `<i>{string.char(96 + index)}</i>`)
			end

			headerText ..= "(" .. table.concat(parameterNames, ", ") .. ")" .. (if #returnNames > 1
				then " → (" .. table.concat(returnNames, ", ") .. ")"
				elseif #returnNames > 0 then " → " .. returnNames[1]
				else "")
		end

		output
			:MemberHeader(
				name,
				headerText,
				if context.style == "function" then (if context.isMethod then "method" else "function") else "property"
			)
			:NewLine()

		table.insert(
			tableOfContents,
			`\{value: "{name .. if context.style == "function" then "()" else ""}", id: "{name}", "level": {depth}\}`
		)
	end

	writeDescription(output, source.documentation)
	appendDocumentation(output, source, nil, true)

	if context.style == "type" then
		writeStandardType(output, context, state, depth, tableOfContents)
	elseif context.style == "function" then
		writeFunctionType(output, source, name, state)
	elseif context.style == "union" then
		writeUnionType(output, context, state, depth, tableOfContents)
	elseif context.style == "intersection" then
		writeIntersectionType(output, context, state, depth, tableOfContents)
	else
		error(`Unknown context style: {context.style}`)
	end

	if context.isNullable then
		output:PushLine("It may also be <code>nil</code>.")
	end

	output:NewLine(2)
end

local function generateTypePage(key: string, value: any, parent, path: string, generatedPages: any, codeBlockLinks: any)
	local typeState = luauTypes.getTypeState(value, {
		isRoot = true,
		name = key,
		context = "type",
		define = true,
	})

	local encodedKey = urlEncode(key)
	if typeState then
		codeBlockLinks[key] = if path:match("[^/]+$") == encodedKey then path else `{path}/{urlEncode(key)}`

		local tableOfContents = {}

		local snippet = MarkdownSnippet.new()

		snippet:PushLine('\nimport Member from "@theme/Member";\n\n')

		writeIndividualTypeDescription(snippet, key, typeState, 1, tableOfContents)

		snippet:MemberHeader("Luau Type", "Luau Type", "group")
		table.insert(tableOfContents, '{value: "Luau Type", id: "Luau Type", "level": 2}')

		snippet
			:Push("This is the luau type for ")
			:InlineCode(key)
			:PushLine(
				". It may help clear up mistranslations from the raw data to the wiki page (as it is an automatic process)."
			)
			:CodeStart()

		luauTypes.writeFromState(snippet, typeState)

		snippet:CodeEnd():PushLine("\n\n")

		if #tableOfContents > 0 then
			snippet:Insert(1, `\nexport const toc = [{table.concat(tableOfContents, ",")}]\n\n`)
		end

		generatedPages[key] = tostring(snippet)
	else
		generatedPages[key] = {}
		for childName, child in value do
			generateTypePage(childName, child, parent, `{path}/{encodedKey}`, generatedPages[key], codeBlockLinks)
		end
	end
end

return generateTypePage
