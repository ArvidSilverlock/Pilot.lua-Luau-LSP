local documentation = require("../modules/PilotDocumentation")
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

				resultingType[property] = propertyData
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
			["string-type"] = hydrator["class-name"] or className,
		}
	else
		resultingType.ClassName =
			{ documentation = "The name of the class of the object.", ["string-type"] = className }
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

function Hydrators.getPart(value)
	local copy = Utility.deepClone(value)

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
				returns = if hydrator.multiple
					then { { ["array-type"] = className } }
					else { { ["nullable-type"] = className } },
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
