local process = require("@lune/process")
local serde = require("@lune/serde")
local fs = require("@lune/fs")

local output = require("./generate/object-data/Pilot")
if process.args[1] == "print" then
	output.raw = nil
	print(output)
elseif process.args[1] == "save" then
	output.raw = nil
	fs.writeFile(".lune/test.json", serde.encode("json", output, true))
end
