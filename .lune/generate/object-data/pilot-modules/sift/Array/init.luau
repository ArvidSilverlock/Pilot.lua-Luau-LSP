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
	at = require("./at"),
	concat = require("./concat"),
	concatDeep = require("./concatDeep"),
	copy = require("./copy"),
	copyDeep = require("./copyDeep"),
	count = require("./count"),
	create = require("./create"),
	difference = require("./difference"),
	differenceSymmetric = require("./differenceSymmetric"),
	equals = require("./equals"),
	equalsDeep = require("./equalsDeep"),
	every = require("./every"),
	filter = require("./filter"),
	find = require("./find"),
	findLast = require("./findLast"),
	findWhere = require("./findWhere"),
	findWhereLast = require("./findWhereLast"),
	first = require("./first"),
	flatten = require("./flatten"),
	freeze = require("./freeze"),
	freezeDeep = require("./freezeDeep"),
	includes = require("./includes"),
	insert = require("./insert"),
	is = require("./is"),
	last = require("./last"),
	map = require("./map"),
	pop = require("./pop"),
	push = require("./push"),
	reduce = require("./reduce"),
	reduceRight = require("./reduceRight"),
	removeIndex = require("./removeIndex"),
	removeIndices = require("./removeIndices"),
	removeValue = require("./removeValue"),
	removeValues = require("./removeValues"),
	reverse = require("./reverse"),
	set = require("./set"),
	shift = require("./shift"),
	shuffle = require("./shuffle"),
	slice = require("./slice"),
	some = require("./some"),
	sort = require("./sort"),
	splice = require("./splice"),
	toSet = require("./toSet"),
	unshift = require("./unshift"),
	update = require("./update"),
	zip = require("./zip"),
	zipAll = require("./zipAll"),
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
