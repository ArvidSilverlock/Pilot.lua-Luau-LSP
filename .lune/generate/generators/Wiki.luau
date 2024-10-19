local WIKI_DIRECTORY = "./wiki/docs"

local serde = require("@lune/serde")
local fs = require("@lune/fs")

local PilotData = require("../object-data/Pilot")
local ParseMiscellaneous = require("../object-data/raw-pilot-data/Parse/Miscellaneous")
local Utility = require("../modules/Utility")
local Types = require("../modules/Types")

local function createDocumentationSection()
	return {
		Normal = { Documented = {}, Undocumented = {} },
		Deprecated = { Documented = {}, Undocumented = {} },
	}
end

local function createDocumentationSections()
	return {
		Methods = createDocumentationSection(),
		Configurables = createDocumentationSection(),
		Properties = createDocumentationSection(),
		Events = createDocumentationSection(),
	}
end

local function insertSection(source, output, paths)
	return function(sectionName, sourceObject, isInherited, hasAddedTitle)
		if not source[sourceObject] or not source[sourceObject][sectionName] then
			return false
		end

		local sectionOutput = {}

		local function insertGroup(group)
			local values = source[sourceObject][sectionName][group]
			local documented, undocumented = values.Documented, values.Undocumented

			local groupOutput = {}

			if documented and #documented > 0 then
				table.insert(groupOutput, table.concat(documented, "\n"))
			end

			if undocumented and #undocumented > 0 then
				table.insert(groupOutput, table.concat(undocumented, "\n"))
			end

			if #groupOutput > 0 then
				local groupString = table.concat(groupOutput, "\n")
				table.insert(
					sectionOutput,
					if group == "Deprecated"
						then Utility.markdownDropdown("Deprecated", groupString)
						else table.concat(groupOutput, "\n")
				)
			end
		end

		insertGroup("Normal")
		insertGroup("Deprecated")

		if #sectionOutput > 0 then
			local stringForm = table.concat(sectionOutput, "\n")

			local formatted = if isInherited
				then Utility.markdownDropdown(`Inherited from [{sourceObject}]({paths[sourceObject]})`, stringForm)
				else stringForm

			if not hasAddedTitle then
				table.insert(output, `## {sectionName}`)
				hasAddedTitle = true
			end

			table.insert(output, formatted)
		end

		return hasAddedTitle
	end
end

local Wiki = {}

function Wiki.generate(options)
	local generatedPages = {
		["Objects"] = {},
		["Classes"] = {},
		["Programmable Objects"] = {},
	}
	local paths = {}

	for _, objectName in PilotData.ObjectDefinitionOrder do
		local objectData = PilotData.Objects[objectName]

		local pageOutput = {}
		local metadata = {}

		if #objectData.Categories > 0 then
			metadata.tags = table.clone(objectData.Categories)
		end

		for _, member in objectData.Members do
			local source = pageOutput[member.Source]
			if not source then
				source = createDocumentationSections()
				pageOutput[member.Source] = source
			end

			local value = member.Reference
			local isUnknownType = value.Type.Unknown == true
			local isDeprecated = not not value.Deprecated

			local documentedKey = if isUnknownType then "Undocumented" else "Documented"
			local deprecatedKey = if isDeprecated then "Deprecated" else "Normal"

			local group = source[member.Group][deprecatedKey][documentedKey]
			table.insert(group, value.Type.Wiki or `- {member.Name}`)
		end

		local plainDescription = ParseMiscellaneous.plainDescription(objectData)
		local output = if plainDescription then { Utility.escapeMarkdown(plainDescription) } else {}

		local addSection = insertSection(pageOutput, output, paths)
		for _, section in { "Methods", "Configurables", "Properties", "Events" } do
			local sectionOutput = {}

			local hasAddedTitle = addSection(section, objectName, false, false)
			for _, object in objectData.InheritanceChain do
				hasAddedTitle = addSection(section, object, true, hasAddedTitle)
			end

			if #sectionOutput > 0 then
				table.insert(output, `## {section}`)
				table.insert(output, table.concat(sectionOutput, "\n"))
			end
		end

		if next(metadata) then
			table.insert(output, 1, `---\n{serde.encode("yaml", metadata)}---`)
		end

		local section = if objectData.Group == "abstractclasses"
			then "Classes"
			elseif objectData.IsProgrammable then "Programmable Objects"
			else "Objects"

		paths[objectName] = `/docs/{section}/{objectName}.md`
		generatedPages[section][objectName] = table.concat(output, "\n\n")
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

			if fs.isDir(subpath) then
				fs.removeDir(subpath)
			end
			fs.writeDir(subpath)

			recursiveWrite(value, subpath)
		else
			fs.writeFile(`{path}/{name}.md`, value)
		end
	end
end

function Wiki.save(options, generatedPages)
	recursiveWrite(generatedPages, WIKI_DIRECTORY)
end

return Wiki
