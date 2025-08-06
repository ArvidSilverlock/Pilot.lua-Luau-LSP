local Utility = require("../modules/Utility")

local EXTENSIONS = {
	luaulsp = "JohnnyMorganz.luau-lsp",
	selene = "Kampfkarren.selene-vscode",
}

-- group 1 is a prefix of characters to apply a case transformation to, you insert a space between group 2 & 3
local SPLIT_PASCAL_REGEX = "(.*?)([a-z]|[0-9](?=[a-z]|[A-Z])|[A-Z](?=[A-Z][a-z0-9]))([A-Z]|[0-9]*)?"

-- group 1 is the first word, group 2 is the rest of the pascal variable
local FIRST_PASCAL_FIRST_WORD_REGEX = "^([A-Z]+?)(?=[A-Z][a-z]|[a-z]|$)(.*)$"

local GET_PART_FORMAT = 'local %s = assert(GetPart("%s"), "%s")'
local GET_PORT_FORMAT = 'local %s = assert(GetPartFromPort(%s, "%s"), "%s")'

local REGEX_FORMAT = "${%%d/%s/%s/g}"
local PASCAL_TO_PRINTABLE = REGEX_FORMAT:format(SPLIT_PASCAL_REGEX, "${1:/downcase}${2:/downcase}${3:+ }${3:/downcase}")

local function getPascalCaseTransform(caseStyle)
	local pattern, replace

	if caseStyle == "snake" then
		pattern = SPLIT_PASCAL_REGEX
		replace = "${1:/downcase}${2:/downcase}${3:+_}${3:/downcase}"
	elseif caseStyle == "manual" then
		return "${1:screen}"
	elseif caseStyle == "pascal" then
		return "${1:Screen}"
	else -- default to camel
		pattern = FIRST_PASCAL_FIRST_WORD_REGEX
		replace = "${1:/downcase}${2}"
	end

	return REGEX_FORMAT:format(pattern, replace):format(1)
end

local function formatMessage(message, partPattern, portPattern)
	message = message:gsub("<part>", PASCAL_TO_PRINTABLE:format(partPattern))
	if portPattern then
		message = message:gsub("<port>", portPattern)
	end
	return message
end

local function getPartSnippet(casing, message, transformation)
	local partName, messageFormat

	if casing == "manual" then
		partName, messageFormat = "${2:Screen}", formatMessage(message, 2)
	else
		partName, messageFormat = "${1:Screen}", formatMessage(message, 1)
	end

	return GET_PART_FORMAT:format(transformation, partName, messageFormat)
end

local function getPartFromPortSnippet(casing, message, transformation)
	local portIndex, partType, messageFormat

	if casing == "manual" then
		portIndex, partType = "${3:1}", "${2:Screen}"
		messageFormat = formatMessage(message, 2, "${3}")
	else
		portIndex, partType = "${2:1}", "${1:Screen}"
		messageFormat = formatMessage(message, 1, "${2}")
	end

	return GET_PORT_FORMAT:format(transformation, portIndex, partType, messageFormat)
end

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

	local transformation = getPascalCaseTransform(options["snippet-casing"])

	local snippets = {
		GetPart = {
			prefix = "getpart",
			description = "Snippet to create a variable to get a part, asserting that it is connected.",
			scope = "luau,lua",
			body = {
				getPartSnippet(options["snippet-casing"], options["snippet-part-message"], transformation),
			},
		},
		GetPartFromPort = {
			prefix = "getport",
			description = "Snippet to create a variable to get a part from a port, asserting that it is connected.",
			scope = "luau,lua",
			body = {
				getPartFromPortSnippet(options["snippet-casing"], options["snippet-port-message"], transformation),
			},
		},
	}
	Utility.writeConfigurationFile(path(".vscode/pilot.code-snippets"), "json", snippets, true)
end

return VSCode
