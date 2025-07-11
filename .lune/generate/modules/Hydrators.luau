local documentation = require("../object-data/Pilot")

local Hydrators = {}

local function deepClone(original, cache)
	cache = cache or {}

	if type(original) ~= "table" then
		return original
	elseif cache[original] then
		return cache[original]
	end

	local copy = {}
	cache[original] = copy
	for k, v in original do
		copy[deepClone(k, cache)] = deepClone(v, cache)
	end

	setmetatable(copy, deepClone(getmetatable(original), cache))

	return copy
end

function Hydrators.object(className, class)
	local reformattedClass = deepClone(class)
	local hydrator = reformattedClass.hydrator
	reformattedClass.hydrator = nil

	reformattedClass.class = {}

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
				reformattedClass.class[event] = eventData
			end
		end

		if hydrator.methods then
			for method, methodData in hydrator.methods do
				methodData.method = {
					parameters = methodData.parameters,
					returns = methodData.returns,
				}
				methodData.parameters, methodData.returns = nil

				reformattedClass.class[method] = methodData
			end
		end

		if hydrator.properties then
			for property, propertyData in hydrator.properties do
				if typeof(propertyData.documentation) == "string" then
					propertyData.documentation = {
						description = propertyData.documentation,
						readonly = true,
					}
				elseif propertyData.documentation then
					propertyData.documentation.readonly = true
				else
					propertyData.documentation = { readonly = true }
				end

				reformattedClass.class[property] = propertyData
			end
		end

		if hydrator.configurables then
			local configurationTypeName = className .. "Configuration"

			for configurable, configurableData in hydrator.configurables do
				reformattedClass.class[configurable] = configurableData
			end

			reformattedClass.class.Configure = {
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

		reformattedClass.class.ClassName = {
			documentation = "The name of the class of the object.",
			["string-type"] = hydrator["class-name"] or className,
		}
	else
		reformattedClass.class.ClassName =
			{ documentation = "The name of the class of the object.", ["string-type"] = className }
	end

	local inheritanceSource = if hydrator.extends
		then (
			if typeof(hydrator.extends) == "table"
				then hydrator.extends[1] -- sorry
				else hydrator.extends
		)
		elseif not hydrator.abstract then "PilotObject"
		else nil

	reformattedClass.extends = inheritanceSource

	return reformattedClass
end

function Hydrators.getPart(value)
	local copy = deepClone(value)

	local hydrator = copy.hydrator
	copy.hydrator = nil

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
		if not class.hydrator or typeof(class.hydrator) ~= "table" then
			continue
		end

		local classHydrator = class.hydrator
		if
			not classHydrator.events
			and not classHydrator.methods
			and not classHydrator.properties
			and not classHydrator.configurables
		then
			continue
		end

		local parameters = table.clone(initial)
		table.insert(parameters, { name = "class", ["string-type"] = className })
		table.insert(copy.intersection, {
			["function"] = {
				parameters = parameters,
				returns = if hydrator.multiple then { { ["array-type"] = className } } else { { type = className } },
			},
		})
	end

	do
		local parameters = table.clone(initial)
		table.insert(parameters, { name = "class", type = "string" })
		table.insert(copy.intersection, {
			["function"] = {
				parameters = parameters,
				returns = if hydrator.multiple
					then { { ["array-type"] = "PilotObject" } }
					else { { type = "PilotObject" } },
			},
		})
	end

	return copy
end

return Hydrators
