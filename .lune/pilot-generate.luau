-- Alias for ./src/main.luau

local process = require("@lune/process")

local callback = require("../source/main")
callback(process.args)
