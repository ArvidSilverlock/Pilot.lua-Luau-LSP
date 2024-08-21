local PilotData = require("../../modules/PilotData")
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
	local objects = {}
	output.Objects = objects

	for objectName, objectData in PilotData.iterateObjects() do
		local inheritenceChain = PilotData.getInheritenceChain(objectName)

		local object = Parse.parseDescribable(objectData, {
			InheritenceChain = inheritenceChain,
			Categories = if objectData.categories then table.clone(objectData.categories) else {},

			Members = {},

			Methods = {},
			Properties = {},
			Configurables = {},
			Events = {},
		})

		objects[objectName] = object

		for index = #inheritenceChain, 1, -1 do
			mergeObjects(inheritenceChain[index], objectName, objects)
		end

		implementProperties(objectName, objects)
		implementMethod(objectName, objects)
		implementEvent(objectName, objects)

		Utility.deepFreeze(object)
	end
end

return Objects
