local net = require("@lune/net")
local serde = require("@lune/serde")
local fs = require("@lune/fs")

local GLOBAL_DOCUMENTATION = {
	GetPart = "Gets a part of the specified type from any connected ports.",
	GetPartFromPort = "Gets a part of the specified type from any port of the specified ID.",
	GetParts = "Gets all the parts of the specified type from any connected ports.",
	GetPartsFromPort = "Gets all the parts of the specified type from any port of the specified ID.",
	GetPort = "Gets the connected port of the specified ID.",
	GetPorts = "Gets all the connected ports of the specified ID.",
	SandboxID = "The GUID of the microcontroller the program is running in.",
	SandboxRunID = "A unique ID for the current running program, is chosen when the microcontroller is turned on.",
	TriggerPort = "Triggers the specified port.",
	JSONEncode = "Encodes JSON.",
	JSONDecode = "Decodes JSON.",
	Beep = "Produces a beep sound using a triangle wave.",
	pilot = {
		description = "",
		keys = {
			saveRing = "Creates a function which elevates the caller to the specified (or current) ring regardless of its privilege. You can use this to de-escalate, spawn a new thread, and then re-escalate your thread after. Requires ring 0 or lower.",
			getTimeout = "Gets the current CPU timeout, or the CPU timeout that the given thread will obey.",
			setTimeout = "Sets the CPU timeout of the given thread. Requires ring -1 or lower. This will not let you exceed the game's timeout, but will let you set lower timeouts. This has to do with whatever thread happens to be actively running. Currently there is not a way for you to recover from a timeout, so you should use .setInterrupt to handle your own custom timeouts.",
			getCPUTime = "Returns the current elapsed CPU time.",
			setRing = "Sets the ring of the target (or running) thread. You can use .saveRing to store the current ring so you can escalate again later.",
			hasRing = "Checks if the target (or running) thread has the specified ring privilege or lower.",
			getRing = "Gets the ring of the target (or running) thread.",
			getThreadParent = "Gets the parent of the target (or running) thread. The parent thread must be part of the sandbox and may not exist on a lower ring otherwise nil will be returned.",
			claimThread = "Sets the thread's parent to the running thread. The target thread must be part of the sandbox and may not exist on a lower ring otherwise nothing will happen.",
		},
	},
}

local PART_DATA
do
	local data = net.request("https://raw.githubusercontent.com/Eggs-D-Studios/Dependancies/main/PartData.json")
	if not data.ok then
		return 1
	end

	PART_DATA = net.jsonDecode(data.body)
end

local function sanitiseName(name: string): string
	return if name:match("^%d") then "_" .. name else name
end

local generalTypeDefinitions = {}
local objectDefinitions = { Normal = {}, Simple = {} }
local categories = {}
local objects = {}
local objectCategories = {}
local objectNameCategories = {}
local partGetters = {}

local documentation = {}

do -- Global Documentation
	for globalName, data in GLOBAL_DOCUMENTATION do
		if type(data) == "table" then
			local keys = {}

			for key, description in data.keys do
				documentation[`@roblox/globaltype/{globalName}.{key}`] = {
					documentation = description,
				}
				keys[key] = `@roblox/globaltype/{globalName}.{key}`
			end

			documentation[`@roblox/globaltype/{globalName}`] = {
				documentation = data.description,
				keys = keys,
			}
		else
			documentation[`@roblox/global/{globalName}`] = {
				documentation = data,
			}
		end
	end
end

