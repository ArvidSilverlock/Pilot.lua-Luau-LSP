local serde = require("@lune/serde")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

local GET_PART_FUNCTIONS = {
	GetPart = true,
	GetPartFromPort = true,
	GetParts = true,
	GetPartsFromPort = true,
}

local pilotObjects, getPartGlobals, documentation, localTypes, globalTypes, globalValues, globalFunctions

local function resetWorkingValues()
	pilotObjects = {}
	getPartGlobals = {}
	documentation = {}
	localTypes = {}
	globalTypes = {}
	globalValues = {}
	globalFunctions = { {}, {} }
end

local function sanitiseName(name: string): string
	return if name:match("^%d") then "_" .. name else name
end

local function getDescription(data)
	local description = {}

	if data.deprecated then
		table.insert(
			description,
			if type(data.deprecated) == "string" then `@deprecated -- {data.deprecated}` else "@deprecated"
		)
	end

	if data.readonly then
		table.insert(description, "@readonly")
	end

	if #description > 0 then
		table.insert(description, "")
	end

	table.insert(description, data.description)

	return table.concat(description, "\n")
end

local function parseLuauType(input): string
	if type(input) == "string" then
		return input
	elseif type(input) == "table" and #input > 0 and (input[1]:match("^and%??$") or input[1]:match("^or%??$")) then
		local output = {}

		for index = 2, #input do
			table.insert(output, parseLuauType(input[index]))
		end

		local concatenation = table.concat(output, if input[1]:match("^and") then " & " else " | ")
		return if input[1]:sub(-1, -1) == "?" then `({concatenation})?` else concatenation
	elseif type(input) == "table" and type((next(input))) == "string" then
		local output = {}

		for key, value in input do
			local formattedKey = if key:match("^[_%a][_%w]*$") then key else `[{string.format("%q", key)}]`
			table.insert(output, `{formattedKey}: {parseLuauType(value)}`)
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

local function parseFunction(key: string, functionData, isMethod: boolean, standardLuauNotation: boolean)
	if functionData.unknowntype then
		documentation[key] = {
			documentation = getDescription(functionData),
		}

		return if isMethod
			then "(self, ...: any): ...any"
			elseif not standardLuauNotation then "(...: any): ...any"
			else "(...any) -> ...any"
	else
		local functionType = { if isMethod then "(self" else "(" }

		local parameters = {}
		local returns = {}

		if isMethod then
			local baseKey = key:match("^(.*)/.-$")
			table.insert(parameters, {
				name = "self",
				documentation = `@roblox/globaltype/{baseKey}`,
			})
		end

		if functionData.parameters and #functionData.parameters > 0 then
			for index, parameter in functionData.parameters do
				local parameterKey = `{key}/param/{if isMethod then index else index - 1}`

				local nameAndType = if type(parameter) == "string" then parameter else parameter[1]
				local name = nameAndType:match("^(.-):")

				if type(parameter) == "table" then
					table.insert(parameters, { name = name, documentation = parameterKey })
					documentation[parameterKey] = { documentation = parameter[2] }
				else
					table.insert(parameters, { name = name })
				end

				if index > 1 or isMethod then
					table.insert(functionType, ", ")
				end

				if standardLuauNotation then
					table.insert(functionType, (nameAndType:gsub("^%.%.%.: ", "...")))
				else
					table.insert(functionType, nameAndType)
				end
			end
		end

		if functionData.returns and #functionData.returns > 0 then
			if standardLuauNotation then
				table.insert(functionType, ") -> ")
				if #functionData.returns > 1 then
					table.insert(functionType, "(")
				end
			else
				table.insert(functionType, "): ")
				if #functionData.returns > 1 then
					table.insert(functionType, "(")
				end
			end

			for index, parameter in functionData.returns do
				local returnKey = `{key}/return/{index - 1}`
				local luauType = if type(parameter) == "string" then parameter else parameter[1]

				if type(parameter) == "table" then
					table.insert(returns, returnKey)
					documentation[returnKey] = { description = parameter[2] }
				else
					documentation[returnKey] = { description = "" }
				end

				table.insert(functionType, luauType)
				if index < #functionData.returns then
					table.insert(functionType, ", ")
				end
			end

			if #functionData.returns > 1 then
				table.insert(functionType, ")")
			end
		else
			table.insert(functionType, if standardLuauNotation then ") -> ()" else ")")
		end

		documentation[key] = {
			documentation = getDescription(functionData),
			params = if #parameters > 0 then parameters else nil,
			returns = if #returns > 0 then returns else nil,
		}

		return table.concat(functionType)
	end
