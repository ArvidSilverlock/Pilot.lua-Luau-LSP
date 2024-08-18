--!strict

local serde = require("@lune/serde")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

local Utility = require("../Utility")
local Types = require("../Types")

local GetPartData = require("../data/PartData")

return function(options)
	local partData = GetPartData(options.source)

	-- Sync `json` and `yaml`. Has the added benefit of keeping the format.
	fs.writeFile(`.lune/generate/documentation.json`, serde.encode("json", partData, true))
	fs.writeFile(`.lune/generate/documentation.yaml`, serde.encode("yaml", partData, true))

	-- Have to require this later so `GetPartData` works with no parameters
	local Parse = require("../Parse")

	local output: Types.Output = {
		localTypes = {},
		generatedTypes = {},

		globalTypes = {},
		globalValues = {},
		globalFunctions = { {}, {} },
		generatedGlobals = {},

		pilotObjects = {},

		documentation = {},
		selene = {},
	}

	local function implement(objects: { [string]: Types.Object }, objectType)
		local remainingObjects = table.clone(objects)

		local objectName, objectData = next(remainingObjects)
		while objectName do
			if
				typeof(objectData) == "string"
				or objectData.extends and not remainingObjects[objectData.extends]
				or not objectData.extends
			then
				Parse.parseObject({
					name = objectName,
					object = objectData,
					output = output,
					objectType = objectType,
				})

				remainingObjects[objectName] = nil
				objectName, objectData, remainingObjects[objectName] = nil
			end

			objectName, objectData = next(remainingObjects, objectName)
		end
	end

	implement(partData.classes.abstractclasses, "abstract")
	implement(partData.classes.objects, "object")

	for typeName, type in partData.types do
		table.insert(output.localTypes, `type {typeName} = {Parse.parseLuauType(type)}`)
	end

	for typeName, type in partData.globals.types do
		table.insert(output.globalTypes, `export type {typeName} = {Parse.parseLuauType(type)}`)
	end

	for valueName, data in partData.globals.values do
		output.selene[valueName] = { any = true }

		table.insert(output.globalValues, `declare {valueName}: {Parse.parseLuauType(data.type)}`)
		output.documentation[`@roblox/global/{valueName}`] = Parse.constructDescription(data)
	end

	for typeName, data: any in partData.globals.functions do
		output.selene[typeName] = { any = true }

		local key = `@roblox/global/{typeName}`
		if data.keys then
			local keys = {}
			local definition = { `declare {typeName}: \{` }

			for functionName, functionData in data.keys do
				local subKey = `{key}.{functionName}`
				local functionType = Parse.parseFunction({
					key = subKey,
					name = functionName,
					object = functionData,
					output = output,
					isMethod = false,
					standardLuauNotation = true,
					within = typeName,
				})

				table.insert(definition, Utility.indent(functionType .. ","))
				keys[functionName] = subKey
			end

			table.insert(definition, "}")

			table.insert(output.globalFunctions[2], table.concat(definition, "\n"))
			output.documentation[key] = {
				documentation = data.description,
				keys = keys,
			}
		else
			local functionType = Parse.parseFunction({
				key = key,
				name = typeName,
				object = data,
				output = output,
				isMethod = false,
				standardLuauNotation = false,
			})

			table.insert(if data.generate then output.generatedGlobals else output.globalFunctions[1], functionType)
		end
	end

	local generatedTypes = {}
	for _, typeSection in output.generatedTypes do
		table.insert(
			generatedTypes,
			if type(typeSection) == "table" then table.concat(typeSection, "\n") else typeSection
		)
	end

	-- cull empty definitions
	for key, value in output.documentation do
		if not next(value) then
			output.documentation[key] = nil
		end
	end

	fs.writeFile(
		Utility.joinPath(options.o, `{options.types}/global.d.luau`),
		table.concat({
			table.concat(output.localTypes, "\n"),
			table.concat(generatedTypes, "\n\n"),
			table.concat(output.globalTypes, "\n"),
			table.concat(output.globalValues, "\n"),
			table.concat(output.globalFunctions[1], "\n"),
			table.concat(output.globalFunctions[2], "\n\n"),
			table.concat(output.generatedGlobals, "\n\n"),
			table.concat(output.pilotObjects, "\n\n"),
		}, "\n\n")
	)

	fs.writeFile(
		Utility.joinPath(options.o, `{options.types}/documentation.d.json`),
		(
			serde.encode("json", output.documentation, true):gsub("\n( +)", function(whitespace)
				return "\n" .. string.rep("\t", #whitespace / 2)
			end)
		)
	)

	fs.writeFile(Utility.joinPath(options.o, `{options.types}/pilot.yml`), serde.encode("yaml", output.selene, true))

	stdio.write(stdio.color("green"))
	stdio.write(stdio.style("bold"))
	stdio.write("Generated!\n")
	stdio.write(stdio.color("reset"))

	return 0
end