do -- Object Parsing
	for unsanitisedName, object in PART_DATA do
		local typeName = sanitiseName(unsanitisedName)
		local className = string.format("%q", unsanitisedName)

		table.insert(objects, { className, typeName })

		local sections = {}

		local objectDocumentation = {}

		if object.ProgrammableEvents then
			local methods = {}

			for _, methodName in object.ProgrammableEvents do
				table.insert(methods, `\tfunction {methodName}(self, ...: any): (...any)`)
			end

			table.insert(sections, table.concat(methods, "\n"))
		end

		if object.ConfigData then
			local properties = {}
			local configure = {}

			table.insert(configure, `\tfunction Configure(self, properties: \{`)

			for _, configuration in object.ConfigData do
				local name, configType, _, data, description = unpack(configuration)

				local luauType = configType
				if configType == "Selection" and type(data) == "table" then
					luauType = typeName .. name:gsub(typeName, "")
					table.insert(generalTypeDefinitions, `export type {luauType} = "{table.concat(data, '" | "')}"`)
				elseif configType == "Coordinate" or configType == "NumberRange" or configType == "ResourceString" then
					luauType = "string"
				end

				table.insert(configure, `\t\t{name}: {luauType}?,`)
				table.insert(properties, `\t{name}: {luauType}`)

				if configType == "number" or configType == "Vector3" then
					local extraDescription = `**Range:** {data[1]} to {data[2]}`
						.. if data[3] then `\n\n**Default:** {data[3]}` else ""
					description = if description then description .. "\n\n" .. extraDescription else extraDescription
				end

				objectDocumentation[name] = description
			end

			table.insert(configure, `\t\})`)

			table.insert(sections, table.concat(configure, "\n"))
			table.insert(sections, 1, table.concat(properties, "\n"))
		end

		if object.Categories then
			for _, category in object.Categories do
				if categories[category] then
					table.insert(categories[category], typeName)
				else
					categories[category] = { typeName }
				end
			end
		end

		if #sections > 0 then
			table.insert(
				objectDefinitions.Normal,
				table.concat({
					`declare class {typeName} extends PilotObject`,
					`\tClassName: {className}`,
					"",
					table.concat(sections, "\n\n"),
					`end`,
				}, "\n")
			)
		else
			table.insert(
				objectDefinitions.Simple,
				`declare class {typeName} extends PilotObject ClassName: {className} end`
			)
		end

		if next(objectDocumentation) then
			local keys = {}

			for key, description in objectDocumentation do
				documentation[`@roblox/globaltype/{typeName}.{key}`] = {
					documentation = description,
				}
				keys[key] = `@roblox/globaltype/{typeName}.{key}`
			end

			documentation[`@roblox/globaltype/{typeName}`] = {
				documentation = object.Description,
				keys = keys,
			}
		end
	end
end

do -- Category Types
	local singular = {
		Electrical = "Electrical",
		Resources = "Resource",
		Templates = "Template",
		Tools = "Tool",
		Weapons = "Weapon",
		Logic = "Logic",
		Propulsion = "Propulsion",
	}

	for category, objectNames in categories do
		local sanitised = table.create(#objectNames)
		for index, value in objectNames do
			sanitised[index] = sanitiseName(value)
		end

		local strings = table.create(#objectNames)
		for index, value in objectNames do
			strings[index] = string.format("%q", value)
		end

		local categoryName = singular[category]

		table.insert(objectCategories, `export type {categoryName}Objects = {table.concat(sanitised, " | ")}`)
		table.insert(objectNameCategories, `export type {categoryName}ObjectNames = {table.concat(strings, " | ")}`)
	end
end

do -- Part Getter Functions
	table.sort(objects, function(a, b)
		return a[1] < b[1]
	end)

	for _, callbackName in
		{
			"GetPart",
			"GetPartFromPort",
			"GetParts",
			"GetPartsFromPort",
		}
	do
		local first = objects[1]
		local lines = {
			`declare {callbackName}:`,
			`\t  _{callbackName}<{first[1]}, {first[2]}>`,
		}

		for index = 2, #objects do
			local value = objects[index]
			table.insert(lines, `\t& _{callbackName}<{value[1]}, {value[2]}>`)
		end
		table.insert(lines, `\t& _{callbackName}<string?, PilotObject>`)

		table.insert(partGetters, table.concat(lines, "\n"))
	end
end

table.sort(objectCategories)
table.sort(objectNameCategories)
table.sort(objectDefinitions.Normal)
table.sort(objectDefinitions.Simple)
table.sort(generalTypeDefinitions)

fs.writeFile("pilot/global.d.luau", (fs.readFile("pilot/generate/types.txt")
	:gsub(
		"-- Insert: General Types",
		table.concat({
			table.concat(generalTypeDefinitions, "\n"),
			table.concat(objectCategories, "\n"),
			table.concat(objectNameCategories, "\n"),
		}, "\n\n")
	)
	:gsub(
		"-- Insert: Part Types",
		table.concat({
			table.concat(objectDefinitions.Normal, "\n\n"),
			table.concat(objectDefinitions.Simple, "\n"),
		}, "\n\n")
	)
	:gsub(
		"-- Insert: Globals",
		table.concat({
			table.concat(partGetters, "\n\n"),
		}, "\n\n")
	)))

fs.writeFile("pilot/documentation.d.json", serde.encode("json", documentation, true))
