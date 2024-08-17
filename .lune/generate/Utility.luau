local net = require("@lune/net")
local serde = require("@lune/serde")

local Utility = {}

function Utility.indent(value: string?, amount: number?): string
	if value == nil or value:match("^%s*$") then -- entirely whitespace
		return ""
	end

	local indentString = string.rep("\t", amount or 1)
	return indentString .. value:gsub("\n", "\n" .. indentString):gsub("\n%s+\n", "\n\n")
end

function Utility.readJSON(link: string)
	local response = net.request(link)
	return if response.ok then serde.decode("json", response.body) else nil
end

function Utility.sanitiseName(name: string): string
	return if name:match("^%d") then "_" .. name else name
end

function Utility.escapeMarkdown(input: string): string
	return (input:gsub("<", "\\<"):gsub("{", "\\{"))
end

function Utility.markdownDropdown(dropdown: string, content: string): string
	return `<details>\n\t<summary>{dropdown}</summary>\n{Utility.indent(content)}\n</details>`
end

return Utility
