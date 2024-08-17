--!strict

local serde = require("@lune/serde")
local fs = require("@lune/fs")

local Utility = require("./Utility")
local Parse = require("./Parse")
local Types = require("./Types")

local markdownDocumentation = {}

local function markdownWriter(options: Types.ObjectOptions, content, output)
	local object = Parse.getObject("object", options)

	local function initialiseMarkdownSection(key: string, normal: { string }?, deprecated: { string }?)
		local text = if normal
				and #normal > 0
				and deprecated
				and #deprecated > 0
			then table.concat(normal, "\n") .. "\n" .. Utility.markdownDropdown(
				`Deprecated {key:gsub("^%l", string.upper)}`,
				table.concat(deprecated, "\n")
			)
			elseif normal and #normal > 0 then table.concat(normal, "\n")
			elseif deprecated and #deprecated > 0 then table.concat(deprecated, "\n")
			else nil

		if text then
			content[key] = { { class = options.name, content = text } }
		end
	end

	local function applyInheritence()
		local extends = if typeof(object.extends) == "string" then { object.extends } else object.extends

		if extends and #extends > 0 then
			for _, class in extends do
				if class == "PilotObject" then
					continue
				end

				local markdown: any = markdownDocumentation[class]
				for key, values in markdown do
					for _, value in values do
						if content[key] then
							table.insert(content[key], value)
						else
							content[key] = { value }
						end
					end
				end
			end
		end
	end

	local function writeMarkdownSection(sectionName: string)
		local section = content[sectionName]
		if not section then
			return
		end

		local markdownSection = {}
		for index, value in section do
			table.insert(
				markdownSection,
				if value.class == options.name
					then value.content
					else Utility.markdownDropdown(
						`Inherited from [{value.class}](/docs/Objects/{value.class})`,
						value.content
					)
			)
		end

		table.insert(output, `### {sectionName:gsub("^%l", string.upper)}\n{table.concat(markdownSection, "\n\n")}`)
	end

	return initialiseMarkdownSection, applyInheritence, writeMarkdownSection
end

local function getEscapedDescription(object: Types.Describable): string?
	local description = Parse.constructPlainDescription(object)
	return if description then Utility.escapeMarkdown(description) else nil
end

local function getMethods(object: Types.Object, undocumented): ({ string }?, { string }?)
	if not object.methods then
		return nil, nil
	end

	local methods, deprecatedMethods = {}, {}

	for name, data in object.methods do
		local description = getEscapedDescription(data)

		if data.unknowntype then
			table.insert(undocumented, `- function **{name}** {if description then ` - {description}` else ""}`)
		else
			local formatted
			if data.generate then
				formatted = data.wikitype or `function **{name}**(*self*, ...: any): ...any`
			else
				local functionType = { "(*self*" }

				if data.parameters and #data.parameters > 0 then
					for index, parameter in data.parameters do
						local nameAndType = if typeof(parameter) == "string" then parameter else parameter[1]

						table.insert(functionType, ", ")
						table.insert(functionType, nameAndType)
					end
				end

				if data.returns and #data.returns > 0 then
					table.insert(functionType, ") → ")
					if #data.returns > 1 then
						table.insert(functionType, "(")
					end

					for index, parameter in data.returns do
						local luauType = if typeof(parameter) == "string" then parameter else parameter[1]

						table.insert(functionType, luauType)
						if index < #data.returns then
							table.insert(functionType, ", ")
						end
					end

					if #data.returns > 1 then
						table.insert(functionType, ")")
					end
				else
					table.insert(functionType, ")")
				end

				formatted = `function **{name}**{table.concat(functionType)}`
			end

			table.insert(
				if data.deprecated then deprecatedMethods else methods,
				Utility.escapeMarkdown(
					`- {formatted}{if description then `\n  - {description}` else ""}{if typeof(data.deprecated) == "string" then `\n  - {data.deprecated}` else ""}`
				)
			)
		end
	end

	return methods, deprecatedMethods
end

