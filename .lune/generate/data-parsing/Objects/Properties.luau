--!strict

local Parse = require("../../object-data/raw-pilot-data/ParseRaw")
local Read = require("../../object-data/raw-pilot-data/ReadRaw")

local function ImplementProperties(objectName, output)
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

		if data.constraints then
			property.Minimum = data.min
			property.Maximum = data.max
			property.Step = data.step
			property.Default = data.default
		end

		objectOutput.Members[name] = memberReference
		objectOutput[outputGroup][name] = property
	end
end

return ImplementProperties
