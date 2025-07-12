local fs = require("@lune/fs")
local serde = require("@lune/serde")

local luauTypes = require("../modules/LuauType")
local hydrators = require("../modules/Hydrators")
local documentation = require("../object-data/Pilot")

local NO_PARAMETER_RESERVED = "__RESERVE__NO_PARAMETERS___RESERVE_"
local NO_PARAMETER_REMOVE = `"params":%s*{string.format("%q", NO_PARAMETER_RESERVED)}`

local function extractDescription(key, state, value)
	if not value.documentation then
		return nil
	elseif typeof(value.documentation) == "string" then
		return value.documentation
	elseif typeof(value.documentation) == "table" then
		return value.documentation.description
	else
		error(`Invalid documentation type: {typeof(value.documentation)}`)
	end
end

local documentFunctionParameters, documentType

function documentFunctionParameters(group: "parameters" | "returns", output, key, state)
	local list = {}

	if not state.base.value[group] then
		return list
	end

	local prefix
	local indexOffset = 1

	if group == "parameters" then
		prefix = `{key}/params`

		if state.base.context.isMethod then
			table.insert(list, {
				name = "self",
				documentation = key,
			})
			indexOffset = 0
		end
	else
		prefix = `{key}/returns`
	end

	for parameterIndex, parameter in state.base.value[group] do
		local substate = assert(luauTypes.getTypeState(parameter, state), key)

		local parameterKey = `{prefix}/{parameterIndex - indexOffset}`

		documentType(output, parameterKey, substate)

		if group == "parameters" then
			table.insert(list, {
				name = parameter.name or `parameter{parameterIndex}`,
				documentation = parameterKey,
			})
		else
			table.insert(list, parameterKey)
		end
	end

	return list
end

function documentType(output, key: string, state: luauTypes.State)
	local context = state.base.context
	local value = state.base.value

	if (context.style == "type" or context.style == "class") and typeof(value) == "table" then
		local keys = {}

		for memberName, memberValue in value do
			if typeof(memberName) ~= "string" then
				continue
			end

			local substate = assert(luauTypes.getTypeState(memberValue, state), key)

			local subkey = `{key}.{memberName}`
			documentType(output, subkey, substate)

			keys[memberName] = subkey
		end

		output[key] = {
			documentation = extractDescription(key, state, state.source),
			keys = if next(keys) then keys else nil,
		}
	elseif context.style == "function" then
		local parameters = documentFunctionParameters("parameters", output, key, state)
		local returns = documentFunctionParameters("returns", output, key, state)

		output[key] = {
			documentation = extractDescription(key, state, state.source),
			params = if next(parameters) then parameters else NO_PARAMETER_RESERVED,
			returns = if next(returns) then returns else nil,
		}
	else
		output[key] = {
			documentation = extractDescription(key, state, state.source),
		}
	end

	return { key }
end

local function writeTypeGroup(output, prefix: string, key: string, value: any, context: luauTypes.TypeContext)
	if value.hydrator and value.hydrator.name == "get-part" then
		value = hydrators.getPart(value)
	end

	local typeState = luauTypes.getTypeState(value, {
		isRoot = true,
		name = key,
		context = context,
		define = true,
	})

	if typeState then
		documentType(output, `{prefix}/{key}`, typeState)
	else
		for childName, child in value do
			writeTypeGroup(output, prefix, childName, child, context)
		end
	end
end

local Documentation = {}

function Documentation.generate()
	local output = {}

	writeTypeGroup(output, "@roblox/global", "globals", documentation.globals, "declaration")
	writeTypeGroup(output, "@roblox/globaltype", "types", documentation.types, "type")

	for className, class in documentation.classes do
		local reformattedClass = hydrators.object(className, class)
		writeTypeGroup(output, "@roblox/globaltype", className, reformattedClass, "class")
	end

	writeTypeGroup(output, "@roblox/globaltype", "configurations", documentation.configurations, "type")

	return output
end

function Documentation.save(options, generatedData)
	local jsonData = serde.encode("json", generatedData, true):gsub(NO_PARAMETER_REMOVE, '"params": []')
	fs.writeFile(`{options.o}/{options["types-dir"]}/documentation.d.json`, jsonData)
end

return Documentation
