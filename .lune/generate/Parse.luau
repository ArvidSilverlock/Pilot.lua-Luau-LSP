--!strict

local serde = require("@lune/serde")
local fs = require("@lune/fs")

local Utility = require("./Utility")
local Types = require("./Types")

local PartData = require("./data/PartData")()

local markdownDocumentation = {}

local Parse = {}

function Parse.constructPlainDescription(data: Types.Describable): string?
	return if data.description and not data.description:match("^%s*$")
		then data.description:match("^%s*(.-)%s*$")
		else nil
end

function Parse.constructDescription(data: Types.Describable, _output: { [string]: any }?)
	local output: { [string]: any } = _output or {}

	local description = {}

	if data.deprecated then
		table.insert(
			description,
			if typeof(data.deprecated) == "string" then `@deprecated -- {data.deprecated}` else "@deprecated"
		)
	end

	if data.readonly then
		table.insert(description, "@readonly")
	end

	local plainDescription = Parse.constructPlainDescription(data)
	if plainDescription then
		if #description > 0 then
			table.insert(description, "")
		end

		table.insert(description, plainDescription)
	end

	output.documentation = if #description > 0 then table.concat(description, "\n") else nil
	output.code_sample = data.codesample
	output.learn_more_link = data.learnmore

	return output
end

function Parse.parseLuauType(input: any): string
	if typeof(input) == "string" then
		return input
	elseif typeof(input) == "table" and #input > 0 and (input[1]:match("^and%??$") or input[1]:match("^or%??$")) then
		local output = {}

		for index = 2, #input do
			table.insert(output, Parse.parseLuauType(input[index]))
		end

		local concatenation = table.concat(output, if input[1]:match("^and") then " & " else " | ")
		return if input[1]:sub(-1, -1) == "?" then `({concatenation})?` else concatenation
	elseif typeof(input) == "table" and typeof((next(input))) == "string" then
		local output = {}

		for key, value in input do
			local formattedKey = if key:match("^[_%a][_%w]*$") then key else `[{string.format("%q", key)}]`
			table.insert(output, `{formattedKey}: {Parse.parseLuauType(value)}`)
		end

		return `\{ {table.concat(output, ", ")} }`
	else
		local output = {}
		for _, string in input do
			table.insert(output, string.format("%q", string))
		end
		return table.concat(output, " | ")
	end
end

function Parse.constructKey(options: Types.Options)
	return if options.key
		then options.key
		elseif options.within then `@roblox/globaltype/{options.within}.{options.name}`
		else `@roblox/global/{options.name}`
end

function Parse.getObject(source: string, options: { object: any, [string]: any })
	return if source == "Object" and type(options.object) == "string"
		then { description = options.object }
		elseif source == "Event" and options.object == true then PartData.events[options.name]
		else options.object
end

function Parse.runGenerator(source: string, options: { object: any })
	local object = Parse.getObject(source, options)

	local path = `.lune/generate/generators/{object.generate}.luau`

	local isFile = fs.isFile(path)
	if not isFile then
		error(`there is no generator called '{object.generate}'`)
	end

	local success, generator = pcall(require, path)
	if not success then
		error(`failed to get generator '{object.generate}', error: {generator}`)
	end

	if typeof(generator) == "function" then
		return generator(source, options)
	elseif generator[`parse{source}`] then
		return generator[`parse{source}`](options)
	else
		error(`the generator '{object.generate}' does not function for '{source}' values`)
	end
end

