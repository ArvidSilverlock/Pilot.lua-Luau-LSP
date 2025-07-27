--!strict
--[=[
	@class Set

	Sets are a collection of values. They are used to store unique values.
	They are essentially a dictionary, but each value is stored as a boolean.
	This means that a value can only be in a set once.

	```lua
	local set = { hello = true }

	local newSet = Add(set, "world") -- { hello = true, world = true }
	```
]=]
local set = {
	add = require("@self/add"),
	copy = require("@self/copy"),
	count = require("@self/count"),
	delete = require("@self/delete"),
	difference = require("@self/difference"),
	differenceSymmetric = require("@self/differenceSymmetric"),
	filter = require("@self/filter"),
	fromArray = require("@self/fromArray"),
	has = require("@self/has"),
	intersection = require("@self/intersection"),
	isSubset = require("@self/isSubset"),
	isSuperset = require("@self/isSuperset"),
	map = require("@self/map"),
	merge = require("@self/merge"),
	toArray = require("@self/toArray"),
}

set.fromList = set.fromArray
set.join = set.merge
set.subtract = set.delete
set.union = set.merge

return set
