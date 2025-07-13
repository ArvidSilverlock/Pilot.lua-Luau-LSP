local stdio = require("@lune/stdio")

local Utility = require("./modules/Utility")

local CHECK_MARK = stdio.color("green") .. "✔" .. stdio.color("reset")

return function(args: { string })
	local options = Utility.mergeTables(Utility.parseArguments(args, "o"), {
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

	if options.release then
		stdio.write("Using release options.\n")

		options.types = true
		options.docs = true
		options.vscode = true
		options.modules = true
		options.selene = true
		options.darklua = true
		options.rokit = true
		options.wiki = false
	elseif options.wikionly then
		stdio.write("Using wiki-only options.\n")

		options.wiki = true

		options.types = false
		options.docs = false
		options.vscode = false
		options.modules = false
		options.selene = false
		options.darklua = false
		options.rokit = false
	elseif argumentsSpecified then
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
		local shouldGenerate = if positive ~= nil then positive elseif negative then false else default

		if not shouldGenerate then
			return
		end

		local startTime = os.clock()

		local generator = require(`./outputs/{generatorName}`)

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
