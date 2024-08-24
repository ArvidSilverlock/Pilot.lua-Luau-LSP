--!strict

local ParseMiscellaneous = require("../object-data/raw-pilot-data/Parse/Miscellaneous")
local ParseType = require("../object-data/raw-pilot-data/Parse/Type")
local Types = require("../modules/Types")

local GlobalValues = {}

function GlobalValues.parse(input: Types.RawPilotData, output: Types.PilotData)
	output.Values = {}

	for name, data in input.globals.values do
		local luauType = ParseType.parse(data.type)
		output.Values[name] = ParseMiscellaneous.describable(data, {
			Type = {
				Definition = `declare {name}: {luauType}`,
				Luau = luauType,
			},
			ReadOnly = data.readonly == true,
		})
	end
end

return GlobalValues
