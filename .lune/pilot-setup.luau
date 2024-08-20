local process = require("@lune/process")
local stdio = require("@lune/stdio")

local Utility = require("./generate/Utility")

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
	options.o = process.args[1] or "./workspace"
	options["types-dir"] = process.args[2] or "types"

	stdio.write(stdio.color("red"))
	stdio.write("Note: ")
	stdio.write(stdio.color("reset"))
	stdio.write('If you don\'t know what something is (besides luau-lsp), just put no. Only luau-lsp is "required".\n')

	options.luaulsp = stdio.prompt("confirm", "Setup luau-lsp (autocomplete)?")
	options.selene = stdio.prompt("confirm", "Setup selene (linter)?")
	options.darklua = stdio.prompt("confirm", "Setup darklua (bundler)?")
	options.rokit = stdio.prompt("confirm", "Setup rokit (toolchain manager)?")
end

local runSetup = require("./generate/operations/setup")
local setupResult = runSetup(options)

if setupResult ~= 0 then
	return setupResult
end

if options.luaulsp then
	local runMain = require("./generate/operations/main")
	return runMain(options)
end
