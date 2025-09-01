local luauTypes = require("../../modules/LuauType")
local Snippet = require("../../modules/Snippet")

local escapeMarkdown = require("./EscapeMarkdown")

local LuauTypeStrings = {}

function LuauTypeStrings.getType(value)
	local output = Snippet.new()
	luauTypes.write(output, value, { isRoot = true, context = "type", define = false } :: any)
	return tostring(output):match("^%s*(.-)%s*$")
end

function LuauTypeStrings.getMarkdownType(value)
	return escapeMarkdown(
		(assert(LuauTypeStrings.getType(value), "no type to generate markdown of"):gsub("\n\t*", " "):gsub(", }", " }"))
	)
end

return LuauTypeStrings