end

local function registerObject(objectName, objectData)
	local typeName = sanitiseName(objectName)
	local className = string.format("%q", objectName)

	local typeDefinitionSections = {}
	local documentationSubKeys = {}

	if objectData.methods then
		local methods = {}

		for method, data in objectData.methods do
			local key = `@roblox/globaltype/{typeName}.{method}`
			local functionType = parseFunction(key, data, true, false)

			table.insert(methods, `\tfunction {method}{functionType}`)

			documentationSubKeys[method] = key
		end

		table.insert(typeDefinitionSections, table.concat(methods, "\n"))
	end

	if objectData.properties then
		local properties = {}
		local configure = {}

		table.insert(configure, `\tfunction Configure(self, properties: \{`)

		local configureKey = `@roblox/globaltype/PilotObject.Configure`
		documentationSubKeys.Configure = configureKey

		for property, data in objectData.properties do
			local key = `@roblox/globaltype/{typeName}.{property}`
			local documentationObject = {
				documentation = getDescription(data),
			}

			documentation[key] = if #documentationObject.documentation > 0 then documentationObject else nil
			documentationSubKeys[property] = key

			local luauType = if data.unknowntype then "any" else data.type
			if not data.readonly then
				table.insert(configure, `\t\t{property}: {luauType}?,`)
			end
			table.insert(properties, `\t{property}: {luauType}`)
		end

		if objectName == "PilotObject" then
			table.insert(configure, `\t\t[string]: any,`)
		end

		table.insert(configure, `\t\})`)

		table.insert(typeDefinitionSections, table.concat(configure, "\n"))
		table.insert(typeDefinitionSections, 1, table.concat(properties, "\n"))
	end

	if objectData.events then
		local events = {}

		for event, data in objectData.events do
			local eventKey = `@roblox/globaltype/{typeName}.{event}`

			documentation[eventKey] = {
				documentation = getDescription(data),
			}
			documentationSubKeys[event] = eventKey

			if data.parameters and #data.parameters > 0 then
				local namedParameters, parameterTypes = {}, {}
				for _, parameter in data.parameters do
					local nameAndType = if type(parameter) == "string" then parameter else parameter[1]
					local luauType = nameAndType:match("^.-:%s*(.*)$")
					table.insert(namedParameters, nameAndType)
					table.insert(parameterTypes, luauType)
				end

				table.insert(
					events,
					`\t{event}: Event<({table.concat(namedParameters, ", ")}) -> (), {table.concat(parameterTypes, ", ")}>`
				)
			elseif data.unknowntype then
				table.insert(events, `\t{event}: Event<(...any) -> (), ...any>`)
			else
				table.insert(events, `\t{event}: Event<() -> ()>`)
			end
		end

		table.insert(typeDefinitionSections, table.concat(events, "\n"))
	end

	local documentationObject = {
		documentation = getDescription(objectData),
		keys = if next(documentationSubKeys) then documentationSubKeys else nil,
	}

	documentation[`@roblox/globaltype/{typeName}`] = if documentationObject.documentation
			or next(documentationObject.keys)
		then documentationObject
		else nil

	table.insert(
		pilotObjects,
		if typeName == "PilotObject"
			then table.concat({
				`declare class {typeName}`,
				table.concat(typeDefinitionSections, "\n\n"),
				`end`,
			}, "\n")
			elseif #typeDefinitionSections > 0 then table.concat({
				`declare class {typeName} extends {objectData.extends or "PilotObject"}`,
				`\tClassName: {className}`,
				"",
				table.concat(typeDefinitionSections, "\n\n"),
				`end`,
			}, "\n")
			else `declare class {typeName} extends {objectData.extends or "PilotObject"}\nClassName: {className}\nend`
	)
