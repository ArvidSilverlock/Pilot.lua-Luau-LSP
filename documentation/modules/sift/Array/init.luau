--!strict
--[=[
	@class Array

	An array is a table consisting of index-value pairs. You don't need to
	manually specify the indices when you create an array.

	```lua
	local array = {
		"hello",
		"world",
	}
	```

	<br><br>

	#### Aliases

	`List`
]=]
local Array = {
	at = require("@self/at"),
	concat = require("@self/concat"),
	concatDeep = require("@self/concatDeep"),
	copy = require("@self/copy"),
	copyDeep = require("@self/copyDeep"),
	count = require("@self/count"),
	create = require("@self/create"),
	difference = require("@self/difference"),
	differenceSymmetric = require("@self/differenceSymmetric"),
	equals = require("@self/equals"),
	equalsDeep = require("@self/equalsDeep"),
	every = require("@self/every"),
	filter = require("@self/filter"),
	find = require("@self/find"),
	findLast = require("@self/findLast"),
	findWhere = require("@self/findWhere"),
	findWhereLast = require("@self/findWhereLast"),
	first = require("@self/first"),
	flatten = require("@self/flatten"),
	freeze = require("@self/freeze"),
	freezeDeep = require("@self/freezeDeep"),
	includes = require("@self/includes"),
	insert = require("@self/insert"),
	is = require("@self/is"),
	last = require("@self/last"),
	map = require("@self/map"),
	pop = require("@self/pop"),
	push = require("@self/push"),
	reduce = require("@self/reduce"),
	reduceRight = require("@self/reduceRight"),
	removeIndex = require("@self/removeIndex"),
	removeIndices = require("@self/removeIndices"),
	removeValue = require("@self/removeValue"),
	removeValues = require("@self/removeValues"),
	reverse = require("@self/reverse"),
	set = require("@self/set"),
	shift = require("@self/shift"),
	shuffle = require("@self/shuffle"),
	slice = require("@self/slice"),
	some = require("@self/some"),
	sort = require("@self/sort"),
	splice = require("@self/splice"),
	toSet = require("@self/toSet"),
	unshift = require("@self/unshift"),
	update = require("@self/update"),
	zip = require("@self/zip"),
	zipAll = require("@self/zipAll"),
}

Array.join = Array.concat
Array.merge = Array.concat
Array.joinDeep = Array.concatDeep
Array.mergeDeep = Array.concatDeep
Array.append = Array.push
Array.prepend = Array.unshift
Array.indexOf = Array.find
Array.has = Array.includes
Array.contains = Array.includes
Array.isArray = Array.is

return Array
