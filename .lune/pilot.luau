local process = require("@lune/process")

local commands = {
	help = require("./generate/commands/help"),
	setup = require("./generate/commands/setup"),
	generate = require("./generate/commands/main"),
}

local arg = process.args[1]
if commands[arg] then
	return commands[arg](unpack(process.args, 2))
else
	print(`invalid command '{arg}'`)
end