end

return function(documentationFileType: "json" | "yaml")
	if not (fs.isDir("./workspace") and fs.isDir("./workspace/types")) then
		stdio.ewrite("please run `setup` before `generate`")
		return 1
	elseif documentationFileType ~= "json" and documentationFileType ~= "yaml" then
		stdio.ewrite("the parameter passed to `setup` must be `json` or `yaml` (case-sensitive)")
		return 1
	end

	resetWorkingValues()

	local PART_DATA =
		serde.decode(documentationFileType, fs.readFile(`.lune/generate/documentation.{documentationFileType}`))

	fs.writeFile(`.lune/generate/documentation.json`, serde.encode("json", PART_DATA, true))
	fs.writeFile(`.lune/generate/documentation.yaml`, serde.encode("yaml", PART_DATA, true))

	registerObject("PilotObject", PART_DATA.objectbase)
	for objectName, objectData in PART_DATA.objects do
		registerObject(objectName, objectData)
	end

	for callbackName, _ in GET_PART_FUNCTIONS do
		local lines = {
			`declare {callbackName}:`,
		}

		local index = 1
		for objectName, _ in PART_DATA.objects do
			local className = string.format("%q", objectName)
			local typeName = sanitiseName(objectName)
			table.insert(lines, `\t{if index == 1 then " " else "&"} _{callbackName}<{className}, {typeName}>`)
			index += 1
		end
		table.insert(lines, `\t& _{callbackName}<string?, PilotObject>`)

		table.insert(getPartGlobals, table.concat(lines, "\n"))
	end

	for typeName, type in PART_DATA.types do
		table.insert(localTypes, `type {typeName} = {parseLuauType(type)}`)
	end

	for typeName, type in PART_DATA.globals.types do
		table.insert(globalTypes, `export type {typeName} = {parseLuauType(type)}`)
	end

	for valueName, data in PART_DATA.globals.values do
		table.insert(globalValues, `declare {valueName}: {parseLuauType(data.type)}`)
		documentation[`@roblox/global/{valueName}`] = {
			documentation = getDescription(data),
		}
	end

	for typeName, data in PART_DATA.globals.functions do
		local key = `@roblox/global/{typeName}`
		if data.keys then
			local keys = {}
			local definition = { `declare {typeName}: \{` }

			for functionName, functionData in data.keys do
				local subKey = `{key}.{functionName}`
				local functionType = parseFunction(subKey, functionData, false, true)

				table.insert(definition, `\t{functionName}: {functionType},`)
				keys[functionName] = subKey
			end

			table.insert(definition, "}")

			table.insert(globalFunctions[2], table.concat(definition, "\n"))
			documentation[key] = {
				documentation = documentation,
				keys = keys,
			}
		else
			local functionType = parseFunction(key, data, false, false)
			if not GET_PART_FUNCTIONS[typeName] then
				table.insert(globalFunctions[1], `declare function {typeName}{functionType}`)
			end
		end
	end

	fs.writeFile(
		"workspace/types/global.d.luau",
		table.concat({
			table.concat(localTypes, "\n"),
			table.concat(globalTypes, "\n"),
			table.concat(globalValues, "\n"),
			table.concat(globalFunctions[1], "\n"),
			table.concat(globalFunctions[2], "\n\n"),
			table.concat(pilotObjects, "\n\n"),
			table.concat(getPartGlobals, "\n\n"),
		}, "\n\n")
	)

	fs.writeFile(
		"workspace/types/documentation.d.json",
		(
			serde.encode("json", documentation, true):gsub("\n( +)", function(whitespace)
				return "\n" .. string.rep("\t", #whitespace / 2)
			end)
		)
	)

	stdio.write(stdio.color("green"))
	stdio.write(stdio.style("bold"))
	stdio.write("Generated!\n")
	stdio.write(stdio.color("reset"))

	return 0
end
