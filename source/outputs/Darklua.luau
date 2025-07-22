local fs = require("@lune/fs")

local Utility = require("../modules/Utility")

local Darklua = {}

function Darklua.save(options, _generatedData)
	local darkluaConfig = {
		bundle = {
			require_mode = {
				name = "path",
				use_luau_configuration = true,
			},
			excludes = {},
		},
		rules = {
			"remove_types",
			"remove_comments",
		},
	}

	for _, module in fs.readDir("./documentation/modules") do
		table.insert(darkluaConfig.bundle.excludes, Utility.stripFileExtension(module))
	end

	Utility.writeConfigurationFile(`{options.o}/.darklua.json`, "json", darkluaConfig)
end

return Darklua
