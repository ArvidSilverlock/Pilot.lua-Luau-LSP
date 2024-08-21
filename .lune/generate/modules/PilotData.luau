--!strict

local PILOT_DATA = require("../object-data/PilotRaw")

-- stylua: ignore
local OBJECTS do
	OBJECTS = {}

	local function add(objectType)
		for objectName: any, objectData in PILOT_DATA.classes[objectType] do
			OBJECTS[objectName] = { name = objectName, data = objectData, category = objectType }
		end
	end

	add("abstractclasses")
	add("objects")
end

local PilotData = {}

function PilotData.getObject(name)
	return assert(OBJECTS[name], `unknown object '{name}'`)
end

function PilotData.iterateParentClasses(objectName: string)
	local object = PilotData.getObject(objectName)
	local data = object.data

	local extends = if data.extends == nil and object.category == "objects"
		then { "PilotObject" }
		elseif typeof(data.extends) == "string" then { data.extends }
		elseif typeof(data.extends) == "table" then data.extends
		else {}

	return next, extends, nil
end

function PilotData.iterateObjects()
	local remainingObjects = table.clone(OBJECTS)
	local name, object

	return function()
		while true do
			name, object = next(remainingObjects, name)
			if not name or not object then
				return
			end

			local canDefine = true
			for _, parentClass in PilotData.iterateParentClasses(name) do
				if remainingObjects[parentClass] then
					canDefine = false
					break
				end
			end

			if canDefine then
				local returnName = name
				remainingObjects[name], name = nil
				return returnName, object
			end
		end
	end
end

local inheritenceChainCache = {}
function PilotData.getInheritenceChain(objectName: string)
	assert(OBJECTS[objectName], `unknown object {objectName}`)

	local queue = { objectName }
	local visited = {}

	local chain = {}

	while #queue > 0 do
		local node: string = table.remove(queue, 1) :: any

		if node ~= objectName then
			table.insert(chain, node)
		end

		for _, parentClass in PilotData.iterateParentClasses(node) do
			if visited[parentClass] then
				error(`possibly cyclic inheritence chain {table.concat(chain, "->")}`)
			end

			visited[parentClass] = true

			local cached = inheritenceChainCache[parentClass]
			if cached then
				visited[parentClass] = true
				table.insert(chain, parentClass)

				for _, value in cached do
					visited[value] = true
					table.insert(chain, value)
				end
			else
				table.insert(queue, parentClass)
			end
		end
	end

	table.freeze(chain)

	inheritenceChainCache[objectName] = chain
	return chain
end

return PilotData
