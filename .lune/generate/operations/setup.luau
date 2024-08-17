local fs = require("@lune/fs")
local serde = require("@lune/serde")

local Utility = require("../Utility")

local function stripFileExtension(filename)
	return filename:match("^(.*)%..-$") or filename
end

local function makeDirectory(dir)
	if not fs.isDir(dir) then
		fs.writeDir(dir)
	end
end

local function writeConfigurationFile(path: string, format: serde.EncodeDecodeFormat, values: { [any]: any })
	if fs.isFile(path) then
		local currentValue = serde.decode(format, fs.readFile(path))
		Utility.mergeTables(currentValue, values)
	end

	fs.writeFile(path, serde.encode(format, values, true))
end

local function pathJoiner(root)
	if not root:match("%$") then
		root ..= "/"
	end

	return function(path)
		return if path then root .. if path:match("^/") then path:sub(2) else path else root
	end
end

return function(options)
	local path = pathJoiner(options.o)
	local typesPath = pathJoiner(path(options.types))

	makeDirectory(path())
	makeDirectory(path(".vscode"))
	makeDirectory(typesPath())
	makeDirectory(typesPath("modules"))

	local fileRequireAliases = {}
	for _, module in fs.readDir("./.lune/generate/modules") do
		local modulePath = typesPath(`modules/{module}`)
		if fs.isFile(modulePath) then
			fs.removeFile(modulePath)
		end

		fileRequireAliases[stripFileExtension(module)] = `./{options.types}/modules/{module}`
		fs.copy(`./.lune/generate/modules/{module}`, modulePath)
	end

	writeConfigurationFile(path("selene.toml"), "toml", {
		std = `luau+{options.types}/pilot`,
	})

	writeConfigurationFile(path(".vscode/settings.json"), "json", {
		["luau-lsp.sourcemap.enabled"] = false,
		["luau-lsp.completion.imports.suggestServices"] = false,
		["luau-lsp.platform.type"] = "roblox",
		["luau-lsp.types.definitionFiles"] = { `./{options.types}/global.d.luau` },
		["luau-lsp.types.documentationFiles"] = { `./{options.types}/documentation.d.json` },
		["luau-lsp.require.fileAliases"] = fileRequireAliases,
	})

	return 0
end
