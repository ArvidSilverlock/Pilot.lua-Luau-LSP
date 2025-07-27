--!strict
--[=[
	@class Dictionary

	Dictionaries are a type of data structure that can be used to store key-value pairs.

	```lua
	local dictionary = {
		cats = 2,
		dogs = 1
	}

	print(dictionary.cats) -- 2
	```
]=]
local Dictionary = {
	copy = require("@self/copy"),
	copyDeep = require("@self/copyDeep"),
	count = require("@self/count"),
	entries = require("@self/entries"),
	equals = require("@self/equals"),
	equalsDeep = require("@self/equalsDeep"),
	every = require("@self/every"),
	filter = require("@self/filter"),
	flatten = require("@self/flatten"),
	flip = require("@self/flip"),
	freeze = require("@self/freeze"),
	freezeDeep = require("@self/freezeDeep"),
	fromArrays = require("@self/fromArrays"),
	fromEntries = require("@self/fromEntries"),
	has = require("@self/has"),
	includes = require("@self/includes"),
	keys = require("@self/keys"),
	map = require("@self/map"),
	merge = require("@self/merge"),
	mergeDeep = require("@self/mergeDeep"),
	removeKey = require("@self/removeKey"),
	removeKeys = require("@self/removeKeys"),
	removeValue = require("@self/removeValue"),
	removeValues = require("@self/removeValues"),
	set = require("@self/set"),
	some = require("@self/some"),
	update = require("@self/update"),
	values = require("@self/values"),
	withKeys = require("@self/withKeys"),
}

Dictionary.join = Dictionary.merge
Dictionary.joinDeep = Dictionary.mergeDeep

return Dictionary
