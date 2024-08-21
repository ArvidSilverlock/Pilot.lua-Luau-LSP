--!strict

local fs = require("@lune/fs")

local Utility = require("./Utility")
local Types = require("./Types")

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

local Parse = {}

function Parse.getObject(name)
	return assert(OBJECTS[name], `unknown object '{name}'`)
end

function Parse.parseParameter(value)
	local nameAndType, description
	if typeof(value) == "table" then
		nameAndType, description = value[1], value[2]
	else
		nameAndType, description = value, nil
	end

	local parameterName, typeString = nameAndType:match("^([_%a][_%w]*):%s*(.+)$")

	return {
		Name = parameterName,
		Type = typeString or nameAndType,
		Description = description,
	}
end

function Parse.iterateParentClasses(objectName: string)
	local object = Parse.getObject(objectName)
	local data = object.data

	local extends = if data.extends == nil and object.category == "objects"
		then { "PilotObject" }
		elseif typeof(data.extends) == "string" then { data.extends }
		elseif typeof(data.extends) == "table" then data.extends
		else {}

	return next, extends, nil
end

function Parse.describable(value, output: any?)
	if output then
		output.Description = value.description
		output.IsDeprecated = value.deprecated == true
		output.CodeSample = value.codesample
		output.LearnMoreLink = value.learnmore
		return output
	else
		return {
			Description = value.description,
			IsDeprecated = value.deprecated == true,
			CodeSample = value.codesample,
			LearnMoreLink = value.learnmore,
		}
	end
end

function Parse.iterateObjects()
	local remainingObjects = table.clone(OBJECTS)
	local name, object

	return function()
		while true do
			name, object = next(remainingObjects, name)
			if not name or not object then
				return
			end

			local canDefine = true
			for _, parentClass in Parse.iterateParentClasses(name) do
				if remainingObjects[parentClass] then
					canDefine = false
					break
				end
			end

			if canDefine then
				local returnName, returnObject = name, object
				remainingObjects[name] = nil
				name, object = nil
				return returnName, returnObject
			end
		end
	end
end

local inheritenceChainCache = {}

function Parse.getInheritenceChain(objectName: string)
	assert(OBJECTS[objectName], `unknown object {objectName}`)

	local queue = { objectName }
	local visited = {}

	local chain = {}

	while #queue > 0 do
		local node: string = table.remove(queue, 1) :: any

		if node ~= objectName then
			table.insert(chain, node)
		end

		for _, parentClass in Parse.iterateParentClasses(node) do
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

function Parse.parseType(input)
	return input
end

return Parse
