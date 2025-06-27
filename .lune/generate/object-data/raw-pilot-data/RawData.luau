local serde = require("@lune/serde")
local fs = require("@lune/fs")

return serde.decode("json", fs.readFile("documentation/documentation.json"))
