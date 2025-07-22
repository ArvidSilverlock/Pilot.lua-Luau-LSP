local fs = require("@lune/fs")

local luauTypes = require("../modules/LuauType")
local Snippet = require("../modules/Snippet")
local hydrators = require("../modules/Hydrators")

local documentation = require("../modules/PilotDocumentation")

local Vanilla = {}

local function writeTypeGroup(
	snippet,
	key: string,
	value: any,
	context: luauTypes.TypeContext | "global",
	callback: any?
)
	if value.hydrator and value.hydrator.name == "get-part" then
		value = hydrators.getPart(value)
	end

	local typeState = luauTypes.getTypeState(value, {
		isRoot = true,
		name = key,
		context = if context ~= "global" then context else nil,
		define = true,
	})

	if typeState then
		if callback then
			callback(snippet, key, value, context)
		elseif context == "global" then
			snippet:Push(key, " = ( ", key, " :: any ) :: ")
			luauTypes.writeFromState(snippet, typeState)
			snippet:StripTrailingWhitespace()
			snippet:PushLine(",")
		else
			luauTypes.writeFromState(snippet, typeState)
		end
	else
		for childName, child in value do
			writeTypeGroup(snippet, childName, child, context, callback)
		end
	end
end

function Vanilla.generate(_options)
	local snippet = Snippet.new()

	local globalList: { string } = {}
	writeTypeGroup(snippet, "globals", documentation.globals, "global", function(_, key, _, _)
		table.insert(globalList, key)
	end)
	table.sort(globalList)

	snippet:PushLine("--!nolint UnknownGlobal")
	snippet:PushLine("-- PilotLua Globals: ", table.concat(globalList, ", "))

	writeTypeGroup(snippet, "types", documentation.types, "type")

	local independentClasses = {}
	local inheritanceDependencies = {}
	local classSnippets = {}

	for className, class in documentation.classes do
		local inheritanceSource = if not class.hydrator.abstract and not class.hydrator.extends
			then "PilotObject"
			elseif class.hydrator.extends then class.hydrator.extends[1]
			else nil
		local reformattedClass = hydrators.object(className, class, true)

		local classSnippet = Snippet.new()
		writeTypeGroup(classSnippet, className, reformattedClass, "type")
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

	writeTypeGroup(snippet, "configurations", documentation.configurations, "type")

	snippet:PushLine("return setmetatable("):Indent():PushLine("{"):Indent()
	writeTypeGroup(snippet, "globals", documentation.globals, "global")
	snippet:Dedent():PushLine("},"):PushLine("{"):Indent():PushLine("__call = function(self)"):Indent():Push("return ")

	for index, global in globalList do
		snippet:Push("self.", global)
		if index == #globalList then
			snippet:NewLine()
		else
			snippet:Push(", ")
		end
	end

	snippet:Dedent():PushLine("end"):Dedent():PushLine("}"):Dedent():PushLine(")")

	return tostring(snippet)
end

function Vanilla.save(options, generatedData)
	fs.writeFile(options["vanilla-output"], generatedData)
end

return Vanilla
