--!strict
local copy = require("../Dictionary/copy")

--[=[
  @function copy
  @within Set

  @param set { [T]: boolean } -- The set to copy.
  @return { [T]: boolean } -- A copy of the set.

  Creates a copy of a set.

  ```lua
  local set = { hello = true }

  local newSet = Copy(set) -- { hello = true }
  ```
]=]
return copy
