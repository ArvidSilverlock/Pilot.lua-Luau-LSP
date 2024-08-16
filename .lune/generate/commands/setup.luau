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

local function replaceFile(from: string, to: string)
	if fs.isFile(to) then
		fs.removeFile(to)
	end

	fs.copy(from, to)
end

return function()
	makeDirectory("./workspace")
	makeDirectory("./workspace/.vscode")
	makeDirectory("./workspace/types")
	makeDirectory("./workspace/types/modules")

	replaceFile(`.lune/generate/pilot.yml`, `./workspace/pilot.yml`)
	replaceFile(`.lune/generate/selene.toml`, `./workspace/selene.toml`)

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
