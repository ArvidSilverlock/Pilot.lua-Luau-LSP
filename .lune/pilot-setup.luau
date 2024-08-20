local process = require("@lune/process")
local stdio = require("@lune/stdio")

local TOOLCHAINS = { "n/a", "rokit", "aftman", "foreman" }

local options = {}

options.o = process.args[1] or "./workspace"
options["types-dir"] = process.args[2] or "types"

options.luaulsp = stdio.prompt("confirm", "Setup luau-lsp (autocomplete)?")
options.selene = stdio.prompt("confirm", "Setup selene (linter)?")
options.darklua = stdio.prompt("confirm", "Setup darklua (darklua)?")

local selectedToolchain = stdio.prompt("select", "Select a toolchain? (n/a if you don't know what this is)", TOOLCHAINS)
options.toolchain = if selectedToolchain == 1 then TOOLCHAINS[selectedToolchain] else nil

local runSetup = require("./generate/operations/setup")
local setupResult = runSetup(options)

if setupResult ~= 0 then
	return setupResult
end

if options.luaulsp then
	local runMain = require("./generate/operations/main")
	return runMain(options)
end
