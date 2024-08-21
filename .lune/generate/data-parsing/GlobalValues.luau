--!strict

local Parse = require("../object-data/raw-pilot-data/Parse")
local Types = require("../modules/Types")

local GlobalValues = {}

function GlobalValues.parse(input: Types.RawPilotData, output: Types.PilotData)
	output.Values = {}

	for name, data in input.globals.values do
		local luauType = Parse.parseType(data.type)
		output.Values[name] = Parse.parseDescribable(data, {
			Type = {
				Definition = `declare {name}: {luauType}`,
				Luau = luauType,
			},
			ReadOnly = data.readonly == true,
		})
	end
end

return GlobalValues
