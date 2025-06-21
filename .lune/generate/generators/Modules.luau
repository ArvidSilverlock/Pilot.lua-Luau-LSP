local fs = require("@lune/fs")

local Utility = require("../modules/Utility")

local MODULE_SOURCE_DIRECTORY = "./.lune/generate/object-data/pilot-modules"

local Modules = {}

function Modules.save(options)
	local outputDirectory, typesDirectory = options.o, options["types-dir"]
	local modulesDirectory = `{outputDirectory}/{typesDirectory}/modules`

	if not fs.isDir(modulesDirectory) then
		fs.writeDir(modulesDirectory)
	end

	local fileRequireAliases = {}
	for _, module in fs.readDir(MODULE_SOURCE_DIRECTORY) do
		local modulePath = `{outputDirectory}/{typesDirectory}/modules/{module}`
		local filePath

		if fs.isFile(modulePath) then
			fs.removeFile(modulePath)
			filePath = `./{typesDirectory}/modules/{module}`
		elseif fs.isDir(modulePath) then
			fs.removeDir(modulePath)
			filePath = `./{typesDirectory}/modules/{module}/init.luau`
		end

		fileRequireAliases[Utility.stripFileExtension(module)] = filePath
		fs.copy(`{MODULE_SOURCE_DIRECTORY}/{module}`, modulePath)
	end

	Utility.writeConfigurationFile(`{options.o}/.luaurc`, "json", {
		aliases = {
			wos = `./{typesDirectory}/modules`,
		},
	})
end

return Modules
