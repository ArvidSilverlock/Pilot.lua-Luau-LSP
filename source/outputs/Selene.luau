local serde = require("@lune/serde")
local fs = require("@lune/fs")

local documentation = require("../modules/PilotDocumentation")
local Utility = require("../modules/Utility")
local luauTypes = require("../modules/LuauType")
local hydrators = require("../modules/Hydrators")
local Snippet = require("../modules/Snippet")

local VALID_SELENE_TYPES = {
	"any",
	"bool",
	"function",
	"nil",
	"number",
	"string",
	"table",
	"...",
}

local NO_PARAMETER_RESERVED = "__RESERVE__NO_PARAMETERS___RESERVE_"
local NO_PARAMETER_REMOVE = `args:\n%s*%-%s*{string.format("%q", NO_PARAMETER_RESERVED):sub(2, -2)}`

local Selene = {}

local function documentSeleneType(typeState): any
	local isOverloadedFunction = true
	if typeState.base.context.style == "intersection" then
		for _, intersection in typeState.base.value do
			local result = luauTypes.getTypeState(intersection, typeState)
			if not (result and result.base.context.style == "function") then
				isOverloadedFunction = false
				break
			end
		end
	else
		isOverloadedFunction = false
	end

	if isOverloadedFunction then
		return { args = { { type = "..." } } }
	elseif typeState.base.context.style == "function" then
		local functionDefinition: any = { args = {} }

		local parameters = typeState.base.value.parameters

		if parameters ~= nil and #parameters > 0 then
			for _, argument in parameters do
				if argument.Name == "..." then
					table.insert(functionDefinition.args, { type = "..." })
				else
					local parameterTypeState =
						assert(luauTypes.getTypeState(argument, typeState), "parameter has no type state")
					local typeContext = parameterTypeState.base.context

					table.insert(functionDefinition.args, {
						type = documentSeleneType(parameterTypeState),
						required = if typeContext.isNullable then false else nil,
					})
				end
			end
		else
			table.insert(functionDefinition.args, NO_PARAMETER_RESERVED)
		end

		return functionDefinition
	elseif typeState.base.context.style == "type" then
		if typeof(typeState.base.value) == "string" then
			local luauTypeSnippet = Snippet.new()
			luauTypes.write(luauTypeSnippet, luauTypes.setNullable(typeState.source, false), typeState)

			local trimmed = tostring(luauTypeSnippet):match("^%s*(.-)%s*$") :: string

			return {
				type = if table.find(VALID_SELENE_TYPES, trimmed) then trimmed else { display = trimmed },
			}
		else
			local dictionary = { property = "read-only" }

			for subkey, subvalue in typeState.base.value do
				local subTypeState = assert(luauTypes.getTypeState(subvalue, typeState), "parameter has no type state")
				dictionary[subkey] = documentSeleneType(subTypeState)
			end

			return dictionary
		end
	else
		return { property = "read-only", ["*"] = { any = true } }
	end
end

local function writeTypeGroup(output, key: string, value: any, context: luauTypes.TypeContext)
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
		output.globals[key] = documentSeleneType(typeState)
	else
		for childName, child in value do
			writeTypeGroup(output, childName, child, context)
		end
	end
end

function Selene.generate(_options)
	local output = {
		base = "roblox",
		name = "pilot",
		globals = {},
	}

	writeTypeGroup(output, "globals", documentation.globals, "type")

	return output
end

function Selene.save(options, generatedData)
	local outputDirectory, typesDirectory = options.o, options["types-dir"]

	local yamlData = serde.encode("yaml", generatedData, true):gsub(NO_PARAMETER_REMOVE, "args: []")
	fs.writeFile(`{options.o}/{options["types-dir"]}/pilot.yml`, yamlData)

	Utility.writeConfigurationFile(`{outputDirectory}/selene.toml`, "toml", {
		std = `luau+{typesDirectory}/pilot`,
	})
end

return Selene
