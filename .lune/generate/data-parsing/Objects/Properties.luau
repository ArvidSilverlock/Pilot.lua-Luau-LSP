--!strict

local Parse = require("../../object-data/raw-pilot-data/ParseRaw")
local Read = require("../../object-data/raw-pilot-data/ReadRaw")

local Types = require("../../modules/Types")

local function ImplementProperties(objectName: string, output: { [string]: Types.ObjectData })
	local object = Read.getObject(objectName)
	local objectData = object.data

	if not objectData.properties then
		return
	end

	local objectOutput = output[objectName]

	for name, data in objectData.properties do
		local outputGroup = if data.readonly then "Properties" else "Configurables"

		local property: any = Parse.parseDescribable(data, {
			Type = Parse.parseType(data.type),
			ReadOnly = data.readonly == true,
		})

		local memberReference = {
			Name = name,
			Group = outputGroup,
			Reference = property,
			Source = objectName,
		}

		local constraints = data.constraints
		if constraints then
			property.Minimum = constraints.min
			property.Maximum = constraints.max
			property.Step = constraints.step
			property.Default = constraints.default
		end

		objectOutput.Members[name] = memberReference :: any;
		(objectOutput :: any)[outputGroup][name] = property
	end
end

return ImplementProperties
