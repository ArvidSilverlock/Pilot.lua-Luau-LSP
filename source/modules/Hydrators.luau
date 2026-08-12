local documentation = require("../modules/PilotDocumentation")
local luauTypes = require("../modules/LuauType")
local Utility = require("../modules/Utility")

local Hydrators = {}

function Hydrators.object(className: string, class: any, vanilla: boolean?)
	local reformattedClass = Utility.deepClone(class)
	local hydrator = reformattedClass.hydrator
	reformattedClass.hydrator = nil

	local resultingType = {}

	if typeof(hydrator) == "table" then
		if hydrator.events then
			for event, eventData in hydrator.events do
				eventData.generics = {
					{ ["string-type"] = event },
					{
						["function"] = {
							parameters = eventData.parameters,
						},
					},
				}
				eventData.type = "Event"
				eventData.parameters = nil
				resultingType[event] = eventData
			end
		end

		if hydrator.methods then
			for method, methodData in hydrator.methods do
				if methodData.overloads then
					methodData.intersection = {}
					for _, overload in methodData.overloads do
						table.insert(methodData.intersection, { method = overload })
					end
				else
					methodData.method = {
						parameters = methodData.parameters,
						returns = methodData.returns,
					}
				end

				methodData.overloads, methodData.parameters, methodData.returns = nil

				resultingType[method] = methodData
			end
		end

		if hydrator.properties then
			-- properties are read only configurables, so they cannot be assigned to
			for property, propertyData in hydrator.properties do
				resultingType[property] = luauTypes.setAccess(propertyData, "read")
			end
		end

		if hydrator.configurables then
			local configurationTypeName = className .. "Configuration"

			for configurable, configurableData in hydrator.configurables do
				resultingType[configurable] = configurableData
			end

			resultingType.Configure = {
				documentation = "A method to configure the object, will yield until specified string configurables are filtered.",
				method = {
					parameters = {
						{
							name = "configuration",
							documentation = "The configuration to apply to the object",
							type = configurationTypeName,
						},
					},
				},
			}
		end

		resultingType.ClassName = {
			documentation = "The name of the class of the object.",
			["read-string-type"] = hydrator["class-name"] or className,
		}
	else
		resultingType.ClassName =
			{ documentation = "The name of the class of the object.", ["read-string-type"] = className }
	end

	if vanilla then
		reformattedClass.intersection = { { type = resultingType } }
		if hydrator.extends then
			if typeof(hydrator.extends) == "table" then
				for _, source in hydrator.extends do
					table.insert(reformattedClass.intersection, 1, { type = source })
				end
			else
				table.insert(reformattedClass.intersection, 1, { type = hydrator.extends })
			end
		elseif not hydrator.abstract then
			table.insert(reformattedClass.intersection, 1, { type = "PilotObject" })
		end
	else
		reformattedClass.class = resultingType
		local inheritanceSource = if hydrator.extends
			then (
				if typeof(hydrator.extends) == "table"
					then hydrator.extends[1] -- sorry
					else hydrator.extends
			)
			elseif not hydrator.abstract then "PilotObject"
			else nil

		reformattedClass.extends = inheritanceSource
	end

	return reformattedClass
end

local OBJECT_MAP_TYPE = "PilotObjects"
local OBJECT_LOOKUP_TYPE_FUNCTION = "ObjectFromClassName"
local CLASS_NAME_GENERIC = "Name"

local OBJECT_LOOKUP_SOURCE = [[
export type function %s(objects: type, className: type, fallback: type)
	local tag = className.tag

	if tag == "singleton" then
		local object = objects:readproperty(className)
		if object then
			return object
		end
	elseif tag == "union" or tag == "intersection" then
		local objectsFound = {}
		for index, component in className:components() do
			objectsFound[index] = %s(objects, component, fallback)
		end

		return if tag == "union"
			then types.unionof(table.unpack(objectsFound))
			else types.intersectionof(table.unpack(objectsFound))
	elseif tag == "unknown" or tag == "nil" or tag == "any" then
		return fallback
	end

	print("this doesn't seem to be a valid object")

	return fallback
end
]]

Hydrators.objectMapType = OBJECT_MAP_TYPE
-- the name is needed twice, the second is the recursive call it makes for a union or intersection of class names
Hydrators.objectLookupTypeFunction =
	OBJECT_LOOKUP_SOURCE:format(OBJECT_LOOKUP_TYPE_FUNCTION, OBJECT_LOOKUP_TYPE_FUNCTION)

-- the map of every class the part getters can give you back, the `PilotObjects` type
function Hydrators.objectMap()
	local map = {}

	for className, class in documentation.classes do
		map[className] = { type = className }
	end

	return {
		documentation = "A map of every class of object that the part getters can narrow to, keyed by class name.",
		type = map,
	}
end

local function getPortParameters(hydrator)
	return if hydrator.port then { { name = "port", ["nullable-type"] = "PortLike" } } else {}
end

local function getGenericPart(copy, hydrator, functionType)
	local returnStyle = if hydrator.multiple then "array-type" else "nullable-type"
	local returnName = if hydrator.multiple then "objects" else "object"

	local namedParameters = getPortParameters(hydrator)
	table.insert(namedParameters, {
		name = "class",
		documentation = "The class of object to get, leaving it out gives you objects of any class.",
		union = {
			{ type = CLASS_NAME_GENERIC },
			{ type = "keyof", generics = { { type = OBJECT_MAP_TYPE } } },
		},
	})

	local namedReturn: any = {
		name = returnName,
		generics = {
			{ type = OBJECT_MAP_TYPE },
			{ type = CLASS_NAME_GENERIC },
			{ type = "PilotObject" },
		},
	}
	namedReturn[returnStyle] = OBJECT_LOOKUP_TYPE_FUNCTION

	local anyReturn: any = { name = returnName }
	anyReturn[returnStyle] = "PilotObject"

	copy.intersection = {
		{
			["generic-definitions"] = { { name = CLASS_NAME_GENERIC } },
			[functionType] = {
				parameters = namedParameters,
				returns = { namedReturn },
			},
		},
		{
			[functionType] = {
				parameters = getPortParameters(hydrator),
				returns = { anyReturn },
			},
		},
	}

	return copy
end

function Hydrators.getPart(value, accessSupported: boolean?)
	local copy = Utility.deepClone(value)

	local hydrator = copy.hydrator
	copy.hydrator = nil

	copy["function"] = nil
	copy.method = nil

	local functionType = if hydrator.method then "method" else "function"

	if accessSupported then
		return getGenericPart(copy, hydrator, functionType)
	end

	copy.intersection = {}

	local initial = if hydrator.port
		then {
			{
				name = "port",
				["nullable-type"] = "PortLike",
			},
		}
		else {}

	for className, class in documentation.classes do
		local parameters = table.clone(initial)
		table.insert(parameters, { name = "class", ["string-type"] = className })
		table.insert(copy.intersection, {
			[functionType] = {
				parameters = parameters,
				returns = if hydrator.multiple
					then { { ["array-type"] = className } }
					else { { ["nullable-type"] = className } },
			},
		})
	end

	return copy
end

function Hydrators.apply(value, accessSupported: boolean?)
	if not value.hydrator then
		return value
	end

	local name = value.hydrator.name
	if name == "get-part" then
		return Hydrators.getPart(value, accessSupported)
	end

	return value
end

return Hydrators
