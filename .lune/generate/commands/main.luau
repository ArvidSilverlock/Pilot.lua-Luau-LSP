local serde = require("@lune/serde")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

local Utility = require("../Utility")
local Parse = require("../Parse")
local Types = require("../Types")

local GetPartData = require("../Data/PartData")

return function(documentationFileType: "json" | "yaml")
	if not (fs.isDir("./workspace") and fs.isDir("./workspace/types")) then
		stdio.ewrite("please run `setup` before `generate`")
		return 1
	elseif documentationFileType ~= "json" and documentationFileType ~= "yaml" then
		stdio.ewrite("the parameter passed to `setup` must be `json` or `yaml` (case-sensitive)")
		return 1
	end

	local partData = GetPartData(documentationFileType)

	fs.writeFile(`.lune/generate/documentation.json`, serde.encode("json", partData, true))
	fs.writeFile(`.lune/generate/documentation.yaml`, serde.encode("yaml", partData, true))

	local output: Types.Output = {
		localTypes = {},
		generatedTypes = {},

		globalTypes = {},
		globalValues = {},
		globalFunctions = { {}, {} },
		generatedGlobals = {},

		pilotObjects = {},
		extendedPilotObjects = {},

		documentation = {},
	}

	Parse.parseObject({
		name = "PilotObject",
		object = partData.objectbase,
		output = output,
	})

	for objectName, objectData in partData.objects do
		Parse.parseObject({
			name = objectName,
			object = objectData,
			output = output,
		})
	end

	for typeName, type in partData.types do
		table.insert(output.localTypes, `type {typeName} = {Parse.parseLuauType(type)}`)
	end

	for typeName, type in partData.globals.types do
		table.insert(output.globalTypes, `export type {typeName} = {Parse.parseLuauType(type)}`)
	end

	for valueName, data in partData.globals.values do
		table.insert(output.globalValues, `declare {valueName}: {Parse.parseLuauType(data.type)}`)
		output.documentation[`@roblox/global/{valueName}`] = {
			documentation = Parse.getDescription(data),
		}
	end

	for typeName, data in partData.globals.functions do
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
				documentation = data.documentation,
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

	fs.writeFile(
		"workspace/types/global.d.luau",
		table.concat({
			table.concat(output.localTypes, "\n"),
			table.concat(generatedTypes, "\n\n"),
			table.concat(output.globalTypes, "\n"),
			table.concat(output.globalValues, "\n"),
			table.concat(output.globalFunctions[1], "\n"),
			table.concat(output.globalFunctions[2], "\n\n"),
			table.concat(output.generatedGlobals, "\n\n"),
			table.concat(output.pilotObjects, "\n\n"),
			table.concat(output.extendedPilotObjects, "\n\n"),
		}, "\n\n")
	)

	fs.writeFile(
		"workspace/types/documentation.d.json",
		(
			serde.encode("json", output.documentation, true):gsub("\n( +)", function(whitespace)
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
