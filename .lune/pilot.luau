local process = require("@lune/process")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

local Utility = require("./generate/Utility")

local runSetup = require("./generate/operations/setup")
local runMain = require("./generate/operations/main")

local options = Utility.mergeTables(Utility.parseArguments(process.args, "o"), {
	source = "json",
	o = "./workspace",
	types = "types",
})

if options.source ~= "json" and options.source ~= "yaml" then
	stdio.ewrite("the parameter passed to `setup` must be `json` or `yaml` (case-sensitive)")
	return 1
end

if options.setup then
	local setupResult = runSetup(options)
	if setupResult ~= 0 then
		return setupResult
	end
elseif not (fs.isDir(Utility.joinPath(options.o)) and fs.isDir(Utility.joinPath(options.o, "types"))) then
	stdio.ewrite("please run `pilot` with the `--setup` option\n")
	return 1
end

return runMain(options)
