--!strict
local _T = require("../Types")
local Copy = require("./copy")

--[=[
  @function freeze
  @within Dictionary

  @param dictionary T -- The dictionary to freeze.
  @return T -- The frozen dictionary.

  Freezes the given dictionary at the top level, making it read-only.

  ```lua
  local dictionary = { hello = "roblox", goodbye = { world = "world" } }

  local new = Freeze(dictionary)

  new.hello = "world" -- error!
  new.goodbye.world = "hello" -- still works!
  ```
]=]
local function freeze(dictionary: _T.AnyDictionary): _T.AnyDictionary
	local new = Copy(dictionary)

	table.freeze(new)

	return new
end

return freeze
