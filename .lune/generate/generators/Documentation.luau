--!strict

local serde = require("@lune/serde")
local fs = require("@lune/fs")

local PilotData = require("../object-data/Pilot")
local Types = require("../modules/Types")

local NO_PARAMETER_RESERVED = "__RESERVE__NO_PARAMETERS___RESERVE_"
local NO_PARAMETER_REMOVE = `"params":%s*%[%s*\n%s*{string.format("%q", NO_PARAMETER_RESERVED)}%s*\n%s*%]`

local function constructDocumentation(data: Types.Describable | any, _output: { [string]: any }?)
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

local function insertFunctionParameter(key: string, parameter: Types.ParameterData, keys: any, output)
	if parameter.Name == "self" then
		local parameterKey = if parameter.Name == "self" then key:match("^(.*)%..-$") else nil
		if parameterKey then
			table.insert(keys, {
				name = parameter.Name,
				documentation = parameterKey,
			})
			return
		end
	end

	local parameterKey = `{key}/params/{#keys}`
	local parameterDocumentation = constructDocumentation(parameter)

	if next(parameterDocumentation) or parameter.Name == "self" then
		output[parameterKey] = parameterDocumentation
		table.insert(keys, {
			name = parameter.Name,
			documentation = parameterKey,
		})
	else
		table.insert(keys, {
			name = parameter.Name,
		})
	end
end

local function insertFunctionReturn(key: string, returnValue: Types.ParameterData, keys: any, output)
	local returnKey = `{key}/returns/{#keys}`
	local returnDocumentation = constructDocumentation(returnValue)

	output[returnKey] = returnDocumentation
	table.insert(keys, returnKey)
end

local function documentFunction(key: string, data: Types.FunctionData, output)
	if output[key] then
		return output[key]
	end

	local functionDocumentation = constructDocumentation(data)

	if #data.Parameters > 0 then
		functionDocumentation.params = {}
		for _, parameter in data.Parameters do
			insertFunctionParameter(key, parameter, functionDocumentation.params, output)
		end
	elseif #data.Returns > 0 then
		functionDocumentation.params = { NO_PARAMETER_RESERVED }
	end

	if #data.Returns > 0 then
		functionDocumentation.returns = {}
		for _, returnValue in data.Returns do
			insertFunctionReturn(key, returnValue, functionDocumentation.returns, output)
		end
	end

	if next(functionDocumentation) then
		output[key] = functionDocumentation
	end

	return functionDocumentation
end

local function documentObject(object: Types.ObjectData, output)
	local objectKey = `@roblox/globaltype/{object.Name}`

	local keys = {}

	for _, member in object.Members :: any do
		local memberKey = `@roblox/globaltype/{member.Source}.{member.Name}`

		if member.Source == object.Name then
			local memberDocumentation = if member.Group == "Methods"
				then documentFunction(memberKey, member.Reference, output)
				else constructDocumentation(member.Reference)

			output[memberKey] = memberDocumentation
			if next(output[memberKey]) then
				keys[member.Name] = memberKey
			end
		end
	end

	output[objectKey] = constructDocumentation(object, { keys = keys })
end

local Documentation = {}

function Documentation.generate()
	local output = {}

	for name, data in PilotData.Functions do
		local key = `@roblox/global/{name}`
		documentFunction(key, data, output)
	end

	for name, dictionary in PilotData.FunctionDictionaries do
		local baseKey = `@roblox/global/{name}`
		local keys = {}

		for functionName, data in dictionary.Functions do
			local key = `{baseKey}.{functionName}`
			table.insert(keys, key)
			documentFunction(key, data, output)
		end

		output[baseKey] = constructDocumentation(dictionary, { keys = keys })
	end

	for name, data in PilotData.Values do
		local key = `@roblox/global/{name}`
		output[key] = constructDocumentation(data)
	end

	for _, objectName in PilotData.ObjectDefinitionOrder do
		documentObject(PilotData.Objects[objectName], output)
	end

	return output
end

function Documentation.save(options, generatedData)
	local jsonData = serde.encode("json", generatedData, true):gsub(NO_PARAMETER_REMOVE, '"params": []')

	fs.writeFile(`{options.o}/{options["types-dir"]}/documentation.d.json`, jsonData)
end

return Documentation
