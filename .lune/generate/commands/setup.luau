local fs = require("@lune/fs")
local serde = require("@lune/serde")

local jsonSettings = {
	["luau-lsp.sourcemap.enabled"] = false,
	["luau-lsp.completion.imports.suggestServices"] = false,
	["luau-lsp.platform.type"] = "roblox",
	["luau-lsp.types.definitionFiles"] = { "./types/global.d.luau" },
	["luau-lsp.types.documentationFiles"] = { "./types/documentation.d.json" },
	["luau-lsp.require.directoryAliases"] = {
		[""] = "./types/modules",
	},
}

local function makeDirectory(dir)
	if not fs.isDir(dir) then
		fs.writeDir(dir)
	end
end

return function()
	makeDirectory("./workspace")
	makeDirectory("./workspace/.vscode")
	makeDirectory("./workspace/types")
	makeDirectory("./workspace/types/modules")

	fs.writeFile("./.lune/generate/pilot.yml", "./workspace/types/pilot.yml")

	if not fs.isFile("./workspace/selene.toml") then
		fs.writeFile(".lune/generate/selene.toml", "./workspace/selene.toml")
	else
		local seleneSettings = serde.decode("toml", fs.readFile(".lune/generate/selene.toml"))
		local mergedSettings = serde.decode("toml", fs.readFile("./workspace/selene.toml"))

		for key, value in seleneSettings do
			if not mergedSettings[key] then
				mergedSettings[key] = value
			end
		end

		fs.writeFile("./workspace/selene.toml", serde.encode("toml", mergedSettings, true))
	end

	for _, module in fs.readDir("./.lune/generate/modules") do
		if fs.isFile(`./workspace/types/modules/{module}`) then
			fs.removeFile(`./workspace/types/modules/{module}`)
		end

		fs.copy(`./.lune/generate/modules/{module}`, `./workspace/types/modules/{module}`)
	end

	if not fs.isFile("./workspace/.vscode/settings.json") then
		fs.writeFile("./workspace/.vscode/settings.json", serde.encode("json", jsonSettings, true))
	else
		local mergedSettings = serde.decode("json", fs.readFile("./workspace/.vscode/settings.json"))
		for key, value in jsonSettings do
			if typeof(value) == "table" and typeof((next(value))) == "number" then
				for _, subValue in value do
					if not table.find(mergedSettings[key], subValue) then
						table.insert(mergedSettings[key], subValue)
					end
				end
			else
				mergedSettings[key] = value
			end
		end
		fs.writeFile("./workspace/.vscode/settings.json", serde.encode("json", mergedSettings, true))
	end

	return 0
end
