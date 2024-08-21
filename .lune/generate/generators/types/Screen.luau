local RobloxAPIDump = require("../../object-data/Roblox")

local Types = require("../../modules/Types")

local function getLuauType(valueType)
	local category = valueType.Category
	local name = valueType.Name
	return if category == "Primitive"
		then (if name == "bool" then "boolean" elseif name == "string" then "string" else "number")
		elseif category == "Enum" then `Enum{name}`
		elseif category == "DataType" and name == "Content" then "string"
		else name
end

local function iterate(whitelist)
	return function(t, key)
		local value
		repeat
			key, value = next(t, key)
		until value == nil or whitelist(value)
		return key, value
	end
end

local function whitelistedIterate(t, whitelist)
	return iterate(whitelist), t
end

local function canWriteProperty(member)
	return member.MemberType == "Property"
		and member.Security.Write == "None"
		and (
			if member.Tags
				then not table.find(member.Tags, "ReadOnly") and not table.find(member.Tags, "Deprecated")
				else true
		)
end

local function parseClass(class, classes, types, methods, addMethod)
	local properties = {}

	if class.Members then
		for _, member in whitelistedIterate(class.Members, canWriteProperty) do
			local sanitisedName = if not member.Name:match("^[_%a][_%w]*$")
				then string.format("[%q]", member.Name)
				else member.Name
			table.insert(properties, `{sanitisedName}: {getLuauType(member.ValueType)}?`)
		end
	end

	-- Absolutely hideous code. Oh my god. What have I done.
	local superclass = class
	while classes[superclass.Superclass] do
		superclass = classes[superclass.Superclass]

		local hasProperties = false
		if superclass.Members then
			for _, member in whitelistedIterate(superclass.Members, canWriteProperty) do
				hasProperties = true
				break
			end
		end

		if hasProperties then
			break
		end
	end

	local propertiesSource = if superclass.Name ~= class.Name then superclass.Name else nil
	if #properties > 0 then
		table.insert(
			types,
			`export type {class.Name}Properties = \{ {table.concat(properties, ", ")} }{if propertiesSource then ` & {propertiesSource}Properties` else ""}`
		)
		propertiesSource = class.Name
	end

	if addMethod then
		table.insert(
			methods,
			`function CreateElement(self, className: "{class.Name}", properties: {propertiesSource}Properties?): {class.Name}`
		)
	end
end

local function isUserInterface(class)
	return class.MemoryCategory == "Gui"
		or class.Superclass == "UIComponent"
		or class.Superclass == "UILayout"
		or class.Superclass == "GuiLabel"
		or class.Superclass == "GuiObject"
		or class.Superclass == "UIBase"
		or class.Superclass == "UIConstraint"
		or class.Superclass == "GuiBase2d"
		or class.Superclass == "GuiButton"
		or class.Superclass == "GuiBase"
end

return function(valueType: "Function", name: string, data: Types.FunctionData, within: string?)
	assert(valueType == "Function", `the 'screen' generator only works for 'Function's, got '{valueType}'`)

	local types = {}
	local methods = {}

	local superClasses = {}
	local definedClasses = {}

	local classes = {}
	for _, class in RobloxAPIDump.Classes do
		classes[class.Name] = class
	end

	local isFirstPass = true
	repeat
		local additions = 0
		for className, class in classes do
			if
				isFirstPass and (class.Tags and table.find(class.Tags, "NotCreatable") or not isUserInterface(class))
			then
				continue
			elseif not isFirstPass and (definedClasses[className] or not superClasses[className]) then
				continue
			end

			superClasses[class.Superclass] = true
			definedClasses[className] = true

			parseClass(class, classes, types, methods, isFirstPass)
			additions += 1
		end
		isFirstPass = false
	until additions == 0

	local luauTypes = table.concat(types, "\n")
	local methodType = table.concat(methods, "\n")

	return {
		Definition = methodType,
		Luau = "-- N/A",
		InsertDefinition = function(output: Types.DefinitionOutput)
			table.insert(output.GlobalTypes, luauTypes)
		end,
	}
end