local function getProperties(object: Types.Object, undocumented): ({ { string }? }, { { string }? })
	if not object.properties then
		return { nil, nil }, { nil, nil }
	end

	local configurables, deprecatedConfigurables = {}, {}
	local properties, deprecatedProperties = {}, {}

	for name, data in object.properties do
		local description = getEscapedDescription(data)

		if data.unknowntype then
			table.insert(
				undocumented,
				`{if data.readonly then "property" else "configurable"} **{name}**{if description then ` - {description}` else ""}`
			)
		else
			local luauType = if data.unknowntype then "any" else Parse.parseLuauType(data.type)
			local outputTable = {
				`- **{name}:** *{luauType}*{if description then ` - {description}` else ""}`,
			}

			local constraints = data.constraints
			if constraints then
				if constraints.min and constraints.max then
					table.insert(outputTable, `  - **Range:** {constraints.min} to {constraints.max}`)
				elseif constraints.min then
					table.insert(outputTable, `  - **Minimum:** {constraints.min}`)
				elseif constraints.max then
					table.insert(outputTable, `  - **Maximum:** {constraints.max}`)
				end

				if constraints.default then
					table.insert(outputTable, `  - **Default:** {constraints.default}`)
				end
			end

			if typeof(data.deprecated) == "string" then
				table.insert(outputTable, `  - {data.deprecated}`)
			end

			table.insert(
				if not data.readonly
					then (if data.deprecated then deprecatedConfigurables else configurables)
					else (if data.deprecated then deprecatedProperties else properties),
				table.concat(outputTable, "\n")
			)
		end
	end

	return { configurables, deprecatedConfigurables }, { properties, deprecatedProperties }
end

local function getEvents(object: Types.Object, undocumented): ({ string }?, { string }?)
	if not object.events then
		return nil, nil
	end

	local events, deprecatedEvents = {}, {}

	for name, data in object.events do
		local eventObject = Parse.getObject("Event", { name = name, object = data })
		local description = getEscapedDescription(eventObject)

		if eventObject.unknowntype then
			table.insert(undocumented, `- **event {name}** {if description then ` - {description}` else ""}`)
		else
			local formatted
			if eventObject.parameters then
				local parameters = {}
				for _, parameter in eventObject.parameters do
					local parameterName = if typeof(parameter) == "table" then parameter[1] else parameter
					table.insert(parameters, parameterName)
				end
				formatted = Utility.escapeMarkdown(`**{name}:** ({table.concat(parameters, ", ")})`)
			else
				formatted = Utility.escapeMarkdown(`**{name}**`)
			end

			table.insert(
				if eventObject.deprecated then deprecatedEvents else events,
				`- {formatted}{if description then `\n  - {description}` else ""}{if typeof(object.deprecated) == "string" then `\n  - {object.deprecated}` else ""}`
			)
		end
	end

	return events, deprecatedEvents
end

local function generateWikiPage(options: Types.ObjectOptions)
	local object = Parse.getObject("object", options)

	local markdownPath = `wiki/docs/Objects/{options.name}.md`
	local markdownMetadata = {}

	markdownMetadata.tags = if object.categories then table.clone(object.categories) else {}
	table.insert(
		markdownMetadata.tags,
		if options.type == "abstract"
			then "AbstractClass"
			elseif options.type == "object" then "PilotObject"
			elseif options.type == "component" then "Component"
			else nil
	)

	local content = {}
	local plainOutput = {}
	local undocumented = {}

	local initialiseMarkdownSection, applyInheritence, writeMarkdownSection =
		markdownWriter(options, content, plainOutput)

	initialiseMarkdownSection("methods", getMethods(object, undocumented))

	local configurables, properties = getProperties(object, undocumented)
	initialiseMarkdownSection("configurables", unpack(configurables))
	initialiseMarkdownSection("properties", unpack(properties))

	initialiseMarkdownSection("events", getEvents(object, undocumented))
	initialiseMarkdownSection("undocumented", undocumented)

	applyInheritence()

	writeMarkdownSection("methods")
	writeMarkdownSection("configurables")
	writeMarkdownSection("properties")
	writeMarkdownSection("events")
	writeMarkdownSection("undocumented")

	markdownDocumentation[options.name] = content

	if #plainOutput > 0 then
		local plainDescription = getEscapedDescription(object)
		if plainDescription then
			table.insert(plainOutput, 1, plainDescription)
		end

		if next(markdownMetadata) then
			table.insert(plainOutput, 1, `---\n{serde.encode("yaml", markdownMetadata)}---`)
		end

		fs.writeFile(`wiki/docs/Objects/{options.name}.md`, (table.concat(plainOutput, "\n\n")))
	elseif fs.isFile(markdownPath) then
		fs.removeFile(markdownPath)
	end
end

return generateWikiPage
