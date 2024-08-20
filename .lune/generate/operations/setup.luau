local serde = require("@lune/serde")
local net = require("@lune/net")
local fs = require("@lune/fs")

local Utility = require("../Utility")

local repos = {
	selene = "Kampfkarren/selene",
	darklua = "seaofvoices/darklua",
}

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
	local typesDirectory = options["types-dir"]

	local path = pathJoiner(options.o)
	local typesPath = pathJoiner(path(typesDirectory))

	makeDirectory(path())

	local vscodeSettings = {}

	if options.luaulsp then
		makeDirectory(typesPath())
		makeDirectory(typesPath("modules"))

		local fileRequireAliases = {}
		for _, module in fs.readDir("./.lune/generate/modules") do
			local modulePath = typesPath(`modules/{module}`)
			if fs.isFile(modulePath) then
				fs.removeFile(modulePath)
			end

			fileRequireAliases[stripFileExtension(module)] = `./{typesDirectory}/modules/{module}`
			fs.copy(`./.lune/generate/modules/{module}`, modulePath)
		end

		Utility.mergeTables({
			["luau-lsp.sourcemap.enabled"] = false,
			["luau-lsp.completion.imports.suggestServices"] = false,
			["luau-lsp.platform.type"] = "roblox",
			["luau-lsp.types.definitionFiles"] = { `./{typesDirectory}/global.d.luau` },
			["luau-lsp.types.documentationFiles"] = { `./{typesDirectory}/documentation.d.json` },
			["luau-lsp.require.fileAliases"] = fileRequireAliases,
		}, vscodeSettings)
	end

	if options.selene then
		writeConfigurationFile(path("selene.toml"), "toml", {
			std = `luau+{typesDirectory}/pilot`,
		})
	end

	if options.darklua then
		local darkluaConfig = {
			bundle = {
				require_mode = {
					name = "path",
				},
				excludes = {},
			},
		}

		for _, module in fs.readDir("./.lune/generate/modules") do
			table.insert(darkluaConfig.bundle.excludes, stripFileExtension(module))
		end

		writeConfigurationFile(path("darklua.json"), "json", darkluaConfig)
	end

	if options.rokit then
		local rokitConfig = { tools = {} }

		for toolName, repo in repos do
			if not options[toolName] then
				continue
			end

			local releaseTag = net.jsonDecode(net.request({
				url = `https://api.github.com/repos/{repo}/releases/latest`,
				method = "GET",
				headers = { ["Content-Type"] = "application/json" },
			}).body).tag_name

			rokitConfig.tools[toolName] = `{repo}@{releaseTag:gsub("^v", "")}`
		end

		writeConfigurationFile(path("rokit.toml"), "toml", rokitConfig)
	end

	if next(vscodeSettings) then
		makeDirectory(path(".vscode"))
		writeConfigurationFile(path(".vscode/settings.json"), "json", vscodeSettings)
	end

	return 0
end
