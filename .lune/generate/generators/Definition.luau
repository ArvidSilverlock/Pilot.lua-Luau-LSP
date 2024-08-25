local fs = require("@lune/fs")

local PilotData = require("../object-data/Pilot")
local Utility = require("../modules/Utility")

local Definition = {}

local function insertSection(output, section, separator: string?)
	if section and #section > 0 then
		table.insert(output, table.concat(section, separator or "\n"))
	end
end

local function constructObjectOutput(objectData, members, output): string
	local sections =
		{ if objectData.Group == "objects" then `ClassName: {string.format("%q", objectData.Name)}` else nil }

	insertSection(sections, members.Methods)
	insertSection(sections, members.Properties)

	if #members.Configureables > 0 then
		table.insert(
			sections,
			table.concat({
				"function Configure(self, properties: {",
				Utility.indent(table.concat(members.Configure, "\n")),
				"})",
			}, "\n")
		)
		table.insert(sections, table.concat(members.Configureables, "\n"))
	end

	insertSection(sections, members.Events)

	return table.concat({
		if objectData.Inherits[1]
			then `declare class {objectData.Name} extends {objectData.Inherits[1]}`
			else `declare class {objectData.Name}`,
		Utility.indent(table.concat(sections, "\n\n")),
		"end",
	}, "\n")
end

local function defineObject(objectName, output)
	local objectData = PilotData.Objects[objectName]

	local sections = {
		Methods = {},
		Configureables = {},
		Configure = {},
		Properties = {},
		Events = {},
	}

	for _, member in objectData.Members do
		if member.Source ~= objectName then
			continue
		end

		local reference = member.Reference

		if member.Group == "Methods" then
			table.insert(sections.Methods, reference.Type.Definition)
		elseif member.Group == "Configurables" then
			table.insert(sections.Configureables, `{member.Name}: {reference.Type.Luau}`)
			table.insert(sections.Configure, `{member.Name}: {reference.Type.Luau}?,`)
		elseif member.Group == "Properties" then
			table.insert(sections.Properties, `{member.Name}: {reference.Type.Luau}`)
		elseif member.Group == "Events" then
			table.insert(sections.Events, reference.Type.Luau)
		end

		if reference.Type and reference.Type.InsertDefinition then
			reference.Type.InsertDefinition(output)
		end
	end

	table.insert(output.Objects, constructObjectOutput(objectData, sections, output.Objects))
end

local function defineLuauType(value, globalTypesOutput, localTypesOutput)
	if value.Group == "Global" then
		table.insert(globalTypesOutput, `export type {value.Name} = {value.Reference.Type}`)
	else
		table.insert(localTypesOutput, `type {value.Name} = {value.Reference.Type}`)
	end
end

function Definition.generate(options)
	local sections = {
		GlobalTypes = {},
		LocalTypes = {},
		GlobalFunctions = {},
		GlobalValues = {},
		Objects = {},
	}

	for _, luauType in PilotData.Types.References do
		defineLuauType(luauType, sections.GlobalTypes, sections.LocalTypes)
	end

	for name, data in PilotData.Functions do
		table.insert(sections.GlobalFunctions, data.Type.Definition)
		if data.Type.InsertDefinition then
			data.Type.InsertDefinition(sections)
		end
	end

	for name, data in PilotData.FunctionDictionaries do
		local functionOutput = { `declare {name}: \{` }
		for key, functionData in data.Functions do
			table.insert(functionOutput, `\t{functionData.Type.Luau},`)
			if functionData.Type.InsertDefinition then
				functionData.Type.InsertDefinition(sections)
			end
		end
		table.insert(functionOutput, "}")
		table.insert(sections.GlobalFunctions, table.concat(functionOutput, "\n"))
	end

	for name, data in PilotData.Values do
		table.insert(sections.GlobalValues, data.Type.Definition)
	end

	for _, objectName in PilotData.ObjectDefinitionOrder do
		defineObject(objectName, sections)
	end

	local output = {}

	insertSection(output, sections.LocalTypes)
	insertSection(output, sections.GlobalTypes)
	insertSection(output, sections.GlobalFunctions)
	insertSection(output, sections.GlobalValues)
	insertSection(output, sections.Objects, "\n\n")

	return table.concat(output, "\n\n")
end

function Definition.save(options, generatedData)
	fs.writeFile(`{options.o}/{options["types-dir"]}/global.d.luau`, generatedData)
end

return Definition
