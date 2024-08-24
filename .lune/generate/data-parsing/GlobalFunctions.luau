--!strict

local ParseMiscellaneous = require("../object-data/raw-pilot-data/Parse/Miscellaneous")
local ParseFunction = require("../object-data/raw-pilot-data/Parse/Function")
local Types = require("../modules/Types")

local GlobalFunctions = {}

function GlobalFunctions.parse(input: Types.RawPilotData, output: Types.PilotData)
	output.Functions = {}
	output.FunctionDictionaries = {}

	for name, data: any in input.globals.functions do
		if data.keys then
			local object = ParseMiscellaneous.describable(data, {
				Functions = {},
			})

			for key, functionData in data.keys do
				object.Functions[key] = ParseFunction.parse(functionData, key, name, true, false)
			end

			output.FunctionDictionaries[name] = object
		else
			output.Functions[name] = ParseFunction.parse(data, name, nil, false, false)
		end
	end
end

return GlobalFunctions
