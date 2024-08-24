local WIKI_DIRECTORY = "./wiki/docs/Objects"

local fs = require("@lune/fs")

local PilotData = require("../object-data/Pilot")
local Utility = require("../modules/Utility")
local Types = require("../modules/Types")

local function constructPlainDescription(data: Types.Describable): string?
	return if data.Description and not data.Description:match("^%s*$")
		then data.Description:match("^%s*(.-)%s*$")
		else nil
end

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

local function insertSection(source, output)
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
				then Utility.markdownDropdown(
					`Inherited from [{sourceObject}](/docs/objects/{sourceObject})`,
					stringForm
				)
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
	local generatedPages = {}

	for _, objectName in PilotData.ObjectDefinitionOrder do
		local objectData = PilotData.Objects[objectName]
		local pageOutput = {}

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

		local plainDescription = constructPlainDescription(objectData)
		local output = if plainDescription then { Utility.escapeMarkdown(plainDescription) } else {}

		local addSection = insertSection(pageOutput, output)
		for _, section in { "Methods", "Configurables", "Properties", "Events" } do
			local sectionOutput = {}

			local hasAddedTitle = addSection(section, objectName, false, false)
			for _, object in objectData.InheritenceChain do
				hasAddedTitle = addSection(section, object, true, hasAddedTitle)
			end

			if #sectionOutput > 0 then
				table.insert(output, `## {section}`)
				table.insert(output, table.concat(sectionOutput, "\n"))
			end
		end

		generatedPages[objectName] = table.concat(output, "\n\n")
	end

	return generatedPages
end

function Wiki.save(options, generatedPages)
	Utility.makeDirectory(WIKI_DIRECTORY)

	for _, page in fs.readDir(WIKI_DIRECTORY) do
		local pageName = Utility.stripFileExtension(page)
		if not generatedPages[pageName] then
			fs.removeFile(`{WIKI_DIRECTORY}/{page}`)
		end
	end

	for name, page in generatedPages do
		fs.writeFile(`{WIKI_DIRECTORY}/{name}.md`, page)
	end
end

return Wiki
