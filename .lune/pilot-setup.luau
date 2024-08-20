local process = require("@lune/process")
local stdio = require("@lune/stdio")

local options = {}

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

local runSetup = require("./generate/operations/setup")
local setupResult = runSetup(options)

if setupResult ~= 0 then
	return setupResult
end

if options.luaulsp then
	local runMain = require("./generate/operations/main")
	return runMain(options)
end
