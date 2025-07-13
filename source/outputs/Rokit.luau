local serde = require("@lune/serde")
local net = require("@lune/net")

local Utility = require("../modules/Utility")

local TOOL_REPOS = {
	selene = "Kampfkarren/selene",
	darklua = "seaofvoices/darklua",
}

local Rokit = {}

function Rokit.save(options)
	local rokitConfig = { tools = {} }

	for toolName, repo in TOOL_REPOS do
		if not options[toolName] then
			continue
		end

		local releaseTag = serde.decode(
			"json",
			net.request({
				url = `https://api.github.com/repos/{repo}/releases/latest`,
				method = "GET",
				headers = { ["Content-Type"] = "application/json" },
			}).body
		).tag_name

		rokitConfig.tools[toolName] = `{repo}@{releaseTag:gsub("^v", "")}`
	end

	Utility.writeConfigurationFile(`{options.o}/rokit.toml`, "toml", rokitConfig)
end

return Rokit
