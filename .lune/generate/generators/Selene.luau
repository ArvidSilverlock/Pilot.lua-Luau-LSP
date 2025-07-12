local serde = require("@lune/serde")
local fs = require("@lune/fs")

local PilotData = require("../object-data/Pilot")
local Utility = require("../modules/Utility")

local VALID_SELENE_TYPES = {
	"any",
	"bool",
	"function",
	"nil",
	"number",
	"string",
	"table",
	"...",
}

local NO_PARAMETER_RESERVED = "__RESERVE__NO_PARAMETERS___RESERVE_"
local NO_PARAMETER_REMOVE = `args:\n%s*%-%s*{string.format("%q", NO_PARAMETER_RESERVED):sub(2, -2)}`

local Selene = {}

function Selene.generate(options)
	local output = {
		base = "roblox",
		globals = {},
	}

	return output
end

function Selene.save(options, generatedData)
	local outputDirectory, typesDirectory = options.o, options["types-dir"]

	local yamlData = serde.encode("yaml", generatedData, true):gsub(NO_PARAMETER_REMOVE, "args: []")
	fs.writeFile(`{options.o}/{options["types-dir"]}/pilot.yml`, yamlData)

	Utility.writeConfigurationFile(`{outputDirectory}/selene.toml`, "toml", {
		std = `luau+{typesDirectory}/pilot`,
	})
end

return Selene
