local serde = require("@lune/serde")
local net = require("@lune/net")
local fs = require("@lune/fs")

local Utility = {}

function Utility.formatTime(seconds: number): string
	return if seconds < 0.0001
		then string.format("%.2f µs", seconds * 1e6)
		elseif seconds < 1 then string.format("%.2f ms", seconds * 1e3)
		elseif seconds < 60 then string.format("%.2f s", seconds)
		else string.format("%d min %.2f s", seconds // 60, seconds % 60)
end

function Utility.indent(value: string?, amount: number?): string
	if value == nil or value:match("^%s*$") then -- entirely whitespace
		return ""
	end

	local indentString = string.rep("\t", amount or 1)
	return indentString .. value:gsub("\n", "\n" .. indentString):gsub("\n%s+\n", "\n\n")
end

function Utility.escapeMarkdown(input: string): string
	return (input:gsub("<code>(.-)</code>", "`%1`"):gsub("<", "\\<"):gsub("{", "\\{"))
end

function Utility.markdownDropdown(dropdown: string, content: string?): string?
	return if content then `<details>\n\t<summary>{dropdown}</summary>\n{Utility.indent(content)}\n</details>` else nil
end

function Utility.deepClone(original, cache)
	cache = cache or {}

	if type(original) ~= "table" then
		return original
	elseif cache[original] then
		return cache[original]
	end

	local copy = {}
	cache[original] = copy
	for k, v in original do
		copy[Utility.deepClone(k, cache)] = Utility.deepClone(v, cache)
	end

	setmetatable(copy, Utility.deepClone(getmetatable(original), cache))

	return copy
end

function Utility.deepFreeze(t)
	table.freeze(t)
	for _, value in t do
		if typeof(value) == "table" and not table.isfrozen(value) then
			Utility.deepFreeze(value)
		end
	end
end

function Utility.makeDirectory(dir)
	if not fs.isDir(dir) then
		fs.writeDir(dir)
	end
end

function Utility.stripFileExtension(filename: string)
	return filename:match("^(.*)%..-$") or filename
end

function Utility.pathJoiner(root)
	if not root:match("%$") then
		root ..= "/"
	end

	return function(path)
		return if path then root .. if path:match("^/") then path:sub(2) else path else root
	end
end

function Utility.writeConfigurationFile(
	path: string,
	format: serde.EncodeDecodeFormat,
	values: { [any]: any },
	shallow: boolean?
)
	if fs.isFile(path) then
		local currentValueIsValid, currentValue = pcall(serde.decode, format, fs.readFile(path))
		if currentValueIsValid and currentValue then
			if shallow then
				for existingKey, existingValue in currentValue do
					if values[existingKey] ~= nil then
						continue
					end
					values[existingKey] = existingValue
				end
			else
				Utility.mergeTables(currentValue, values)
			end
		end
	end

	fs.writeFile(path, serde.encode(format, values, true))
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
