local fs = require("@lune/fs")
local serde = require("@lune/serde")

local luauTypes = require("../modules/LuauType")
local Snippet = require("../modules/Snippet")
local MarkdownSnippet = require("../modules/MarkdownSnippet")

local partDocumentation = serde.decode("yaml", fs.readFile("./.lune/generate/documentation.yaml")) :: any
local rawPartData = serde.decode("json", fs.readFile("./.lune/generate/partdata.json")) :: any

local WIKI_DIRECTORY = "./wiki/docs/"

local function getType(value)
	local output = Snippet.new()
	luauTypes.write(output, value, { isRoot = true, context = "type", define = false } :: any)
	return tostring(output)
end

local function sortedIterate<T>(dictionary: { [string]: T }, deprioritizeDeprecated: boolean?): () -> (string, T)
	local primary, secondary = {}, {}
	for key, value in dictionary do
		if deprioritizeDeprecated and value.documentation and value.documentation.deprecated then
			table.insert(secondary, key)
		else
			table.insert(primary, key)
		end
	end

	table.sort(primary)
	if deprioritizeDeprecated then
		table.sort(secondary)
	end

	local index = 0
	return function()
		index += 1
		local key = primary[index] or secondary[index - #primary]
		return key, dictionary[key]
	end
end

-- Hardcoded indefinite articles for all uses. This is to avoid non-phonetic spellings messing with the articles.
local indefiniteArticles = {
	arcursor = "an",
	blade = "a",
	boolean = "a",
	canvas = "a",
	cframe = "a",
	color = "a",
	component = "a",
	coordinates = "a",
	coupler = "a",
	cursor = "a",
	enum = "an",
	folder = "a",
	frame = "a",
	handle = "a",
	instance = "an",
	instrument = "an",
	microcontroller = "a",
	modem = "a",
	number = "a",
	object = "an",
	one = "a", -- not used anywhere, but included just in case
	part = "a",
	permission = "a",
	pilot = "a",
	player = "a",
	polysilicon = "a",
	region = "a",
	relay = "a",
	remote = "a",
	resource = "a",
	scanner = "a",
	sound = "a",
	string = "a",
	user = "a",
	vector = "a",
	vehicle = "a",
	world = "a",
}

local function determineIndefiniteArticle(str)
	local firstWord = (str:match("^%u*%l*") or str):lower()
	local indefiniteArticle = indefiniteArticles[firstWord]

	-- Guess the indefinite article based on the first letter, not reliable ('an umbrella' vs 'a uniform').
	if not indefiniteArticle then
		warn(`No guarantee the used indefinite article of '{firstWord}' is correct.`)
		return if table.find({ "a", "e", "i", "o" }, str:sub(1, 1):lower()) then "an" else "a"
	end

	return indefiniteArticle
end

local function numberToOrdinalWord(number)
	-- stylua: ignore start
	local UNITS = { "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth" }
	local TEENS = { "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "eighteenth", "nineteenth" }
	local TENS = { "tenth", "twentieth", "thirtieth", "fortieth", "fiftieth", "sixtieth", "seventieth", "eightieth", "ninetieth" }
	local TENS_PREFIX = { "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" }
	-- stylua: ignore end

	assert(number < 1 or number > 99, "number must be between 1 and 99")

	if number <= 9 then
		return UNITS[number]
	elseif number == 10 then
		return TENS[1]
	elseif number >= 11 and number <= 19 then
		return TEENS[number - 10]
	elseif number % 10 == 0 then
		return TENS[number / 10]
	else
		return TENS_PREFIX[number // 10] .. "-" .. UNITS[number % 10]
	end
end

local function escapeMarkdown(text)
	local markdownCharacters = [[\`*_{}[%]()#+-.!|<>]]
	return (text:gsub("([" .. markdownCharacters .. "])", "\\%1"))
end

local function getMarkdownType(value)
	return escapeMarkdown(getType(value):gsub("\n\t*", " "):gsub(", }", " }"))
end

local function formatSize(x, y, z)
	return (string.format("%.2fx%.2fx%.2f", x, y, z):gsub("%.00", ""):gsub("(%.%d)0*", "%1"))
end

local function findPossibleSizes(malleability)
	local sizes = {}

	for i = 1, math.min(math.sqrt(malleability), 2048) do
		if malleability % i == 0 then
			local remaining = malleability / i
			for j = i, math.min(math.sqrt(remaining), 2048) do
				if remaining % j == 0 then
					local k = remaining / j

					local order = { i, j, k }
					table.sort(order)

					local formatted = formatSize(unpack(order))
					if k <= 2048 and not table.find(sizes, formatted) then
						table.insert(sizes, formatted)
					end
				end
			end
		end
	end

	return sizes
end

local function writeParameters(output, objectName, memberName, parameters, groupName, groupNamePlural)
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
				for index, value in base.value do
					output:InlineCode(getMarkdownType(value)):NewLine()
				end
				output:BulletPointDown():Push("\n")
			end
		elseif context.style == "type" and typeof(base.value) == "table" and typeof((next(base.value))) == "table" then
			local indexer, value = next(base.value)

			output
				:Push(" is a dictionary with keys that are")
				:InlineCode(indexer[1])
				:Push("s and values that are ")
				:InlineCode(getMarkdownType(value))
				:Push("s.")
		elseif context.style == "type" and typeof(base.value) == "string" then
			if base.value == "any" then
				output:Push(" can be anything.")
			elseif context.isArray then
				output
					:Push(" is an array of ", determineIndefiniteArticle(base.value), " ")
					:InlineCode(base.value)
					:Push("s.")
			elseif context.isString then
				output:Push(" is the string "):InlineCode(base.value):Push(".")
			else
				output:Push(" is ", determineIndefiniteArticle(base.value), " "):InlineCode(base.value):Push(".")
			end
		elseif context.style == "type" then
			output:PushLine(" is a dictionary:")
			output:BulletPointUp()
			for key, value in sortedIterate(base.value) do
				local t = getMarkdownType(value)
				output:InlineCode(key):Push(" is ", determineIndefiniteArticle(t), " "):InlineCode(t):PushLine(".")
			end
			output:BulletPointDown()
		elseif context.style == "function" then
			output:Push(" is a function of type "):InlineCode(getMarkdownType(parameter)):Push(".")
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

local function addCodeSamples(output, data)
	if typeof(data.documentation) == "table" then
		local codeSamples = data.documentation["code-samples"] or {}
		if data.documentation["code-sample"] then
			table.insert(codeSamples, 1, data.documentation["code-sample"])
		end

		for _, codeSample in codeSamples do
			output:Push("\n```lua\n")
			output:Push(codeSample)
			output:Push("\n```")
		end
	end
end

local function appendDocumentation(output, object, metadata, dontWriteDescription)
	if typeof(object.documentation) == "string" then
		if not dontWriteDescription then
			output:PushLine(object.documentation)
		end
		return
	elseif typeof(object.documentation) ~= "table" then
		return
	end

	local documentation = object.documentation

	if typeof(documentation) == "table" then
		if documentation.description and not dontWriteDescription then
			output:Push(documentation.description)
		end

		local incrementSuffix = if documentation.increment
			then ", and an increment of " .. documentation.increment
			else ""
		if documentation.minimum then
			output:Push("\nIt has a minimum value of ", documentation.minimum, incrementSuffix, ".")
		elseif documentation.maximum then
			output:Push("\nIt has a maximum value of ", documentation.maximum, incrementSuffix, ".")
		elseif documentation.range then
			output:Push("\nIt ranges between ", documentation.range[1], " and ", documentation.range[2], ".")
			if documentation.increment then
				output:Push(" It increments by ", documentation.increment, ".")
			end
		elseif documentation.increment then
			output:Push("\nIt increments by ", documentation.increment, ".")
		end
	elseif documentation and not dontWriteDescription then
		output:Push(documentation)
	end

	if documentation.length then
		output:PushLine("It will always have a length of ", documentation.length, ".\n")
	elseif documentation["max-length"] then
		output:PushLine("It has a maximum length of ", documentation["max-length"], ".\n")
	end

	if metadata then
		metadata.tags = if documentation.categories then table.clone(documentation.categories) else {}
	end

	addCodeSamples(output, object)
end

local writeWithoutState, writeIndividualTypeDescription

function writeWithoutState(output, name, source: any, parent: luauTypes.State, depth)
	local state = assert(luauTypes.getTypeState(source, parent), "no context found")
	writeIndividualTypeDescription(output, name, state, depth)
end

function writeIndividualTypeDescription(output, name, state: luauTypes.State, depth)
	local context = state.base.context
	local source = state.source

	if context.style == "type" and state.base.value == "never" then
		return
	end

	output:PushLine(string.rep("#", depth), " ", name):NewLine()

	local documentation = source.documentation
	if typeof(documentation) == "table" and documentation.description then
		output:PushLine(documentation.description)
	elseif typeof(documentation) == "string" then
		output:PushLine(documentation)
	end

	if context.style == "type" then
		if typeof(state.base.value) == "table" then
			if context.isArray then
				output:PushLine("It is an array of dictionaries of the form:")
			end

			for memberName, memberValue in sortedIterate(state.base.value) do
				writeWithoutState(output, memberName, memberValue, state, depth + 1)
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
	elseif context.style == "function" then
		output:PushLine("It is a function, read the 'Luau Type' to learn its parameters and returns.")
	elseif context.style == "method" then
		output:PushLine("It is a method, read the 'Luau Type' to learn its parameters and returns.")
	elseif context.style == "union" then
		if context.isString then
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
				output:InlineCode(memberValue)
				if index < #state.base.value then
					output:Push(", ")
				end
			end
			output:PushLine(".")
		else
			output:Push("It is ")
			if context.isArray then
				output:Push("an array whose values are all ")
			end
			output:PushLine("one (not all) of the following types:")
			for index, memberValue in state.base.value do
				writeWithoutState(output, `Subtype {string.char(64 + index)}`, memberValue, state, depth + 1)
			end
		end
	elseif context.style == "intersection" then
		output:Push("It is ")
		if context.isArray then
			output:Push("an array whose values are all ")
		end
		output:PushLine("the combination of the following types:")
		for index, memberValue in state.base.value do
			writeWithoutState(output, `Subtype {string.char(64 + index)}`, memberValue, state, depth + 1)
		end
	else
		error(`Unknown context style: {context.style}`)
	end

	if context.isNullable then
		output:PushLine("It may also be <code>nil</code>.")
	end

	appendDocumentation(output, source, nil, true)

	output:NewLine(2)
end

local function generateTypePage(key: string, value: any, parent, path: string, generatedPages)
	local typeState = luauTypes.getTypeState(value, {
		isRoot = true,
		name = key,
		context = "type",
		define = true,
	})

	if typeState then
		local snippet = MarkdownSnippet.new()

		snippet:PushLine('\nimport Member from "@theme/Member";\n\n')

		writeIndividualTypeDescription(snippet, key, typeState, 1)

		snippet
			:MemberHeader("Luau Type", "Luau Type", "group")
			:Push("This is the luau type for ")
			:InlineCode(key)
			:PushLine(
				". It may help clear up mistranslations from the raw data to the wiki page (as it is an automatic process)."
			)
			:CodeStart()

		luauTypes.writeFromState(snippet, typeState)

		snippet:NewLine():CodeEnd():PushLine("\n\n")

		generatedPages[key] = tostring(snippet)
	else
		generatedPages[key] = {}
		for childName, child in value do
			generateTypePage(childName, child, parent, `{path}/{key}`, generatedPages[key])
		end
	end
end

local Wiki = {}

function Wiki.generate(options)
	local generatedPages = {
		objects = {},
		types = {},
	}

	generateTypePage("types", partDocumentation.types, nil, "types", generatedPages)

	for objectName, object in partDocumentation.classes do
		if not object.hydrator then
			continue
		end

		objectName = object.hydrator["class-name"] or objectName

		local output = MarkdownSnippet.new(objectName)
		local metadata: any = {}

		local tableOfContents = {}

		local function writeGroupHeader(header: string)
			output:MemberHeader(header)
			table.insert(tableOfContents, `\{value: "{header}", id: "{header}", "level": 2\}`)
		end

		local function writeMemberHeader(
			header: string,
			group: "method" | "event" | "configurable" | "property",
			id: string
		)
			output:MemberHeader(id, header, group)
			table.insert(
				tableOfContents,
				`\{value: "{id .. if group == "method" then "()" else ""}", id: "{id}", "level": 3\}`
			)
		end

		if objectName == "PilotObject" then
			metadata.sidebar_position = 1
		end

		appendDocumentation(output, object, metadata)

		if not metadata.tags then
			metadata.tags = {}
		end

		local rawData = rawPartData.Parts[objectName]
		if rawData then
			output:Push("\n")

			output:Push(
				`It is a{if rawData.Craftable and rawData.Spawnable
					then " craftable and spawnable"
					elseif rawData.Craftable then " craftable"
					elseif rawData.Spawnable then " spawnable"
					else ""} {if rawData.Flammable then "flammable" else "non-flammable"} {if rawData.ClassState
					then rawData.ClassState:lower()
					else "object"}.\n\n`
			)

			if rawData.Malleability == 0 then
				output:Push(`It cannot be resized.\n\n`)
			elseif rawData.Malleability then
				local sizes = findPossibleSizes(rawData.Malleability)
				if #sizes > 0 then
					output:Push(
						`Here is a list of possible sizes that reach the maximum malleability ({rawData.Malleability}) that have integer components: `
					)
					output:Push(table.concat(sizes, ", "))
					output:Push("\n\n")
				else
					output:Push(
						"It has a malleability of ",
						rawData.Malleability,
						". You cannot reach this size with only integer components.\n\n"
					)
				end
			end

			local defaultSize = formatSize(unpack(rawData.BaseSize))

			if rawData.BaseDurability == "inf" then
				output:Push("It has infinite durability and a default size of ", defaultSize, ".\n\n")
			elseif rawData.BaseDurability then
				local baseVolume = rawData.BaseSize[1] * rawData.BaseSize[2] * rawData.BaseSize[3]
				output:Push("At its default size (", defaultSize, ") it has a durability of ", rawData.BaseDurability)

				if rawData.Malleability and rawData.Malleability > 0 then
					output:Push(
						", at its maximum size it has a durability of ",
						math.floor((rawData.Malleability / baseVolume) ^ (1 / 3) * rawData.BaseDurability + 1)
					)
				end

				output:Push(".\n\n")
			elseif rawData.BaseSize then
				output:PushLine("It has a default size of ", defaultSize, ".\n\n")
			end

			if rawData.Color then
				local hex = string.format("%02x%02x%02x", unpack(rawData.Color))
				output:PushLine(
					"By default, its colour is <span style={{color: '#{",
					hex:upper(),
					"'}}>#",
					hex,
					"</span>.\n"
				)
			end

			if rawData.Recipe then
				local recipe = { "It requires " }
				for key, value in sortedIterate(rawData.Recipe) do
					table.insert(recipe, `{value} <code>{key}</code>`)
					if #recipe > 1 then
						table.insert(recipe, ", ")
					end
				end

				if #recipe > 3 then
					recipe[#recipe - 2] = if #recipe == 5 then " and " else ", and "
					recipe[#recipe] = " "
				end
				table.insert(recipe, "to be crafted.")

				output:Push(table.concat(recipe) .. "\n\n")
			end
		end

		if typeof(object.hydrator) == "table" then
			local isProgrammable = false
			local isConfigurable = false

			if object.hydrator.methods and next(object.hydrator.methods) then
				isProgrammable = true

				local methods = object.hydrator.methods
				writeGroupHeader("Methods")
				for methodName, methodData in sortedIterate(methods, true) do
					local isDeprecated = if typeof(methodData.documentation) == "table"
						then methodData.documentation.deprecated
						else false

					if methodData.overloads then
						local parameterNames = {}
						for index, parameter in methodData.parameters or {} do
							table.insert(parameterNames, parameter.name or `<i>{string.char(96 + index)}</i>`)
						end

						local returnNames = {}
						for index, value in methodData.returns or {} do
							table.insert(returnNames, value.name or `<i>{string.char(96 + index)}</i>`)
						end

						writeMemberHeader(
							(if isDeprecated then "<del><i>" else "")
								.. methodName
								.. (if isDeprecated then "</i></del>" else ""),
							"method",
							methodName
						)

						if isDeprecated then
							output:Push("\n:::warning\n\n")
							output:Push("This method is deprecated.")
							if typeof(isDeprecated) == "string" then
								output:Push(" " .. isDeprecated)
							end
							output:Push("\n\n:::\n\n")
						end

						if typeof(methodData.documentation) == "table" then
							if methodData.documentation.description then
								output:Push(methodData.documentation.description)
							end
						elseif methodData.documentation then
							output:Push(methodData.documentation)
						end

						for index, overload in methodData.overloads do
							local parameterNames = {}
							for index, parameter in overload.parameters or {} do
								table.insert(parameterNames, parameter.name or `<i>{string.char(96 + index)}</i>`)
							end

							local returnNames = {}
							for index, value in overload.returns or {} do
								table.insert(returnNames, value.name or `<i>{string.char(96 + index)}</i>`)
							end

							output:Push(
								"\n\n#### Overload ",
								string.char(64 + index),
								" – (",
								table.concat(parameterNames, ", "),
								")",
								if #returnNames > 1
									then " → (" .. table.concat(returnNames, ", ") .. ")"
									elseif #returnNames > 0 then " → " .. returnNames[1]
									else "",
								"\n"
							)

							if typeof(overload.documentation) == "table" then
								if overload.documentation.description then
									output:Push(overload.documentation.description)
								end
							elseif overload.documentation then
								output:Push(overload.documentation)
							end

							if overload.parameters then
								writeParameters(
									output,
									objectName,
									methodName,
									overload.parameters,
									"parameter",
									"parameters"
								)
							end

							if overload.returns then
								writeParameters(output, objectName, methodName, overload.returns, "return", "returns")
							end

							addCodeSamples(output, methodData)
						end
					else
						local parameterNames = {}
						for index, parameter in methodData.parameters or {} do
							if not parameter.name then
								print(`{objectName}.{methodName}.parameters.{index}`)
							end
							table.insert(parameterNames, parameter.name or `<i>{string.char(96 + index)}</i>`)
						end

						local returnNames = {}
						for index, value in methodData.returns or {} do
							if not value.name then
								print(`{objectName}.{methodName}.returns.{index}`)
							end
							table.insert(returnNames, value.name or `<i>{string.char(96 + index)}</i>`)
						end

						writeMemberHeader(
							(if isDeprecated then "<del><i>" else "")
								.. methodName
								.. "("
								.. table.concat(parameterNames, ", ")
								.. ")"
								.. (if #returnNames > 1
									then " → (" .. table.concat(returnNames, ", ") .. ")"
									elseif #returnNames > 0 then " → " .. returnNames[1]
									else "")
								.. (if isDeprecated then "</i></del>" else ""),
							"method",
							methodName
						)

						if isDeprecated then
							output:AdmonitionStart("warning")
							output:Push("This method is deprecated.")
							if typeof(isDeprecated) == "string" then
								output:Push(" " .. isDeprecated)
							end
							output:AdmonitionEnd()
						end

						if typeof(methodData.documentation) == "table" then
							if methodData.documentation.description then
								output:Push(methodData.documentation.description)
							end
						elseif methodData.documentation then
							output:Push(methodData.documentation)
						end

						if methodData.parameters then
							writeParameters(
								output,
								objectName,
								methodName,
								methodData.parameters,
								"parameter",
								"parameters"
							)
						end

						if methodData.returns then
							writeParameters(output, objectName, methodName, methodData.returns, "return", "returns")
						end

						addCodeSamples(output, methodData)
					end
				end
			end

			if object.hydrator.configurables and next(object.hydrator.configurables) then
				isConfigurable = true

				local configurables = object.hydrator.configurables
				writeGroupHeader("Configurables")
				for configurableName, configurableData in sortedIterate(configurables, true) do
					writeMemberHeader(configurableName, "configurable", configurableName)

					local configurableDocs = configurableData.documentation
					local typeString = getType(configurableData) or "unknown"
					local configurableType =
						`It is {determineIndefiniteArticle(typeString)} <code>{escapeMarkdown(typeString)}</code>.`

					if typeof(configurableDocs) == "table" then
						if configurableDocs.description then
							output:Push(configurableDocs.description)
							output:Push(" " .. configurableType)
						else
							output:Push(configurableType)
						end

						local incrementSuffix = if configurableDocs.increment
							then ", and an increment of " .. configurableDocs.increment
							else ""
						if configurableDocs.minimum then
							output:Push("\nIt has a minimum value of ", configurableDocs.minimum, incrementSuffix, ".")
						elseif configurableDocs.maximum then
							output:Push("\nIt has a maximum value of ", configurableDocs.maximum, incrementSuffix, ".")
						elseif configurableDocs.range then
							output:Push(
								"\nIt ranges between ",
								configurableDocs.range[1],
								" and ",
								configurableDocs.range[2],
								"."
							)
							if configurableDocs.increment then
								output:Push(" It increments by ", configurableDocs.increment, ".")
							end
						elseif configurableDocs.increment then
							output:Push("\nIt increments by ", configurableDocs.increment, ".")
						end
					elseif configurableDocs then
						output:Push(configurableDocs, " ", configurableType)
					else
						output:Push(configurableType)
					end

					addCodeSamples(output, configurableData)
				end
			end

			if object.hydrator.properties and next(object.hydrator.properties) then
				local properties = object.hydrator.properties
				writeGroupHeader("Properties")
				for propertyName, propertyData in sortedIterate(properties, true) do
					writeMemberHeader(propertyName, "property", propertyName)

					local configurableDocs = propertyData.documentation
					local typeString = getType(propertyData) or "unknown"
					local configurableType =
						`It is {determineIndefiniteArticle(typeString)} <code>{escapeMarkdown(typeString)}</code>.`

					if typeof(configurableDocs) == "table" then
						if configurableDocs.description then
							output:Push(configurableDocs.description, " ", configurableType)
						else
							output:Push(configurableType)
						end

						local incrementSuffix = if configurableDocs.increment
							then ", and an increment of " .. configurableDocs.increment
							else ""
						if configurableDocs.minimum then
							output:Push("\nIt has a minimum value of ", configurableDocs.minimum, incrementSuffix, ".")
						elseif configurableDocs.maximum then
							output:Push("\nIt has a maximum value of ", configurableDocs.maximum, incrementSuffix, ".")
						elseif configurableDocs.range then
							output:Push(
								"\nIt ranges between ",
								configurableDocs.range[1],
								" and ",
								configurableDocs.range[2],
								"."
							)
						elseif configurableDocs.increment then
							output:Push("\nIt increments by ", configurableDocs.increment, ".")
						end
					elseif configurableDocs then
						output:Push(configurableDocs, " ", configurableType)
					else
						output:Push(configurableType)
					end

					addCodeSamples(output, propertyData)
				end
			end

			if object.hydrator.events and next(object.hydrator.events) then
				local events = object.hydrator.events

				local badEvents = { "Configured", "Damaged", "Loop", "OnClick", "Triggered" }
				for event, _ in events do
					if not table.find(badEvents, event) then
						isProgrammable = true
					end
				end
				writeGroupHeader("Events")
				for eventName, eventData in sortedIterate(events, true) do
					local parameterNames = {}
					for index, parameter in eventData.parameters or {} do
						table.insert(parameterNames, parameter.name or `<i>{string.char(96 + index)}</i>`)
					end

					local header = eventName
						.. if #parameterNames > 0 then `({table.concat(parameterNames, ", ")})` else ""
					writeMemberHeader(header, "event", eventName)

					if typeof(eventData.documentation) == "table" then
						if eventData.documentation.description then
							output:Push("\n" .. eventData.documentation.description)
						end
					elseif eventData.documentation then
						output:Push("\n" .. eventData.documentation)
					end

					if eventData.parameters then
						writeParameters(output, objectName, eventName, eventData.parameters, "parameter", "parameters")
					end
					addCodeSamples(output, eventData)
				end
			end

			table.insert(metadata.tags, if isProgrammable then "Programmable" else "Non-Programmable")
			table.insert(metadata.tags, if isConfigurable then "Configurable" else "Non-Configurable")
		else
			table.insert(metadata.tags, "Non-Programmable")
			table.insert(metadata.tags, "Non-Configurable")
		end

		if #tableOfContents > 0 then
			output:Insert(1, `\nexport const toc = [{table.concat(tableOfContents, ",")}]\n\n`)
			output:Insert(1, '\nimport Member from "@theme/Member";\n\n')
		end

		if next(metadata) then
			output:Insert(1, `---\n{serde.encode("yaml", metadata)}---\n`)
		end

		local text = tostring(output)

		for match in text:gmatch("<code>(.-)</code>") do
			if partDocumentation.classes[match] then
				text = text:gsub(
					"<code>" .. match .. "</code>",
					`<code><a href="/Pilot.lua-Luau-LSP/objects/{match}">{match}</a></code>`,
					1
				)
			end
		end

		generatedPages.objects[objectName] = text

		-- print(table.concat(output))
	end

	return generatedPages
end

local function recursiveWrite(pages, path)
	if not fs.isDir(path) then
		fs.writeDir(path)
	end

	for name, value in pages do
		if typeof(value) == "table" then
			local subpath = `{path}/{name}`

			-- if fs.isDir(subpath) then
			-- 	fs.removeDir(subpath)
			-- end
			fs.writeDir(subpath)

			recursiveWrite(value, subpath)
		else
			fs.writeFile(`{path}/{name}.mdx`, value)
		end
	end
end

function Wiki.save(options, generatedPages)
	recursiveWrite(generatedPages.objects, `{WIKI_DIRECTORY}/objects`)
	recursiveWrite(generatedPages.types, `{WIKI_DIRECTORY}/types`)

	local rawDocumentation = fs.readFile("./.lune/generate/documentation.yaml")
	local rawDocumentationSnippet = MarkdownSnippet.new(rawDocumentation)

	rawDocumentationSnippet
		:PushLine("Use Ctrl+F, or ⌘+F on Mac to search for information you need.")
		:NewLine()
		:PushLine("```yaml")
		:PushLine(rawDocumentation)
		:PushLine("```")

	fs.writeFile("./wiki/docs/raw-documentation.md", tostring(rawDocumentationSnippet))
end

return Wiki
