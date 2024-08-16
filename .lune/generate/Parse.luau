--!strict

local fs = require("@lune/fs")

local Utility = require("./Utility")
local Types = require("./Types")

local PartData = require("./data/PartData")()

local Parse = {}

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

	if data.description and not data.description:match("^%s*$") then
		if #description > 0 then
			table.insert(description, "")
		end

		table.insert(description, data.description)
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
			local baseKey = key:match("^(.*)/.-$")
			table.insert(parameters, {
				name = "self",
				documentation = `@roblox/globaltype/{baseKey}`,
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

			for index, parameter in object.returns do
				local returnKey = `{key}/return/{index - 1}`
				local luauType = if typeof(parameter) == "string" then parameter else parameter[1]

				table.insert(returns, returnKey)
				output.documentation[returnKey] =
					{ description = if typeof(parameter) == "table" then parameter[2] else "" }

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

function Parse.parseValue(options: Types.ValueOptions): string
	local object = Parse.getObject("Value", options)
	local output = options.output

	local key = Parse.constructKey(options)
	output.documentation[key] = Parse.constructDescription(object)

	if options.documentationSubKeys then
		options.documentationSubKeys[options.name] = key
	end

	return `{if not options.within then "declare " else ""}{options.name}: {if object.unknowntype then "any" else Parse.parseLuauType(object.type)}`
end

function Parse.parseEvent(options: Types.EventOptions): string
	local object = Parse.getObject("Event", options)
	local output = options.output

	local eventKey = Parse.constructKey(options)
	output.documentation[eventKey] = Parse.constructDescription(object)

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

	local documentationSubKeys = {}

	if object.properties then
		local properties = {}
		local configure = {}

		table.insert(configure, `\tfunction Configure(self, properties: \{`)
		documentationSubKeys.Configure = "@roblox/globaltype/PilotObject.Configure"

		for propertyName, propertyData in object.properties do
			local property = Parse.parseValue({
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
		end

		if options.name == "PilotObject" then
			table.insert(configure, `\t\t[string]: any,`)
		end

		table.insert(configure, `\t\})`)

		table.insert(sections, table.concat(configure, "\n"))
		table.insert(sections, 1, table.concat(properties, "\n"))
	end

	if object.methods then
		local methods = {}

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
		end

		table.insert(sections, table.concat(methods, "\n"))
	end

	if object.events then
		local events = {}

		for eventName, eventData in object.events do
			local eventType = Parse.parseEvent({
				name = eventName,
				object = eventData,
				output = output,
				documentationSubKeys = documentationSubKeys,
				within = typeName,
			})

			table.insert(events, `\t{eventType}`)
		end

		table.insert(sections, table.concat(events, "\n"))
	end

	output.documentation[`@roblox/globaltype/{typeName}`] = Parse.constructDescription(object, {
		keys = documentationSubKeys,
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
end

return Parse
