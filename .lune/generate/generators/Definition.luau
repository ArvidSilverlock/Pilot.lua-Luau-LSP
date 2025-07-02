local fs = require("@lune/fs")
local serde = require("@lune/serde")

local luauTypes = require("../modules/LuauType")
local Snippet = require("../modules/Snippet")

local partDocumentation = serde.decode("yaml", fs.readFile("documentation/documentation.yaml")) :: any

local Definition = {}

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

local function writeTypeGroup(snippet, key: string, value: any, context: string)
	if value.hydrator and value.hydrator.name == "get-part" then
		value = deepClone(value)

		local hydrator = value.hydrator
		value.hydrator = nil

		value.intersection = {}

		local initial = if hydrator.port
			then {
				{
					name = "port",
					["nullable-type"] = "PortLike",
				},
			}
			else {}

		for className, class in partDocumentation.classes do
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
			table.insert(value.intersection, {
				["function"] = {
					parameters = parameters,
					returns = if hydrator.multiple
						then { { ["array-type"] = className } }
						else { { type = className } },
				},
			})
		end

		do
			local parameters = table.clone(initial)
			table.insert(parameters, { name = "class", type = "string" })
			table.insert(value.intersection, {
				["function"] = {
					parameters = parameters,
					returns = if hydrator.multiple
						then { { ["array-type"] = "PilotObject" } }
						else { { type = "PilotObject" } },
				},
			})
		end
	end

	local typeState = luauTypes.getTypeState(value, {
		isRoot = true,
		name = key,
		context = context,
		define = true,
	})

	if typeState then
		luauTypes.writeFromState(snippet, typeState)
	else
		for childName, child in value do
			writeTypeGroup(snippet, childName, child, context)
		end
	end
end

function Definition.generate(options)
	local snippet = Snippet.new()

	local configurationTypes = {}

	writeTypeGroup(snippet, "globals", partDocumentation.globals, "declaration")
	writeTypeGroup(snippet, "types", partDocumentation.types, "type")

	local independentClasses = {}
	local inheritanceDependencies = {}
	local classSnippets = {}

	for className, class in partDocumentation.classes do
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
				configurationTypes[configurationTypeName] = {
					documentation = `The configuration of the <code>{className}</code> object.`,
					type = { [{ "string" }] = { type = "any" } }, -- yeah, i know
				}

				for configurable, configurableData in hydrator.configurables do
					reformattedClass.class[configurable] = configurableData
					configurationTypes[configurationTypeName].type[configurable] =
						luauTypes.setNullable(configurableData, true)
				end

				reformattedClass.class.Configure = {
					documentation = "A method to configure the object, will yield untill specified string configurables are filtered.",
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

			reformattedClass.class.ClassName = { ["string-type"] = hydrator["class-name"] or className }
		else
			reformattedClass.class.ClassName = { ["string-type"] = className }
		end

		local inheritanceSource = if hydrator.extends
			then (
				if typeof(hydrator.extends) == "table"
					then hydrator.extends[1] --[[sorry]]
					else hydrator.extends
			)
			elseif not hydrator.abstract then "PilotObject"
			else nil

		reformattedClass.extends = inheritanceSource

		local classSnippet = Snippet.new()
		writeTypeGroup(classSnippet, className, reformattedClass, "class")
		classSnippets[className] = classSnippet

		if inheritanceSource then
			if inheritanceDependencies[inheritanceSource] then
				table.insert(inheritanceDependencies[inheritanceSource], className)
			else
				inheritanceDependencies[inheritanceSource] = { className }
			end
		else
			table.insert(independentClasses, className)
		end
	end

	local classStack = table.clone(independentClasses)

	while #classStack > 0 do
		local currentClass = table.remove(classStack)
		local classSnippet = classSnippets[currentClass]

		snippet:Push(tostring(classSnippet))

		local dependantClasses = inheritanceDependencies[currentClass]
		if dependantClasses then
			table.move(dependantClasses, 1, #dependantClasses, #classStack + 1, classStack)
		end
	end

	writeTypeGroup(snippet, "configurations", configurationTypes, "type")

	return tostring(snippet)
end

function Definition.save(options, generatedData)
	fs.writeFile(`{options.o}/{options["types-dir"]}/global.d.luau`, generatedData)
end

return Definition
