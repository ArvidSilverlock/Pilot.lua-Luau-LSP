local fs = require("@lune/fs")

local luauTypes = require("../modules/LuauType")
local Snippet = require("../modules/Snippet")
local hydrators = require("../modules/Hydrators")

local documentation = require("../modules/PilotDocumentation")

local Definition = {}

local function writeTypeGroup(snippet, key: string, value: any, context: luauTypes.TypeContext, accessSupported)
	local function apply(source)
		return hydrators.apply(source, accessSupported)
	end

	local typeState = luauTypes.getTypeState(value, {
		isRoot = true,
		name = key,
		context = context,
		define = true,
		accessSupported = accessSupported,
	}, apply)

	if typeState then
		luauTypes.writeFromState(snippet, typeState, apply)
	else
		for childName, child in apply(value) do
			writeTypeGroup(snippet, childName, child, context, accessSupported)
		end
	end
end

function Definition.generate(options)
	local snippet = Snippet.new()

	local accessSupported = options["new-solver"] == true

	if accessSupported then
		snippet:PushLine(hydrators.objectLookupTypeFunction)
		writeTypeGroup(snippet, hydrators.objectMapType, hydrators.objectMap(), "type", accessSupported)
	end

	writeTypeGroup(snippet, "globals", documentation.globals, "declaration", accessSupported)
	writeTypeGroup(snippet, "types", documentation.types, "type", accessSupported)

	local independentClasses = {}
	local inheritanceDependencies = {}
	local classSnippets = {}

	for className, class in documentation.classes do
		local reformattedClass = hydrators.object(className, class)

		local classSnippet = Snippet.new()
		writeTypeGroup(classSnippet, className, reformattedClass, "class", accessSupported)
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

	writeTypeGroup(snippet, "configurations", documentation.configurations, "type", accessSupported)

	return tostring(snippet)
end

function Definition.save(options, generatedData)
	fs.writeFile(`{options.o}/{options["types-dir"]}/global.d.luau`, generatedData)
end

return Definition
