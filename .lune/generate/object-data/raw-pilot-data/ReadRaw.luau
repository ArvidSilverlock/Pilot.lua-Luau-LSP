--!strict

local PILOT_DATA = require("./RawData")

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

local inheritenceChainCache = {}
local inheritenceCache = {}

local PilotData = {}

function PilotData.getObject(name)
	return assert(OBJECTS[name], `unknown object '{name}'`)
end

function PilotData.getParentClasses(objectName: string)
	if inheritenceCache[objectName] then
		return inheritenceCache[objectName]
	end

	local object = PilotData.getObject(objectName)
	local data = object.data

	local extends = if data.extends == nil and object.category == "objects"
		then { "PilotObject" }
		elseif typeof(data.extends) == "string" then { data.extends }
		elseif typeof(data.extends) == "table" then data.extends
		else {}

	inheritenceCache[objectName] = extends

	return extends
end

function PilotData.iterateObjects(): () -> (string, { name: string, category: string, data: any })
	local remainingObjects = table.clone(OBJECTS)
	local name, object

	return function()
		while true do
			name, object = next(remainingObjects, name)
			if not name or not object then
				return nil :: any, nil :: any
			end

			local canDefine = true
			for _, parentClass in PilotData.getParentClasses(name) do
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

		for _, parentClass in PilotData.getParentClasses(node) do
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
