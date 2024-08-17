local fs = require("@lune/fs")
local serde = require("@lune/serde")

local Utility = require("../Utility")

local VSCODE_SETTINGS = {
	["luau-lsp.sourcemap.enabled"] = false,
	["luau-lsp.completion.imports.suggestServices"] = false,
	["luau-lsp.platform.type"] = "roblox",
	["luau-lsp.types.definitionFiles"] = { "./types/global.d.luau" },
	["luau-lsp.types.documentationFiles"] = { "./types/documentation.d.json" },
	["luau-lsp.require.fileAliases"] = {},
}

local SELENE_SETTINGS = {
	std = "luau+types/pilot",
}

local function stripFileExtensione(filename)
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

	makeDirectory(path())
	makeDirectory(path(".vscode"))
	makeDirectory(path("types"))
	makeDirectory(path("types/modules"))

	for _, module in fs.readDir("./.lune/generate/modules") do
		local modulePath = path(`types/modules/{module}`)
		if fs.isFile(modulePath) then
			fs.removeFile(modulePath)
		end

		VSCODE_SETTINGS["luau-lsp.require.fileAliases"][stripFileExtensione(module)] = `./types/modules/{module}`
		fs.copy(`./.lune/generate/modules/{module}`, modulePath)
	end

	writeConfigurationFile(path("selene.toml"), "toml", SELENE_SETTINGS)
	writeConfigurationFile(path(".vscode/settings.json"), "json", VSCODE_SETTINGS)

	return 0
end
