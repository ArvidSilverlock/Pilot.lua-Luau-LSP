local Utility = require("../../modules/Utility")
local Parse = require("../../modules/Parse")

local implementProperties = require("./Properties")
local implementMethod = require("./Methods")
local implementEvent = require("./Events")

local function mergeObjects(sourceName: string, targetName: string, output)
	local sourceData = output[sourceName]
	local targetData = output[targetName]

	Utility.mergeTables(sourceData.Categories, targetData.Categories)

	for memberName, memberData in sourceData.Members do
		if memberData.Source == sourceName then
			targetData[memberData.Group][memberName] = memberData.Reference
			targetData.Members[memberName] = memberData
		end
	end
end

local Objects = {}

function Objects.parse(input, output)
	for objectName, objectData in Parse.iterateObjects() do
		local inheritenceChain = Parse.getInheritenceChain(objectName)

		local object = Parse.describable(objectData, {
			InheritenceChain = inheritenceChain,
			Categories = if objectData.categories then table.clone(objectData.categories) else {},
			Members = {},

			Methods = {},
			Properties = {},
			Configurables = {},
			Events = {},
		})

		output[objectName] = object

		for index = #inheritenceChain, 1, -1 do
			mergeObjects(inheritenceChain[index], objectName, output)
		end

		implementProperties(objectName, output)
		implementMethod(objectName, output)
		implementEvent(objectName, output)

		Utility.deepFreeze(object)
	end
end

return Objects
