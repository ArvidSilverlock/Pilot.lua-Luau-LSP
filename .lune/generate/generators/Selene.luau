local serde = require("@lune/serde")
local fs = require("@lune/fs")

local PilotData = require("../object-data/Pilot")
local Types = require("../modules/Types")

local Selene = {}

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

local function implementFunction(output, name, data)
	local globalFunction = { args = {} }

	if #data.Parameters > 0 then
		for _, argument in data.Parameters do
			if argument.Name == "..." then
				table.insert(globalFunction.args, { type = "..." })
			else
				local luauType, isNullable
				if argument.Type:match("^%b()%s*%?$") then
					luauType, isNullable = argument.Type:match("^%b()"):sub(2, -2), true
				else
					luauType, isNullable = argument.Type:match("^(.-)(%??)$")
				end

				local trimmed = luauType:match("^%s*(.-)%s*$")
				local isFunction = luauType:match("%b()%s*%->%s*.*") ~= nil

				table.insert(globalFunction.args, {
					type = if isFunction
						then "function"
						elseif table.find(VALID_SELENE_TYPES, trimmed) then trimmed
						else { display = trimmed },
					required = if not isNullable then false else nil,
				})
			end
		end
	else
		table.insert(globalFunction.args, NO_PARAMETER_RESERVED)
	end

	output.globals[name] = globalFunction
end

function Selene.generate(options)
	local output = {
		base = "roblox",
		globals = {},
	}

	for name, data in PilotData.Functions do
		implementFunction(output, name, data)
	end

	for name, dictionary in PilotData.FunctionDictionaries do
		for functionName, data in dictionary.Functions do
			implementFunction(output, `{name}.{functionName}`, data)
		end
	end

	for name, data in PilotData.Values do
		output.globals[name] = { property = "read-only" }
		output.globals[`{name}.*`] = { type = "any" }
	end

	return output
end

function Selene.save(options, generatedData)
	local yamlData = serde.encode("yaml", generatedData, true):gsub(NO_PARAMETER_REMOVE, "args: []")
	fs.writeFile(`{options.o}/{options["types-dir"]}/pilot.yml`, yamlData)
end

return Selene
