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
		if fs.isFile(modulePath) then
			fs.removeFile(modulePath)
		end

		fileRequireAliases[Utility.stripFileExtension(module)] = `./{typesDirectory}/modules/{module}`
		fs.copy(`{MODULE_SOURCE_DIRECTORY}/{module}`, modulePath)
	end
end

return Modules
