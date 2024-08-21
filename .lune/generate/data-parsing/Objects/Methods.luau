local Parse = require("../../modules/Parse")

local function ImplementMethods(objectName, output)
	local object = Parse.getObject(objectName)
	local objectData = object.data

	if not objectData.methods then
		return
	end

	local objectOutput = output[objectName]

	for name, data in objectData.methods do
		local method = Parse.describable(data, {
			Parameters = { { Name = "self", Type = objectName } },
			Returns = {},
		})

		local memberReference = {
			Name = name,
			Group = "Methods",
			Reference = method,
			Source = objectName,
		}

		if data.parameters then
			for _, parameter in data.parameters do
				table.insert(method.Parameters, Parse.parseParameter(parameter))
			end
		end

		if data.returns then
			for _, returnValue in data.returns do
				table.insert(method.Returns, Parse.parseParameter(returnValue))
			end
		end

		objectOutput.Members[name] = memberReference
		objectOutput.Methods[name] = method
	end
end

return ImplementMethods
