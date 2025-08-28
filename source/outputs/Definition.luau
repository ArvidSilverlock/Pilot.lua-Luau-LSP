local fs = require("@lune/fs")

local luauTypes = require("../modules/LuauType")
local Snippet = require("../modules/Snippet")
local hydrators = require("../modules/Hydrators")

local documentation = require("../modules/PilotDocumentation")

local Definition = {}

local function writeTypeGroup(snippet, key: string, value: any, context: luauTypes.TypeContext)
	local typeState = luauTypes.getTypeState(value, {
		isRoot = true,
		name = key,
		context = context,
		define = true,
	}, hydrators.apply)

	if typeState then
		luauTypes.writeFromState(snippet, typeState, hydrators.apply)
	else
		for childName, child in hydrators.apply(value) do
			writeTypeGroup(snippet, childName, child, context)
		end
	end
end

function Definition.generate(_options)
	local snippet = Snippet.new()

	writeTypeGroup(snippet, "globals", documentation.globals, "declaration")
	writeTypeGroup(snippet, "types", documentation.types, "type")

	local independentClasses = {}
	local inheritanceDependencies = {}
	local classSnippets = {}

	for className, class in documentation.classes do
		local reformattedClass = hydrators.object(className, class)

		local classSnippet = Snippet.new()
		writeTypeGroup(classSnippet, className, reformattedClass, "class")
		classSnippets[className] = classSnippet

		local inheritanceSource = reformattedClass.extends
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

	return tostring(snippet)
end

function Definition.save(options, generatedData)
	fs.writeFile(`{options.o}/{options["types-dir"]}/global.d.luau`, generatedData)
end

return Definition