function Parse.parseFunction(options: Types.FunctionOptions)
	local object = Parse.getObject("Function", options)
	local output = options.output

	local key = Parse.constructKey(options)

	if options.documentationSubKeys then
		options.documentationSubKeys[options.name] = key
	end

	output.documentation[key] = Parse.constructDescription(object)

	if object.generate then
		return Parse.runGenerator("Function", options)
	elseif object.unknowntype then
		return if options.isMethod and options.within
			then `function {options.name}(self, ...: any): ...any`
			elseif options.standardLuauNotation and options.within then `{options.name}: (...any) -> ...any`
			else `declare function {options.name}(...: any): ...any`
	else
		local functionType = { if options.isMethod then "(self" else "(" }

		local parameters: Types.DocumentationParameters = {}
		local returns = {}

		if options.isMethod then
			table.insert(parameters, {
				name = "self",
				documentation = `@roblox/globaltype/{options.within}`,
			})
		end

		if object.parameters and #object.parameters > 0 then
			for index, parameter in object.parameters do
				local parameterKey = `{key}/param/{if options.isMethod then index else index - 1}`

				local nameAndType = if typeof(parameter) == "string" then parameter else parameter[1]
				local name = nameAndType:match("^(.-):") :: string

				if typeof(parameter) == "table" then
					table.insert(parameters, { name = name, documentation = parameterKey })
					output.documentation[parameterKey] = { documentation = parameter[2] }
				else
					table.insert(parameters, { name = name })
				end

				if index > 1 or options.isMethod then
					table.insert(functionType, ", ")
				end

				if options.within then
					table.insert(functionType, (nameAndType:gsub("^%.%.%.: ", "...")))
				else
					table.insert(functionType, nameAndType)
				end
			end
		end

		if object.returns and #object.returns > 0 then
			if options.standardLuauNotation then
				table.insert(functionType, ") -> ")
				if #object.returns > 1 then
					table.insert(functionType, "(")
				end
			else
				table.insert(functionType, "): ")
				if #object.returns > 1 then
					table.insert(functionType, "(")
				end
			end

			local defineReturns = false
			for index, parameter in object.returns do
				if typeof(parameter) == "table" then
					defineReturns = true
					break
				end
			end

			for index, parameter in object.returns do
				local returnKey = `{key}/return/{index - 1}`
				local luauType = if typeof(parameter) == "string" then parameter else parameter[1]

				if defineReturns then
					table.insert(returns, returnKey)
					output.documentation[returnKey] =
						{ documentation = if typeof(parameter) == "table" then parameter[2] else "" }
				end

				table.insert(functionType, luauType)
				if index < #object.returns then
					table.insert(functionType, ", ")
				end
			end

			if #object.returns > 1 then
				table.insert(functionType, ")")
			end
		else
			table.insert(functionType, if options.standardLuauNotation then ") -> ()" else ")")
		end

		if #parameters > 0 then
			output.documentation[key].params = parameters
		end

		if #returns > 0 then
			output.documentation[key].returns = returns
		end

		local functionTypeText = table.concat(functionType)
		return if options.isMethod and options.within
			then `function {options.name}{functionTypeText}`
			elseif options.standardLuauNotation and options.within then `{options.name}: {functionTypeText}`
			else `declare function {options.name}{functionTypeText}`
	end
end

function Parse.parseValue(options: Types.ValueOptions): (string, string)
	local object = Parse.getObject("Value", options)
	local output = options.output

	local key = Parse.constructKey(options)
	output.documentation[key] = Parse.constructDescription(object)

	if options.documentationSubKeys then
		options.documentationSubKeys[options.name] = key
	end

	local luauType = if object.unknowntype then "any" else Parse.parseLuauType(object.type)
	return `{if not options.within then "declare " else ""}{options.name}: {luauType}`, luauType
end

function Parse.parseEvent(options: Types.EventOptions): string
	local object = Parse.getObject("Event", options)
	local output = options.output

	local eventKey = Parse.constructKey(options)
	output.documentation[eventKey] = Parse.constructDescription(object)

	if options.documentationSubKeys then
		options.documentationSubKeys[options.name] = eventKey
	end

	if object.generate then
		return Parse.runGenerator("Event", options)
	elseif object.parameters and #object.parameters > 0 then
		local namedParameters, parameterTypes = {}, {}
		for _, parameter in object.parameters do
			local nameAndType = if typeof(parameter) == "string" then parameter else parameter[1]
			local luauType = nameAndType:match("^.-:%s*(.*)$")
			table.insert(namedParameters, nameAndType)
			table.insert(parameterTypes, luauType)
		end

		return `{options.name}: Event<{string.format("%q", options.name)}, ({table.concat(namedParameters, ", ")}) -> (), {table.concat(parameterTypes, ", ")}>`
	elseif object.unknowntype then
		return `{options.name}: Event<{string.format("%q", options.name)}>`
	else
		return `{options.name}: Event<{string.format("%q", options.name)}, () -> ()>`
	end
end

