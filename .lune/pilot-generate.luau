local process = require("@lune/process")
local stdio = require("@lune/stdio")
local serde = require("@lune/serde")
local fs = require("@lune/fs")

local Utility = require("./generate/modules/Utility")

local options = Utility.mergeTables(Utility.parseArguments(process.args, "o"), {
	o = "./workspace",
	["types-dir"] = "types",
})

local function generate(optionName: string, generatorName: string, default: boolean)
	local shouldGenerate = if default then not options["!" .. optionName] else options[optionName]
	if not shouldGenerate then
		stdio.write(`[{stdio.color("red")}Skipped{stdio.color("reset")}] {generatorName}\n`)
		return
	end

	local generator = require(`./generate/generators/{generatorName}`)

	if generator.generate and generator.save then
		local generatedData = generator.generate(options)
		generator.save(options, generatedData)
	elseif generator.generate then
		generator.generate(options)
	elseif generator.save then
		generator.save(options)
	else
		stdio.write(`[{stdio.color("red")}Failed{stdio.color("reset")}] {generatorName}\n`)
	end

	if generator.generate or generator.save then
		stdio.write(`[{stdio.color("green")}Generated{stdio.color("reset")}] {generatorName}\n`)
	end
end

local startTime = os.clock()

generate("types", "Definition", true)
generate("docs", "Documentation", true)
generate("modules", "Modules", false)
generate("selene", "Selene", false)
generate("wiki", "Wiki", false)

local endTime = os.clock()

stdio.write(`{stdio.color("green")}Done!{stdio.color("reset")} Took {endTime - startTime}s.\n`)
