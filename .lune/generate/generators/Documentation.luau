--!strict

local serde = require("@lune/serde")
local fs = require("@lune/fs")

local PilotData = require("../object-data/Pilot")
local Types = require("../modules/Types")

local function constructDescription(data: Types.Describable, _output: { [string]: any }?)
	local output: { [string]: any } = _output or {}

	local description = {}

	if data.Deprecated then
		table.insert(
			description,
			if typeof(data.Deprecated) == "string" then `@deprecated -- {data.Deprecated}` else "@deprecated"
		)
	end

	if (data :: any).ReadOnly then
		table.insert(description, "@readonly")
	end

	if data.Description and not data.Description:match("^%s*$") then
		if #description > 0 then
			table.insert(description, "")
		end

		table.insert(description, data.Description)
	end

	output.documentation = if #description > 0 then table.concat(description, "\n") else nil
	output.code_sample = data.CodeSample
	output.learn_more_link = data.LearnMoreLink

	return output
end

local function insertObject(object: Types.ObjectData, output)
	local objectKey = `@roblox/globaltypes/{object.Name}`

	local documentation = constructDescription(object)
	local keys = {}

	for _, member in object.Members :: any do
		local memberKey = `@roblox/globaltypes/{member.Source}.{member.Name}`

		if member.Source == object.Name then
			output[memberKey] = constructDescription(member.Reference)
			if next(output[memberKey]) then
				keys[member.Name] = memberKey
			end
		end
	end

	if next(keys) then
		documentation.keys = keys
	end

	if next(documentation) then
		output[objectKey] = documentation
	end
end

local Documentation = {}

function Documentation.generate()
	local output = {}

	for _, data in PilotData.Functions do
	end

	for _, data in PilotData.FunctionDictionaries do
	end

	for _, data in PilotData.Values do
	end

	for _, objectName in PilotData.ObjectDefinitionOrder do
		insertObject(PilotData.Objects[objectName], output)
	end

	return output
end

function Documentation.save(options, generatedData)
	fs.writeFile(`{options.o}/{options["types-dir"]}/documentation.d.json`, serde.encode("json", generatedData, true))
end

return Documentation