function Parse.parseObject(options: Types.ObjectOptions)
	local object = Parse.getObject("Object", options)
	local output = options.output

	local typeName = Utility.sanitiseName(options.name)
	local className = string.format("%q", options.name)

	local sections = {}

	local markdownUndocumented = {}
	local markdownSections = {}

	local documentationSubKeys = {}

	if object.properties then
		local properties = {}
		local configure = {}

		local markdownProperties = {
			readonly = { deprecated = {}, normal = {} },
			normal = { deprecated = {}, normal = {} },
		}

		table.insert(configure, `\tfunction Configure(self, properties: \{`)
		documentationSubKeys.Configure = "@roblox/globaltype/PilotObject.Configure"

		for propertyName, propertyData in object.properties do
			local property, luauType = Parse.parseValue({
				name = propertyName,
				object = propertyData,
				documentationSubKeys = documentationSubKeys,
				output = output,
				within = typeName,
			})

			if not propertyData.readonly then
				table.insert(configure, `\t\t{property}?,`)
			end
			table.insert(properties, `\t{property}`)

			local description = Parse.constructPlainDescription(propertyData)
			if description then
				description = Utility.escapeMarkdown(description)
			end

			if propertyData.unknowntype then
				table.insert(
					markdownUndocumented,
					`{if propertyData.readonly then "property" else "configurable"} **{propertyName}**{if description then ` - {description}` else ""}`
				)
			else
				local outputTable = {
					`- **{propertyName}:** *{luauType}*{if description then ` - {description}` else ""}`,
				}

				local constraints = propertyData.constraints
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

				if typeof(propertyData.deprecated) == "string" then
					table.insert(outputTable, `  - {propertyData.deprecated}`)
				end

				-- stylua: ignore
				table.insert(
					markdownProperties
						[if propertyData.readonly then "readonly" else "normal"]
						[if propertyData.deprecated then "deprecated" else "normal"],
					table.concat(outputTable, "\n")
				)
			end
		end

		if options.name == "PilotObject" then
			table.insert(configure, `\t\t[string]: any,`)
		end

		table.insert(configure, `\t\})`)

		table.insert(sections, table.concat(configure, "\n"))
		table.insert(sections, 1, table.concat(properties, "\n"))

		markdownSections.properties = markdownProperties.readonly.normal
		markdownSections.configurables = markdownProperties.normal.normal
		markdownSections.deprecatedProperties = markdownProperties.readonly.deprecated
		markdownSections.deprecatedConfigurables = markdownProperties.normal.deprecated
	end

	if object.methods then
		local methods = {}

		local markdownMethods = { deprecated = {}, normal = {} }

		for methodName, methodData in object.methods do
			local method = Parse.parseFunction({
				name = methodName,
				object = methodData,
				output = output,
				documentationSubKeys = documentationSubKeys,
				within = typeName,
				isMethod = true,
				standardLuauNotation = false,
			})

			table.insert(methods, Utility.indent(method))

			local plainDescription = Parse.constructPlainDescription(methodData)
			if plainDescription then
				plainDescription = Utility.escapeMarkdown(plainDescription)
			end

			if methodData.unknowntype then
				table.insert(
					markdownUndocumented,
					`- **function {methodName}** {if plainDescription then ` - {plainDescription}` else ""}`
				)
			else
				local formatted = Utility.escapeMarkdown(
					method
						:gsub("^function ", "")
						:gsub("^([_%a][_%w]*%b()):(.*)", "%1 →%2")
						:gsub("^([_%a][_%w]*%()self", "%1*self*")
						:gsub("%->", "→")
						:gsub("^[_%a][_%w]*", "**%1**")
				)

				table.insert(
					if methodData.deprecated then markdownMethods.deprecated else markdownMethods.normal,
					`- {formatted}{if plainDescription then `\n  - {plainDescription}` else ""}{if typeof(methodData.deprecated) == "string" then `\n  - {methodData.deprecated}` else ""}`
				)
			end
		end

		table.insert(sections, table.concat(methods, "\n"))

		markdownSections.deprecatedMethods = markdownMethods.deprecated
		markdownSections.methods = markdownMethods.normal
	end

	if object.events then
		local events = {}

		local markdownEvents = { deprecated = {}, normal = {} }

		for eventName, eventData in object.events do
			local eventConfig = {
				name = eventName,
				object = eventData,
				output = output,
				documentationSubKeys = documentationSubKeys,
				within = typeName,
			}
			local eventType = Parse.parseEvent(eventConfig)

			table.insert(events, `\t{eventType}`)

			local actualEventData = Parse.getObject("Event", eventConfig)

			local plainDescription = Parse.constructPlainDescription(actualEventData)
			if plainDescription then
				plainDescription = Utility.escapeMarkdown(plainDescription)
			end

			if actualEventData.unknowntype then
				table.insert(
					markdownUndocumented,
					`- **event {eventName}** {if plainDescription then ` - {plainDescription}` else ""}`
				)
			else
				local formatted
				if actualEventData.parameters then
					local params = {}
					for _, parameter in actualEventData.parameters do
						local name = if typeof(parameter) == "table" then parameter[1] else parameter
						table.insert(params, name)
					end
					formatted = Utility.escapeMarkdown(`**{eventName}:** ({table.concat(params, ", ")})`)
				else
					formatted = Utility.escapeMarkdown(`**{eventName}**`)
				end

				table.insert(
					if actualEventData.deprecated then markdownEvents.deprecated else markdownEvents.normal,
					`- {formatted}{if plainDescription then `\n  - {plainDescription}` else ""}{if typeof(markdownEvents.deprecated) == "string"
						then `\n  - {markdownEvents.deprecated}`
						else ""}`
				)
			end
		end

		table.insert(sections, table.concat(events, "\n"))

		markdownSections.deprecatedEvents = markdownEvents.deprecated
		markdownSections.events = markdownEvents.normal
	end

	output.documentation[`@roblox/globaltype/{typeName}`] = Parse.constructDescription(object, {
		keys = if next(documentationSubKeys) then documentationSubKeys else nil,
	})

	table.insert(
		output.pilotObjects,
		if typeName == "PilotObject"
			then table.concat({
				`declare class {typeName}`,
				table.concat(sections, "\n\n"),
				`end`,
			}, "\n")
			elseif #sections > 0 then table.concat({
				`declare class {typeName} extends {object.extends or "PilotObject"}`,
				`\tClassName: {className}`,
				"",
				table.concat(sections, "\n\n"),
				`end`,
			}, "\n")
			else `declare class {typeName} extends {object.extends or "PilotObject"}\n\tClassName: {className}\nend`
	)

	local markdownPath = `wiki/docs/Objects/{options.name}.md`
	local metadata = {}

	metadata.tags = if object.categories then table.clone(object.categories) else {}
	table.insert(
		metadata.tags,
		if options.type == "abstract"
			then "AbstractClass"
			elseif options.type == "object" then "PilotObject"
			elseif options.type == "component" then "Component"
			else nil
	)

	local markdownContent = {}
	local markdownOutput = {}

	local function createMarkdownString(key: string)
		local uppercase = key:gsub("^%l", string.upper)
		local deprecatedKey = `deprecated{uppercase}`

		local normal = markdownSections[key]
		local deprecated = markdownSections[deprecatedKey]

		if normal and #normal > 0 and deprecated and #deprecated > 0 then
			markdownContent[key] = {
				{
					class = options.name,
					content = table.concat(normal, "\n")
						.. "\n"
						.. Utility.markdownDropdown(`Deprecated {uppercase}`, table.concat(deprecated, "\n")),
				},
			}
		elseif normal and #normal > 0 then
			markdownContent[key] = { { class = options.name, content = table.concat(normal, "\n") } }
		elseif deprecated and #deprecated > 0 then
			markdownContent[key] = { { class = options.name, content = table.concat(deprecated, "\n") } }
		end
	end

	local function addMarkdownSection(name: string)
		local section = markdownContent[name]
		if not section then
			return
		end

		local output = {}
		for index, value in section do
			table.insert(
				output,
				if value.class == options.name
					then value.content
					else Utility.markdownDropdown(
						`Inherited from [{value.class}](/docs/Objects/{value.class})`,
						value.content
					)
			)
		end

		table.insert(markdownOutput, `### {name:gsub("^%l", string.upper)}\n{table.concat(output, "\n\n")}`)
	end

	createMarkdownString("methods")
	createMarkdownString("configurables")
	createMarkdownString("properties")
	createMarkdownString("events")
	createMarkdownString("undocumented")

	local extends = if typeof(object.extends) == "string" then { object.extends } else object.extends

	if extends and #extends > 0 then
		for _, class in extends do
			if class == "PilotObject" then
				continue
			end

			local markdown: any = markdownDocumentation[class]
			for key, values in markdown do
				for _, value in values do
					if markdownContent[key] then
						table.insert(markdownContent[key], value)
					else
						markdownContent[key] = { value }
					end
				end
			end
		end
	end

	addMarkdownSection("methods")
	addMarkdownSection("configurables")
	addMarkdownSection("properties")
	addMarkdownSection("events")

	markdownDocumentation[options.name] = markdownContent

	if #markdownOutput > 0 then
		local plainDescription = Parse.constructPlainDescription(object)
		if plainDescription then
			table.insert(markdownOutput, 1, Utility.escapeMarkdown(plainDescription))
		end

		if next(metadata) then
			table.insert(markdownOutput, 1, `---\n{serde.encode("yaml", metadata)}---`)
		end

		fs.writeFile(`wiki/docs/Objects/{options.name}.md`, (table.concat(markdownOutput, "\n\n")))
	elseif fs.isFile(markdownPath) then
		fs.removeFile(markdownPath)
	end
end

return Parse
