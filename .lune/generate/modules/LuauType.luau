local luauTypes = {}

export type TypeStyle = "type" | "function" | "union" | "intersection"

export type Context = {
	style: TypeStyle,
	isMethod: boolean,
	isNullable: boolean,
	isString: boolean,
	isOpenString: boolean,
	isArray: boolean,
	isSparseArray: boolean,
}

export type TypeGroup = {
	key: string,
	value: any,
	context: Context,
	generics: { any }?,
	genericDefinitions: { any }?,
}

export type State = {
	base: TypeGroup,
	metatable: TypeGroup,
	self: TypeGroup,
	parent: State | RootState,
	isRoot: false,
	root: RootState,
	source: any,
}

export type TypeContext = "class" | "declaration" | "type"

export type RootState = {
	name: string,
	isRoot: true,
	context: TypeContext,
	define: boolean?,
}

local NULLABLE_MODIFIER = "nullable"
local STRING_MODIFIER = "string"
local ARRAY_MODIFIER = "array"

local OPEN_STRING_PREFIX = "open"
local SPARSE_ARRAY_PREFIX = "sparse"

local METATABLE_PREFIX = "metatable"
local SELF_PREFIX = "self"

local TYPE_STYLES = { "type", "function", "method", "union", "intersection", "class", "pack" }

local function getTypeStyle(values)
	for _, possibleTypeStyle in TYPE_STYLES do
		if table.find(values, possibleTypeStyle) then
			return possibleTypeStyle
		end
	end

	return nil
end

local function getContextTable(value, key, typeStyle, generics, genericDefinitions)
	local stringIndex = table.find(key, STRING_MODIFIER)
	local arrayIndex = table.find(key, ARRAY_MODIFIER)

	return {
		key = key,
		value = value,
		context = {
			style = if typeStyle == "method" then "function" else typeStyle,
			isMethod = typeStyle == "method",
			isNullable = table.find(key, NULLABLE_MODIFIER) ~= nil,
			isString = stringIndex ~= nil,
			isOpenString = stringIndex ~= nil and key[stringIndex - 1] == OPEN_STRING_PREFIX,
			isArray = arrayIndex ~= nil,
			isSparseArray = arrayIndex ~= nil and key[arrayIndex - 1] == SPARSE_ARRAY_PREFIX,
		},
		generics = generics,
		genericDefinitions = genericDefinitions,
	}
end

local function moveMerge(t, key, value)
	local output = t[key]
	if output then
		for subKey, subValue in value do
			assert(output[subKey] == nil, "duplicate keys")
			output[subKey] = subValue
		end
	else
		t[key] = value
	end
end

function luauTypes.getTypeState(source, parent: (State | RootState)?): State?
	local output: State = {} :: any

	for key, value in source do
		if key == METATABLE_PREFIX or key == SELF_PREFIX then
			assert(value.generics, "no generics table found")

			local typeKey = next(value, "generics") or next(value)

			if typeKey then
				local splitKey = typeKey:split("-")
				local typeStyle = getTypeStyle(splitKey)

				local bundled = getContextTable(value[typeKey], splitKey, typeStyle, value.generics)
				moveMerge(output, key, bundled)
			else
				moveMerge(output, key, { generics = value })
			end
		else
			local splitKey = key:split("-")
			local typeStyle = getTypeStyle(splitKey)

			if not typeStyle then
				continue
			end

			if splitKey[1] == METATABLE_PREFIX or splitKey[1] == SELF_PREFIX then
				local bundled = getContextTable(value, splitKey, typeStyle)
				moveMerge(output, splitKey[1], bundled)
			else
				local bundled =
					getContextTable(value, splitKey, typeStyle, source.generics, source["generic-definitions"])
				moveMerge(output, "base", bundled)
			end
		end
	end

	if next(output) then
		if parent then
			output.parent = parent
			output.root = if parent.isRoot then parent else parent.root
		end
		output.source = source
		return output
	else
		return nil
	end
end

