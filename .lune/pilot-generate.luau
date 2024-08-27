local process = require("@lune/process")
local stdio = require("@lune/stdio")

local Utility = require("./generate/modules/Utility")

local options = Utility.mergeTables(Utility.parseArguments(process.args, "o"), {
	o = "./workspace",
	["types-dir"] = "types",
})

local argumentsSpecified = false
for option, _: any in options do
	if option ~= "o" and option ~= "types-dir" then
		argumentsSpecified = true
		break
	end
end

if argumentsSpecified then
	stdio.write("Arguments besides '-o' and `--types-dir` specified, not providing Q/A.\n")
else
	stdio.write(stdio.color("red"))
	stdio.write("Note: ")
	stdio.write(stdio.color("reset"))
	stdio.write("If you don't know what something is, just put no.\n")

	options.types = true
	options.docs = true
	options.vscode = true
	options.modules = true
	options.wiki = false

	options.selene = stdio.prompt("confirm", "Setup selene (linter)?")
	options.darklua = stdio.prompt("confirm", "Setup darklua (bundler)?")
	options.rokit = stdio.prompt("confirm", "Setup rokit (toolchain manager)?")
end

local function generate(optionName: string, generatorName: string, default: boolean)
	local positive, negative = options[optionName], options["no" .. optionName]
	local shouldGenerate = if positive then true elseif negative then false else default

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

Utility.makeDirectory(options.o)
Utility.makeDirectory(`{options.o}/{options["types-dir"]}`)

generate("types", "Definition", true)
generate("docs", "Documentation", true)

generate("modules", "Modules", true)
generate("vscode", "VSCode", true)

generate("selene", "Selene", false)
generate("darklua", "Darklua", false)
generate("rokit", "Rokit", false)

generate("wiki", "Wiki", false)

local endTime = os.clock()

stdio.write(`{stdio.color("green")}Done!{stdio.color("reset")} Took {endTime - startTime}s.\n`)
