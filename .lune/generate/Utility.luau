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

function Utility.mergeTables(from: { [any]: any }, into: { [any]: any })
	for key, value in from do
		if typeof(key) == "number" then
			if not table.find(into, value) then
				table.insert(into, value)
			end
		elseif typeof(value) == "table" and not into[key] then
			into[key] = value
		elseif typeof(value) == "table" and typeof(into[key]) == "table" then
			Utility.mergeTables(value, into[key])
		else
			into[key] = value
		end
	end

	return into
end

function Utility.joinPath(root, path)
	if not path or #path == 0 then
		return root
	end

	if not root:match("/$") then
		root ..= "/"
	end

	if path:match("^/") then
		path = path:sub(2)
	end

	return root .. path
end

function Utility.parseArguments(arguments: { string }, ...: string)
	local argumentedOptions = {}
	for index = 1, select("#", ...) do
		argumentedOptions[select(index, ...)] = true
	end

	local options = {}
	local index = 1
	while index <= #arguments do
		local argument = arguments[index]

		if argument:sub(1, 2) == "--" then
			local longOption = argument:sub(3)
			local option, value = longOption:match("^(.*)=(.*)$")
			if option and value then
				options[option] = value
			else
				options[longOption] = true
			end
		elseif argument:sub(1, 1) == "-" then
			local shortOptions = argument:sub(2)
			for shortOptionIndex = 1, #shortOptions do
				local option = shortOptions:sub(shortOptionIndex, shortOptionIndex)

				if argumentedOptions[option] then
					index += 1
					options[option] = arguments[index]
				else
					options[option] = true
				end
			end
		elseif options.other then
			table.insert(options.other, argument)
		else
			options.other = { argument }
		end

		index += 1
	end

	return options
end

return Utility