function luauTypes.writeFromState(output, state: State)
	local context = state.base.context
	local source = state.source

	if state.parent.isRoot then
		if state.parent.define == false then
			local generics = state.base.genericDefinitions
			if generics then
				output:Push("<")
				for index, genericValue in generics do
					output:Push(genericValue.name)
					if index < #generics then
						output:Push(", ")
					end
				end
				output:Push(">")
			end
		elseif state.root.context == "type" then
			output:Push(if source.export ~= false then "export " else nil, "type ", state.root.name)
			local generics = state.base.genericDefinitions
			if generics then
				output:Push("<")
				for index, genericValue in generics do
					output:Push(genericValue.name)
					if next(genericValue, "name") or next(genericValue) then
						output:Push(" = ")
						luauTypes.write(output, genericValue, state)
					end
					if index < #generics then
						output:Push(", ")
					end
				end
				output:Push(">")
			end
			output:Push(" = ")
		elseif state.root.context == "class" then
			output:Push("declare class ", state.root.name)
			if source.extends then
				output:Push(" extends ", source.extends)
			end
			output:NewLine():Indent()
		elseif state.root.context == "declaration" then
			if context.style == "function" then
				output:Push("declare function ", state.root.name)
			else
				output:Push("declare ", state.root.name, ": ")
			end
		end
	end

	if state.metatable then
		local metatableContext = state.metatable.context

		output:PushLine("typeof(setmetatable("):Indent():Push("{} :: ")
		luauTypes[`write{context.style:gsub("^%l", string.upper)}`](output, state, state.base)
		output:Push(",\n{} :: ")
		luauTypes[`write{metatableContext.style:gsub("^%l", string.upper)}`](output, state, state.metatable)
		output:Dedent():NewLine():Push("))")
	else
		luauTypes[`write{context.style:gsub("^%l", string.upper)}`](output, state, state.base)
	end

	if state.parent.isRoot then
		if state.root.context == "class" then
			output:Dedent():PushLine("end")
		else
			output:NewLine()
		end
	end
end

function luauTypes.write(output, source: any, parent: State)
	local state = assert(luauTypes.getTypeState(source, parent), "no context found")
	luauTypes.writeFromState(output, state)
end

