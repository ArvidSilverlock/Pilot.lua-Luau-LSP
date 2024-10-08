local RobloxAPIDump = require("../../object-data/Roblox")

local Utility = require("../../modules/Utility")
local Types = require("../../modules/Types")

local function getLuauType(valueType)
	local category = valueType.Category
	local name = valueType.Name
	return if category == "Primitive"
		then (if name == "bool" then "boolean" elseif name == "string" then "string" else "number")
		elseif category == "Enum" then `Enum.{name}`
		elseif category == "Class" then name
		elseif
			name == "Content"
			or name == "ContentId"
			or name == "BinaryString"
			or name == "SharedString"
			or name == "ProtectedString"
		then "string"
		elseif name == "OptionalCoordinateFrame" then "CFrame"
		elseif name == "Color3uint8" then "Color3"
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
				then not table.find(member.Tags, "ReadOnly")
					and not table.find(member.Tags, "Deprecated")
					and not table.find(member.Tags, "NotScriptable")
					and not table.find(member.Tags, "Hidden")
				else true
		)
end

local function parseClass(class, classes, types, methods, scrappedClasses, addMethod)
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
			`export type {class.Name}Properties = \{ {table.concat(properties, ", ")} }{if propertiesSource
				then ` & {propertiesSource}Properties`
				else ""}`
		)
		propertiesSource = class.Name
	end

	if addMethod then
		local formatted = string.format("%q", class.Name)
		if propertiesSource == "Instance" then
			table.insert(scrappedClasses, formatted)
		elseif methods[propertiesSource] then
			table.insert(methods[propertiesSource], formatted)
		else
			methods[propertiesSource] = { formatted }
		end
	end
end

return function(valueType: "Function", name: string, data: Types.FunctionData, within: string?)
	assert(valueType == "Function", `the 'screen' generator only works for 'Function's, got '{valueType}'`)

	local types = {}
	local methods = {}
	local scrappedClasses = {}

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
			if isFirstPass then
				if class.Tags and table.find(class.Tags, "NotCreatable") then
					continue
				elseif
					className:match("Options$")
					or className:match("Service$")
					or className:match("Controller$")
					or className:match("Description$")
					or className:match("^Wrap")
					or className:match("^Humanoid")
					or (class.Tags and table.find(class.Tags, "Deprecated"))
				then
					table.insert(scrappedClasses, string.format("%q", className))
					continue
				end
			elseif definedClasses[className] or not superClasses[className] then
				continue
			end

			superClasses[class.Superclass] = true
			definedClasses[className] = true

			parseClass(class, classes, types, methods, scrappedClasses, isFirstPass)
			additions += 1
		end
		isFirstPass = false
	until additions == 0

	local luauTypes = table.concat(types, "\n")

	local methodString = {}
	for source, subClasses in methods do
		table.insert(
			methodString,
			`_CreateElement<{table.concat(subClasses, " | ")}, {source}{if #subClasses > 1 then " & any" else ""}>`
		)
	end

	local anyMethod = `\n\t& _CreateElement<{table.concat(scrappedClasses, " | ")} | string, Instance & any>`
	local methodType = `CreateElement:\n{Utility.indent("  " .. table.concat(methodString, "\n& "))}` .. anyMethod

	return {
		Definition = methodType,
		Wiki = "- CreateElement(*string* className, *\\{ [string]: any }?* properties) → Instance"
			.. if data.Description then `\n  - {Utility.escapeMarkdown(data.Description)}` else "",
		Luau = "-- N/A",
		InsertDefinition = function(output: Types.DefinitionOutput)
			table.insert(output.GlobalTypes, luauTypes)
			table.insert(
				output.LocalTypes,
				"type _CreateElement<T, V> = (self: Screen, className: T, properties: InstanceProperties & { [string]: any }) -> V"
			)
		end,
		InsertVanilla = function(output: Types.DefinitionOutput)
			table.insert(output.GlobalTypes, luauTypes)
			table.insert(
				output.LocalTypes,
				"type _CreateElement<T, V> = (self: Screen, className: T, properties: InstanceProperties & { [string]: any }) -> V"
			)
		end,
	}
end
