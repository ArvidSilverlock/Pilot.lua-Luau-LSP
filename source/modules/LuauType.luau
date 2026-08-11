local luauTypes = {}

export type TypeStyle = "type" | "function" | "union" | "intersection" | "class"

export type Access = "read" | "write"

export type Context = {
	style: TypeStyle,
	access: Access?,
	isMethod: boolean,
	isNullable: boolean,
	isString: boolean,
	isOpenString: boolean,
	isArray: boolean,
	isSparseArray: boolean,
}

export type TypeGroup = {
	key: { string },
	value: any,
	context: Context,
	generics: { any }?,
	genericDefinitions: { any }?,
}

export type State = {
	isRoot: false,
	base: TypeGroup,
	read: TypeGroup?,
	write: TypeGroup?,
	metatable: TypeGroup,
	self: TypeGroup,
	parent: State | RootState,
	root: RootState,
	source: any,
}

export type TypeContext = "class" | "declaration" | "type"

export type RootState = {
	isRoot: true,
	name: string,
	context: TypeContext?,
	define: boolean?,
	accessSupported: boolean?,
}

local NULLABLE_MODIFIER = "nullable"
local STRING_MODIFIER = "string"
local ARRAY_MODIFIER = "array"

local OPEN_STRING_PREFIX = "open"
local SPARSE_ARRAY_PREFIX = "sparse"

local METATABLE_PREFIX = "metatable"
local SELF_PREFIX = "self"

local READ_ACCESS = "read"
local WRITE_ACCESS = "write"

local TYPE_STYLES = { "type", "function", "method", "union", "intersection", "class", "pack" }

local Snippet = require("./Snippet")

local function getTypeStyle(values): string?
	for _, possibleTypeStyle in TYPE_STYLES do
		if table.find(values, possibleTypeStyle) then
			return possibleTypeStyle
		end
	end

	return nil
end

local function getAccess(values): Access?
	local isRead = table.find(values, READ_ACCESS) ~= nil
	local isWrite = table.find(values, WRITE_ACCESS) ~= nil

	assert(not (isRead and isWrite), "a type key cannot be both `read` and `write`")

	return if isRead then READ_ACCESS elseif isWrite then WRITE_ACCESS else nil
end

