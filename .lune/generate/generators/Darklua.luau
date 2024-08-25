local fs = require("@lune/fs")

local Utility = require("../modules/Utility")

local Darklua = {}

function Darklua.save(options, generatedData)
	local darkluaConfig = {
		bundle = {
			require_mode = {
				name = "path",
			},
			excludes = {},
		},
	}

	for _, module in fs.readDir("./.lune/generate/modules") do
		table.insert(darkluaConfig.bundle.excludes, Utility.stripFileExtension(module))
	end

	Utility.writeConfigurationFile(`{options.o}/.darklua.json`, "json", darkluaConfig)
end

return Darklua
