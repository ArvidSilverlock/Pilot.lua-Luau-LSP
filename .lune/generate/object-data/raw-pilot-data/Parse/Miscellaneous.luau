local Utility = require("../../../modules/Utility")
local Types = require("../../../modules/Types")

local Miscellaneous = {}

function Miscellaneous.describable<T>(
	value: Types.DescribableRaw,
	_output: { [string]: any }?
): Types.Describable & { [string]: any }
	local output = (_output or {}) :: any

	output.Description = value.description
	output.Deprecated = if typeof(value.deprecated) == "string" then value.deprecated else value.deprecated == true
	output.CodeSample = value.codesample
	output.LearnMoreLink = value.learnmore

	return output :: any
end

function Miscellaneous.plainDescription(data: Types.Describable, markdown: boolean?): string?
	local description = if data.Description and not data.Description:match("^%s*$")
		then data.Description:match("^%s*(.-)%s*$")
		else nil

	return if markdown and description then Utility.escapeMarkdown(description) else description
end

return Miscellaneous
