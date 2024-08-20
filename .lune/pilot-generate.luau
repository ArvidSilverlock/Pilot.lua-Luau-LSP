local process = require("@lune/process")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

local Utility = require("./generate/Utility")

local runMain = require("./generate/operations/main")

local options = Utility.mergeTables(Utility.parseArguments(process.args, "o"), {
	o = "./workspace",
	["types-dir"] = "types",
})

if not (fs.isDir(Utility.joinPath(options.o)) and fs.isDir(Utility.joinPath(options.o, options["types-dir"]))) then
	stdio.ewrite("please run `pilot-setup` before `pilot-generate`\n")
	return 1
end

return runMain(options)
