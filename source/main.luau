local stdio = require("@lune/stdio")

local Utility = require("./modules/Utility")

local CHECK_MARK = stdio.color("green") .. "✔" .. stdio.color("reset")

local GENERATORS = {
	"types",
	"docs",
	"vscode",
	"modules",
	"selene",
	"darklua",
	"rokit",
	"wiki",
	"vanilla",
}

local DEFAULT_ARGUMENTS = {
	o = "./workspace",
	["types-dir"] = "types",

	["vanilla-output"] = "vanilla.luau",

	["snippet-casing"] = "camel",
	["snippet-part-message"] = "expected <part> to be connected",
	["snippet-port-message"] = "expected <part> to be connected on port <port>",
}

return function(args: { string })
	local options = Utility.mergeTables(Utility.parseArguments(args, "o"), table.clone(DEFAULT_ARGUMENTS))

	local argumentsSpecified = false
	for option, _: any in options do
		if DEFAULT_ARGUMENTS[option] == nil then
			argumentsSpecified = true
			break
		end
	end

	local foundOnly = nil
	for _, option in GENERATORS do
		if options[option .. "only"] then
			foundOnly = option
			break
		end
	end

	if options.release then
		stdio.write("Using release options.\n")

		options.types = true
		options.docs = true
		options.vscode = true
		options.modules = true
		options.selene = true
		options.darklua = true
		options.rokit = true
		options.vanilla = true
		options.wiki = false
	elseif foundOnly then
		stdio.write("Using " .. foundOnly .. "-only options.\n")
		for _, option in GENERATORS do
			options[option] = option == foundOnly
		end
	elseif argumentsSpecified then
		stdio.write("Arguments besides '" .. "-o" .. "' and `--types-dir` specified, not providing Q/A.\n")
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
		options.vanilla = false

		options.selene = stdio.prompt("confirm", "Setup selene (linter)?")
		options.darklua = stdio.prompt("confirm", "Setup darklua (bundler)?")
		options.rokit = stdio.prompt("confirm", "Setup rokit (toolchain manager)?")
	end

	local function generate(optionName: string, generatorName: string, default: boolean)
		local positive, negative = options[optionName], options["no" .. optionName]
		local shouldGenerate = if positive ~= nil then positive elseif negative then false else default

		if not shouldGenerate then
			return
		end

		local startTime = os.clock()

		local generator = (require :: any)(`./outputs/{generatorName}`)

		if generator.generate and generator.save then
			generator.save(options, generator.generate(options))
		elseif generator.generate then
			generator.generate(options)
		elseif generator.save then
			generator.save(options)
		end

		local endTime = os.clock()

		if generator.generate or generator.save then
			stdio.write(
				`{CHECK_MARK} Generating {stdio.color("green")}{generatorName:lower()}{stdio.color("reset")} took {Utility.formatTime(
					endTime - startTime
				)}\n`
			)
		end
	end

	local pilotStart = os.clock()
	require("./modules/PilotDocumentation")
	local pilotEnd = os.clock()

	stdio.write(
		`{CHECK_MARK} Parsing {stdio.color("cyan")}Pilot.lua documentation{stdio.color("reset")} took {Utility.formatTime(
			pilotEnd - pilotStart
		)}\n`
	)

	stdio.write("\n")

	if
		options.types
		or options.docs
		or options.modules
		or options.vscode
		or options.selene
		or options.darklua
		or options.rokit
	then
		Utility.makeDirectory(options.o)
		Utility.makeDirectory(`{options.o}/{options["types-dir"]}`)
	end

	generate("types", "Definition", true)
	generate("docs", "Documentation", true)

	generate("modules", "Modules", true)
	generate("vscode", "VSCode", true)

	generate("selene", "Selene", false)
	generate("darklua", "Darklua", false)
	generate("rokit", "Rokit", false)

	generate("wiki", "Wiki", false)
	generate("vanilla", "Vanilla", false)
end
