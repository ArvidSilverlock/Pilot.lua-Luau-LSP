local fs = require("@lune/fs")
local serde = require("@lune/serde")

local Utility = require("../modules/Utility")

local EXTENSIONS = {
	luaulsp = "JohnnyMorganz.luau-lsp",
	selene = "Kampfkarren.selene-vscode",
}

local VSCode = {}

function VSCode.save(options)
	local typesDirectory = options["types-dir"]
	local path = Utility.pathJoiner(options.o)

	local recommendedExtensions = {}

	table.insert(recommendedExtensions, EXTENSIONS.luaulsp)
	if options.selene then
		table.insert(recommendedExtensions, EXTENSIONS.selene)
	end

	Utility.makeDirectory(path(".vscode"))

	Utility.writeConfigurationFile(path(".vscode/settings.json"), "json", {
		["luau-lsp.sourcemap.enabled"] = false,
		["luau-lsp.completion.imports.suggestServices"] = false,
		["luau-lsp.platform.type"] = "roblox",
		["luau-lsp.types.definitionFiles"] = { `./{typesDirectory}/global.d.luau` },
		["luau-lsp.types.documentationFiles"] = { `./{typesDirectory}/documentation.d.json` },
	})

	Utility.writeConfigurationFile(path(".vscode/extensions.json"), "json", {
		recommendations = recommendedExtensions,
	})

	local snippetsContent = fs.readFile("./documentation/snippets.json")
	local snippets = serde.decode("json", snippetsContent)
	Utility.writeConfigurationFile(path(".vscode/*.code-snippets"), "json", snippets)
end

return VSCode
