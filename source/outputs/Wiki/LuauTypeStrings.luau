local luauTypes = require("../../modules/LuauType")
local Snippet = require("../../modules/Snippet")

local escapeMarkdown = require("./EscapeMarkdown")

local LuauTypeStrings = {}

function LuauTypeStrings.getTypeFromState(state: luauTypes.State, group: luauTypes.TypeGroup?)
	local output = Snippet.new()
	luauTypes.writeFromState(output, state, nil, group or state.base)
	return tostring(output):match("^%s*(.-)%s*$")
end

local WIKI_ROOT = { isRoot = true, context = "type", define = false, accessSupported = true }

function LuauTypeStrings.getState(value)
	return assert(luauTypes.getTypeState(value, WIKI_ROOT :: any), "no context found")
end

function LuauTypeStrings.getType(value)
	return LuauTypeStrings.getTypeFromState(LuauTypeStrings.getState(value))
end

function LuauTypeStrings.getMarkdownType(value)
	return escapeMarkdown(
		(assert(LuauTypeStrings.getType(value), "no type to generate markdown of"):gsub("\n\t*", " "):gsub(", }", " }"))
	)
end

return LuauTypeStrings