local function getContextTable(value, key, typeStyle, generics, genericDefinitions)
	local stringIndex = table.find(key, STRING_MODIFIER)
	local arrayIndex = table.find(key, ARRAY_MODIFIER)

	return {
		key = key,
		value = value,
		context = {
			style = if typeStyle == "method" then "function" else typeStyle,
			access = getAccess(key),
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

function luauTypes.getTypeState(source, parent: (State | RootState)?, hydratorCallback): State?
	local output: State = {} :: any

	if hydratorCallback then
		source = hydratorCallback(source)
	end

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
			local access = getAccess(splitKey)

			if not typeStyle then
				if not access then
					continue
				end

				-- `read` and `write` are shorthands for `read-type` and `write-type`
				typeStyle = "type"
			end

			if splitKey[1] == METATABLE_PREFIX or splitKey[1] == SELF_PREFIX then
				local bundled = getContextTable(value, splitKey, typeStyle)
				moveMerge(output, splitKey[1], bundled)
			else
				local bundled =
					getContextTable(value, splitKey, typeStyle, source.generics, source["generic-definitions"])
				moveMerge(output, access or "base", bundled)
			end
		end
	end

	assert(
		not output.metatable or output.metatable.context.access == nil,
		"`metatable` types cannot be `read` or `write`"
	)
	assert(not output.self or output.self.context.access == nil, "`self` types cannot be `read` or `write`")

	if output.read or output.write then
		assert(output.base == nil, "you cannot specify a `type` key alongside a `read` or `write` key")
		output.base = output.read or output.write
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

--[[
	The groups a member of a table (or of a class) is written from.

	This is a single group for ordinary members, but `read`/`write` members are written as one entry per access,
	as that is how luau represents them (i.e., `read foo: string, write foo: number`).
]]
function luauTypes.getAccessGroups(state: State): { TypeGroup }
	if not (state.read or state.write) then
		return { state.base }
	end

	local groups = {}

	if state.read then
		table.insert(groups, state.read)
	end
	if state.write then
		table.insert(groups, state.write)
	end

	return groups
end

local function withoutAccess(group: TypeGroup): TypeGroup
	local plainGroup = table.clone(group)
	plainGroup.context = table.clone(group.context)
	plainGroup.context.access = nil
	return plainGroup
end

--[[
	The groups that are actually written out for a member.

	Luau's old type solver (the one luau-lsp uses unless the new solver is opted into) rejects an entire definition
	file that has `read`/`write` in a table type, or that has both a `read` and a `write` for the same member. So,
	unless the root opted into the new solver (see `accessSupported`), those are collapsed into a single plain type.

	A lone `read`/`write` on a class member is written either way, as the old solver loads it (it just ignores it).
]]
function luauTypes.getOutputGroups(state: State, isClassMember: boolean?): { TypeGroup }
	local groups = luauTypes.getAccessGroups(state)

	if not (state.read or state.write) or (state.root and state.root.accessSupported) then
		return groups
	end

	if state.read and state.write then
		-- the type you are allowed to write keeps assignments (and `Configure` calls) working
		return { withoutAccess(state.write :: TypeGroup) }
	elseif isClassMember then
		return groups
	end

	return { withoutAccess(groups[1]) }
end

function luauTypes.writeFromState(output: Snippet.Snippet, state: State, hydratorCallback, group: TypeGroup?)
	if not group then
		assert(
			not (state.read or state.write),
			"`read` and `write` types can only be used on the members of a table type or of a class"
		)
		group = state.base
	end

	local context = (group :: TypeGroup).context
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
						luauTypes.write(output, genericValue, state, hydratorCallback)
					end
					if index < #generics then
						output:Push(", ")
					end
				end
				output:Push(">")
			end
			output:Push(" = ")
		elseif state.root.context == "class" then
			output:Push("declare extern type ", state.root.name)
			if source.extends then
				output:Push(" extends ", source.extends)
			end
			output:Push(" with")
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
		luauTypes[`write{context.style:gsub("^%l", string.upper)}`](output, state, group, hydratorCallback)
		output:Push(",\n{} :: ")
		luauTypes[`write{metatableContext.style:gsub("^%l", string.upper)}`](
			output,
			state,
			state.metatable,
			hydratorCallback
		)
		output:Dedent():NewLine():Push("))")
	else
		luauTypes[`write{context.style:gsub("^%l", string.upper)}`](output, state, group, hydratorCallback)
	end

	if state.parent.isRoot then
		if state.root.context == "class" then
			output:Dedent():PushLine("end")
		else
			output:NewLine()
		end
	end
end

function luauTypes.write(output: Snippet.Snippet, source: any, parent: State, hydratorCallback)
	local state = assert(luauTypes.getTypeState(source, parent, hydratorCallback), "no context found")
	luauTypes.writeFromState(output, state, hydratorCallback)
end

local function writeKey(output: Snippet.Snippet, key: { string } | string, access: Access?)
	if access then
		output:Push(access, " ")
	end

	if typeof(key) == "table" then
		local indexer = (key :: any)["!indexer"]
		for k, _ in key do
			if k ~= "!indexer" then
				error("malformed indexer")
			end
		end

		output:Push("[", indexer, "]: ")
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

function luauTypes.writeType(output: Snippet.Snippet, state: State, group: TypeGroup, hydratorCallback)
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
					luauTypes.write(output, subValue, state, hydratorCallback)
					if index < #group.generics then
						output:Push(", ")
					end
				end
				output:Push(">")
			end
		elseif typeof(value) == "table" then
			output:PushLine("{"):Indent()
			for key, subValue in value do
				local memberState =
					assert(luauTypes.getTypeState(subValue, state, hydratorCallback), "no context found")

				for _, memberGroup in luauTypes.getOutputGroups(memberState) do
					writeKey(output, key, memberGroup.context.access)
					luauTypes.writeFromState(output, memberState, hydratorCallback, memberGroup)
					output:PushLine(",")
				end
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

function luauTypes.writePack(output: Snippet.Snippet, state: State, group: TypeGroup, hydratorCallback)
	local parameters = group.value

	output:Push("(")
	for index, parameter in parameters do
		luauTypes.write(output, parameter, state, hydratorCallback)
		if index < #parameters then
			output:Push(", ")
		end
	end
	output:Push(")")
end

local function getParameters(state: State, group: TypeGroup)
	if not group.context.isMethod then
		return group.value.parameters
	end

	local node: RootState | State = state
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
	elseif node and not node.isRoot then
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

function luauTypes.writeFunction(output: Snippet.Snippet, state: State, group: TypeGroup, hydratorCallback)
	local value, context = group.value, group.context
	assert(not context.isString, "you cannot have a string literal function")

	local isDirectlyUnderRoot = if state.root.context == "declaration"
		then state.parent and state.parent.isRoot
		else state.parent and (state :: any).parent.parent and (state :: any).parent.parent.isRoot

	-- a `read`/`write` member of a class is written as a property, so it uses the function type syntax, not `function Name(self)`
	local isClassMethod = isDirectlyUnderRoot
		and (
			state.root.context == "declaration"
			or (state.root.context == "class" and context.isMethod and context.access == nil)
		)

	local needsBrackets = not state.parent.isRoot
		and (state.parent.base.context.style == "union" or state.parent.base.context.style == "intersection")

	local parameters = getParameters(state, group)
	local returns = value.returns

	if needsBrackets then
		output:Push("(")
	end

	-- a generic function writes its own generics, unless it is a root type, where they belong to the type itself
	local rootWroteGenerics = state.parent.isRoot and (state.parent.define == false or state.root.context == "type")

	if group.genericDefinitions and not rootWroteGenerics then
		output:Push("<")
		for index, genericValue in group.genericDefinitions do
			output:Push(genericValue.name)
			if index < #group.genericDefinitions then
				output:Push(", ")
			end
		end
		output:Push(">")
	end

	output:Push("(")

	if parameters and #parameters > 0 then
		for index, parameter in parameters do
			local shouldWriteType = if isClassMethod then parameter.name ~= "self" else true

			if isClassMethod or parameter.name ~= "..." then
				output:Push(parameter.name)
			else
				output:Push("...")
			end

			if shouldWriteType then
				if parameter.name and (isClassMethod or parameter.name ~= "...") then
					output:Push(": ")
				end
				luauTypes.write(output, parameter, state, hydratorCallback)
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
			luauTypes.write(output, returnValue, state, hydratorCallback)
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

function luauTypes.writeUnion(output: Snippet.Snippet, state: State, group: TypeGroup, hydratorCallback)
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
			luauTypes.write(output, subValue, state, hydratorCallback)
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

function luauTypes.writeIntersection(output: Snippet.Snippet, state: State, group: TypeGroup, hydratorCallback)
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
		luauTypes.write(output, type, state, hydratorCallback)
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

function luauTypes.writeClass(output: Snippet.Snippet, state: State, group: TypeGroup, hydratorCallback)
	local value = group.value

	assert(state.parent.isRoot, "classes must be defined as the root")

	for key, member in value do
		local memberState = assert(luauTypes.getTypeState(member, state, hydratorCallback), "no context found")

		for _, memberGroup in luauTypes.getOutputGroups(memberState, true) do
			local memberContext = memberGroup.context

			if memberContext.style == "function" and memberContext.isMethod and memberContext.access == nil then
				assert(
					typeof(key) == "string" and key:match("^[_%a][_%w]*$"),
					"class methods must have valid luau identifiers as keys"
				)
				output:Push("function ", key)
			else
				writeKey(output, key, memberContext.access)
			end

			luauTypes.writeFromState(output, memberState, hydratorCallback, memberGroup)
			output:NewLine()
		end
	end
end

function luauTypes.setNullable(type, nullable: boolean, hydratorCallback)
	local typeState = luauTypes.getTypeState(type, nil, hydratorCallback)
	local typeCopy = table.clone(type)

	for _, group in luauTypes.getAccessGroups(typeState) do
		if group.context.isNullable == nullable then
			continue
		end

		local currentKey = group.key
		local newKey = table.clone(currentKey)

		if nullable then
			table.insert(newKey, 1, NULLABLE_MODIFIER)
		else
			local index = table.find(newKey, NULLABLE_MODIFIER)
			if index then
				table.remove(newKey, index)
			end
		end

		local currentKeyString = table.concat(currentKey, "-")
		local newKeyString = table.concat(newKey, "-")

		typeCopy[newKeyString] = typeCopy[currentKeyString]
		typeCopy[currentKeyString] = nil
	end

	return typeCopy
end

--[[
	Returns a copy of `type` holding only the type you can `access`, written without the access modifier.

	This is for the places that need a plain type out of a `read`/`write` type, such as the configuration types,
	which are tables you write, and so are built out of the `write` type. If the type has no `access` type (i.e.,
	the write type of a read-only member) the type it does have is used, just without its access modifier.
]]
function luauTypes.collapseAccess(type, access: Access, hydratorCallback)
	local typeState = luauTypes.getTypeState(type, nil, hydratorCallback)

	if not (typeState.read or typeState.write) then
		return table.clone(type)
	end

	local group = (typeState :: any)[access] or typeState.read or typeState.write
	local typeCopy = table.clone(type)

	for _, accessGroup in luauTypes.getAccessGroups(typeState) do
		typeCopy[table.concat(accessGroup.key, "-")] = nil
	end

	local newKey = table.clone(group.key)

	local accessIndex = table.find(newKey, READ_ACCESS) or table.find(newKey, WRITE_ACCESS)
	if accessIndex then
		table.remove(newKey, accessIndex)
	end
	if not getTypeStyle(newKey) then
		-- `read` and `write` on their own are `read-type` and `write-type`, so they need the style putting back
		table.insert(newKey, "type")
	end

	typeCopy[table.concat(newKey, "-")] = group.value

	return typeCopy
end

function luauTypes.setAccess(type, access: Access, hydratorCallback)
	local typeState = luauTypes.getTypeState(type, nil, hydratorCallback)
	local groups = luauTypes.getAccessGroups(typeState)

	assert(#groups == 1, "you cannot set the access of a type that already has a separate `read` and `write` type")

	local group = groups[1]
	if group.context.access == access then
		return table.clone(type)
	end

	local currentKey = group.key
	local newKey = table.clone(currentKey)

	local currentAccess = table.find(newKey, READ_ACCESS) or table.find(newKey, WRITE_ACCESS)
	if currentAccess then
		table.remove(newKey, currentAccess)
	end
	table.insert(newKey, 1, access)

	local typeCopy = table.clone(type)

	local currentKeyString = table.concat(currentKey, "-")
	local newKeyString = table.concat(newKey, "-")

	typeCopy[newKeyString] = typeCopy[currentKeyString]
	typeCopy[currentKeyString] = nil

	return typeCopy
end

return luauTypes
