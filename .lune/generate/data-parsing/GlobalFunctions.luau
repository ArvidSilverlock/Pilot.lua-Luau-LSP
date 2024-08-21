--!strict

local Parse = require("../object-data/raw-pilot-data/Parse")
local Types = require("../modules/Types")

local GlobalFunctions = {}

function GlobalFunctions.parse(input: Types.RawPilotData, output: Types.PilotData)
	output.Functions = {}
	output.FunctionDictionaries = {}

	for name, data: any in input.globals.functions do
		if data.keys then
			local object = Parse.parseDescribable(data, {
				Functions = {},
			})

			for key, functionData in data.keys do
				object.Functions[key] = Parse.parseFunction(functionData, key, name, true)
			end

			output.FunctionDictionaries[name] = object
		else
			output.Functions[name] = Parse.parseFunction(data, name, nil, false)
		end
	end
end

return GlobalFunctions
