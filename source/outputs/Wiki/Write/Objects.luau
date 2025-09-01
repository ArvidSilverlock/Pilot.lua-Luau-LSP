local fs = require("@lune/fs")
local serde = require("@lune/serde")

local MarkdownSnippet = require("../../../modules/MarkdownSnippet")

local LuauTypeStrings = require("../LuauTypeStrings")
local escapeMarkdown = require("../EscapeMarkdown")
local determineIndefiniteArticle = require("../DetermineIndefiniteArticle")
local sortedIterate = require("../SortedIterate")
local urlEncode = require("../UrlEncode")

local CodeSamples = require("./CodeSamples")
local writeParameters = require("./Parameters")
local appendDocumentation = require("./AppendDocumentation")

local function writeGroupHeader(output, tableOfContents, header: string)
	output:MemberHeader(header)
	table.insert(tableOfContents, `\{value: "{header}", id: "{header}", "level": 2\}`)
end

local function writeMemberHeader(
	output,
	tableOfContents,
	header: string,
	group: "method" | "event" | "configurable" | "property",
	id: string,
	isDeprecated: boolean?
)
	output:MemberHeader(id, header, group)

	local tableOfContentsHeader = id .. if group == "method" then "()" else ""
	if isDeprecated then
		tableOfContentsHeader = "<del>" .. tableOfContentsHeader .. "</del>"
	end

	table.insert(tableOfContents, `\{value: "{tableOfContentsHeader}", id: "{id}", "level": 3\}`)
end

local function documentMethod(output, tableOfContents, objectName, methodData, methodName, isDeprecated)
	local parameterNames = {}
	for index, parameter in methodData.parameters or {} do
		table.insert(parameterNames, parameter.name or `<i>{string.char(96 + index)}</i>`)
	end

	local returnNames = {}
	for index, value in methodData.returns or {} do
		table.insert(returnNames, value.name or `<i>{string.char(96 + index)}</i>`)
	end

	writeMemberHeader(
		output,
		tableOfContents,
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
		methodName,
		isDeprecated
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
		writeParameters(output, objectName, methodName, methodData.parameters, "parameter", "parameters")
	end

	if methodData.returns then
		writeParameters(output, objectName, methodName, methodData.returns, "return", "returns")
	end

	CodeSamples.addCodeSamples(output, methodData)
end

local function documentOverloadedMethod(output, tableOfContents, objectName, methodData, methodName, isDeprecated)
	writeMemberHeader(
		output,
		tableOfContents,
		(if isDeprecated then "<del><i>" else "") .. methodName .. (if isDeprecated then "</i></del>" else ""),
		"method",
		methodName,
		isDeprecated
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
		for parameterIndex, parameter in overload.parameters or {} do
			table.insert(parameterNames, parameter.name or `<i>{string.char(96 + parameterIndex)}</i>`)
		end

		local returnNames = {}
		for returnIndex, value in overload.returns or {} do
			table.insert(returnNames, value.name or `<i>{string.char(96 + returnIndex)}</i>`)
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
			writeParameters(output, objectName, methodName, overload.parameters, "parameter", "parameters")
		end

		if overload.returns then
			writeParameters(output, objectName, methodName, overload.returns, "return", "returns")
		end

		CodeSamples.addCodeSamples(output, methodData)
	end
end

local function documentMethods(output, tableOfContents, methods, objectName)
	writeGroupHeader(output, tableOfContents, "Methods")
	for methodName, methodData in sortedIterate(methods, true) do
		local isDeprecated = if typeof(methodData.documentation) == "table"
			then methodData.documentation.deprecated
			else false

		local document = if methodData.overloads then documentOverloadedMethod else documentMethod
		document(output, tableOfContents, objectName, methodData, methodName, isDeprecated)
	end
end

local function documentConfigurables(output, tableOfContents, configurables, readonly)
	writeGroupHeader(output, tableOfContents, if readonly then "Properties" else "Configurables")

	for configurableName, configurableData in sortedIterate(configurables, true) do
		writeMemberHeader(output, tableOfContents, configurableName, "configurable", configurableName)

		local configurableDocs = configurableData.documentation
		local typeString = LuauTypeStrings.getType(configurableData) or "unknown"
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
				output:Push("\nIt ranges between ", configurableDocs.range[1], " and ", configurableDocs.range[2], ".")
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

		CodeSamples.addCodeSamples(output, configurableData)
	end
end

local function documentEvents(output, tableOfContents, events, objectName)
	writeGroupHeader(output, tableOfContents, "Events")
	for eventName, eventData in sortedIterate(events, true) do
		local parameterNames = {}
		for index, parameter in eventData.parameters or {} do
			table.insert(parameterNames, parameter.name or `<i>{string.char(96 + index)}</i>`)
		end

		local header = eventName .. if #parameterNames > 0 then `({table.concat(parameterNames, ", ")})` else ""
		writeMemberHeader(output, tableOfContents, header, "event", eventName)

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
		CodeSamples.addCodeSamples(output, eventData)
	end
end

local function handleHydrator(output, objectName, tableOfContents, metadata, hydrator)
	local isProgrammable = false
	local isConfigurable = false

	if hydrator.methods and next(hydrator.methods) then
		isProgrammable = true
		documentMethods(output, tableOfContents, hydrator.methods)
	end

	if hydrator.configurables and next(hydrator.configurables) then
		isConfigurable = true
		documentConfigurables(output, tableOfContents, hydrator.configurables, false)
	end

	if hydrator.properties and next(hydrator.properties) then
		documentConfigurables(output, tableOfContents, hydrator.properties, true)
	end

	if hydrator.events and next(hydrator.events) then
		local events = hydrator.events

		local badEvents = { "Configured", "Damaged", "Loop", "OnClick", "Triggered" }
		for event, _ in events do
			if not table.find(badEvents, event) then
				isProgrammable = true
			end
		end

		documentEvents(output, tableOfContents, events, objectName)
	end

	table.insert(metadata.tags, if isProgrammable then "Programmable" else "Non-Programmable")
	table.insert(metadata.tags, if isConfigurable then "Configurable" else "Non-Configurable")
end

local function documentObject(objectName: string, object: any, codeBlockLinks)
	if not object.hydrator then
		return
	end

	codeBlockLinks[objectName] = `/objects/{urlEncode(objectName)}`

	objectName = object.hydrator["class-name"] or objectName

	local output = MarkdownSnippet.new(objectName)
	local metadata: any = {}

	local tableOfContents = {}

	if objectName == "PilotObject" then
		metadata.sidebar_position = 1
	end

	local imageExists = fs.isFile(`./wiki/static/part-images/{objectName}.png`)
	local imageLink = if imageExists then `/Pilot.lua-Luau-LSP/part-images/{objectName}.png` else nil

	appendDocumentation(output, object, metadata, false, objectName, imageLink)

	if not metadata.tags then
		metadata.tags = {}
	end

	if typeof(object.hydrator) == "table" then
		handleHydrator(output, objectName, tableOfContents, metadata, object.hydrator)
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

	return tostring(output)
end

return documentObject
