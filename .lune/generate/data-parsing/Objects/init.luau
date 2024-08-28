--!strict

local ParseMiscellaneous = require("../../object-data/raw-pilot-data/Parse/Miscellaneous")
local Read = require("../../object-data/raw-pilot-data/ReadRaw")

local Utility = require("../../modules/Utility")
local Types = require("../../modules/Types")

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

function Objects.parse(input: Types.RawPilotData, output: Types.PilotData)
	local objects = {}
	output.Objects = objects
	output.ObjectDefinitionOrder = {}

	for objectName, value in Read.iterateObjects() do
		local objectData = value.data

		table.insert(output.ObjectDefinitionOrder, objectName)

		local inheritenceChain = Read.getInheritenceChain(objectName)

		local object = ParseMiscellaneous.describable(objectData, {
			Name = if not objectName:match("^[_%a][_%w]*$") then "_" .. objectName:gsub("[^%w_]", "") else objectName,
			ClassName = objectName,
			Group = value.category,

			Inherits = Read.getParentClasses(objectName),
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

		local isProgrammable = false
		for memberName, memberData in object.Members do
			if
				(memberName == "PilotObject" or memberData.Source ~= "PilotObject")
				and not (memberData.Group == "Events" and memberData.Reference.IsTemplate)
				and not (memberData.Group == "Configurables" or memberData.Group == "Properties")
			then
				if objectName == "Warhead" then
					print(memberName, memberData)
				end
				isProgrammable = true
				break
			end
		end

		object.IsProgrammable = isProgrammable

		Utility.deepFreeze(object)
	end
end

return Objects