local function writeKey(output, key: { string } | string)
	if typeof(key) == "table" then
		assert(#key == 1 and typeof(key[1]) == "string", "malformed indexer")
		output:Push("[", key[1], "]: ")
	elseif typeof(key) == "string" then
		if key:match("^[_%a][_%w]*$") then
			output:Push(key, ": ")
		else
			output:Push("[", string.format("%q", key), "]: ")
		end
	else
		error("invalid luau key")
	end
end

function luauTypes.writeType(output, state: State, group: TypeGroup)
	local value, context = group.value, group.context

	if context.isArray then
		output:Push("{ ")
	end

	if context.isString then
		if typeof(value) == "string" then
			output:Push(string.format("%q", value))
		else
			error("expected a string literal")
		end
	else
		if typeof(value) == "string" or typeof(value) == "boolean" then
			output:Push(tostring(value))

			if group.generics then
				output:Push("<")
				for index, subValue in group.generics do
					luauTypes.write(output, subValue, state)
					if index < #group.generics then
						output:Push(", ")
					end
				end
				output:Push(">")
			end
		elseif typeof(value) == "table" then
			output:PushLine("{"):Indent()
			for key, subValue in value do
				writeKey(output, key)
				luauTypes.write(output, subValue, state)
				output:PushLine(",")
			end
			output:Dedent():Push("}")
		else
			error("expected a string literal or dictionary")
		end
	end

	if context.isArray then
		if context.isSparseArray then
			output:Push("?")
		end
		output:Push(" }")
	end

	if context.isNullable then
		output:Push("?")
	end
end

function luauTypes.writePack(output, state: State, group: TypeGroup)
	local parameters = state.base.value

	output:Push("(")
	for index, parameter in parameters do
		luauTypes.write(output, parameter, state)
		if index < #parameters then
			output:Push(", ")
		end
	end
	output:Push(")")
end

local function getParameters(state: State, group: TypeGroup)
	if not state.base.context.isMethod then
		return group.value.parameters
	end

	local node = state
	local previous
	while node ~= nil and not node.isRoot and not node.self do
		node, previous = node.parent, node
	end

	local parameters = if group.value.parameters then table.clone(group.value.parameters) else {}

	if node and node.isRoot then
		local generics
		if previous.base.genericDefinitions then
			generics = {}
			for _, generic in previous.base.genericDefinitions do
				table.insert(generics, { type = generic.name })
			end
		end

		table.insert(parameters, 1, {
			name = "self",
			type = node.name,
			generics = generics,
		})
	elseif node then
		local selfType = node.self

		local keyTable = table.clone(selfType.key)
		if keyTable[1] == SELF_PREFIX then
			table.remove(keyTable, 1)
		end
		local key = table.concat(keyTable, "-")

		table.insert(parameters, 1, {
			name = "self",
			[key] = selfType.value,
			generics = selfType.generics,
		})
	else
		table.insert(parameters, 1, { name = "self", type = "unknown" })
	end

	return parameters
end

function luauTypes.writeFunction(output, state: State, group: TypeGroup)
	local value, context = group.value, group.context
	assert(not context.isString, "you cannot have a string literal function")

	local isDirectlyUnderRoot = if state.root.context == "declaration"
		then state.parent and state.parent.isRoot
		else state.parent and (state :: any).parent.parent and (state :: any).parent.parent.isRoot
	local isClassMethod = isDirectlyUnderRoot and state.root.context ~= "type"

	local needsBrackets = not state.parent.isRoot
		and (state.parent.base.context.style == "union" or state.parent.base.context.style == "intersection")

	local parameters = getParameters(state, group)
	local returns = value.returns

	if needsBrackets then
		output:Push("(")
	end

	output:Push("(")

	if parameters and #parameters > 0 then
		for index, parameter in parameters do
			local shouldWriteType = if isClassMethod then parameter.name ~= "self" else true

			if isClassMethod then
				output:Push(parameter.name)
			elseif parameter.name == "..." then
				output:Push("...")
			elseif parameter.name then
				output:Push(parameter.name)
			end

			if shouldWriteType then
				if parameter.name and (isClassMethod or parameter.name ~= "...") then
					output:Push(": ")
				end
				luauTypes.write(output, parameter, state)
			end

			if index < #parameters then
				output:Push(", ")
			end
		end
	end

	if isClassMethod then
		output:Push("): ")
	else
		output:Push(") -> ")
	end

	if returns and #returns > 0 then
		output:Push("(")

		for index, returnValue in returns do
			if returnValue.name == "..." then
				output:Push("...")
			end
			luauTypes.write(output, returnValue, state)
			if index < #returns then
				output:Push(", ")
			end
		end

		output:Push(")")
	else
		output:Push("()")
	end

	if needsBrackets then
		output:Push(")")
	end

	if context.isNullable then
		output:Push("?")
	end
end

function luauTypes.writeUnion(output, state: State, group: TypeGroup)
	local value, context = group.value, group.context
	local parent = state.parent

	if context.isArray then
		output:Push("{ ")
		if context.isSparseArray then
			output:Push("(")
		end
	elseif parent and parent.style == "intersection" then
		output:Push("(")
		if context.isNullable then
			output:Push("(")
		end
	elseif context.isNullable then
		output:Push("(")
	end

	if context.isString then
		for index, subValue in value do
			output:Push(string.format("%q", subValue))
			if context.isOpenString or index < #value then
				output:Push(" | ")
			end
		end

		if context.isOpenString then
			output:Push("string")
		end
	else
		for index, subValue in value do
			luauTypes.write(output, subValue, state)
			if index < #value then
				output:Push(" | ")
			end
		end
	end

	if context.isArray then
		if context.isSparseArray then
			output:Push(")?")
		end
		output:Push(" }")
	elseif parent and parent.style == "intersection" then
		output:Push(")")
	elseif context.isNullable then
		output:Push(")")
	end

	if context.isNullable then
		output:Push("?")
	end
end

function luauTypes.writeIntersection(output, state: State, group: TypeGroup)
	local value, context = group.value, group.context

	assert(not context.isString, "you cannot have a string literal intersection")

	local parent = state.parent

	if context.isArray then
		output:Push("{ ")
		if context.isSparseArray then
			output:Push("(")
		end
	elseif context.isNullable or (parent and parent.style == "union") then
		output:Push("(")
	end

	for index, type in value do
		luauTypes.write(output, type, state)
		if index < #value then
			output:Push(" & ")
		end
	end

	if context.isArray then
		if context.isSparseArray then
			output:Push(")?")
		end
		output:Push(" }")
	elseif parent and parent.style == "union" then
		output:Push(")")
	end

	if context.isNullable then
		output:Push("?")
	end
end

function luauTypes.writeClass(output, state: State, group: TypeGroup)
	local value = group.value

	assert(state.parent.isRoot, "classes must be defined as the root")

	for key, member in value do
		local memberState = assert(luauTypes.getTypeState(member, state), "no context found")

		if memberState.base.context.style == "function" and memberState.base.context.isMethod then
			assert(
				typeof(key) == "string" and key:match("^[_%a][_%w]*$"),
				"class methods must have valid luau identifiers as keys"
			)
			output:Push("function ", key)
		else
			writeKey(output, key)
		end

		luauTypes.writeFromState(output, memberState)
		output:NewLine()
	end
end

function luauTypes.setNullable(type, nullable: boolean)
	local typeState = luauTypes.getTypeState(type)
	if typeState.base.context.isNullable == nullable then
		return table.clone(type)
	end

	local currentKey = typeState.base.key
	local newKey = table.clone(currentKey)

	if nullable then
		table.insert(newKey, 1, NULLABLE_MODIFIER)
	else
		local index = table.find(newKey, NULLABLE_MODIFIER)
		if index then
			table.remove(newKey, index)
		end
	end

	local typeCopy = table.clone(type)

	local currentKeyString = table.concat(currentKey, "-")
	local newKeyString = table.concat(newKey, "-")

	typeCopy[newKeyString] = typeCopy[currentKeyString]
	typeCopy[currentKeyString] = nil

	return typeCopy
end

return luauTypes
