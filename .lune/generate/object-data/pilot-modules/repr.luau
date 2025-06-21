--[=[
```lua
local myTable = {
	hello = "repr",
	usefulness = 9001,
	isEasyToUse = true,
	array = {"numerical", "arrays", "are", "easy"},
	land = workspace["a b c"]["1 2 3"],
	subTables = {
		moreInfo = "calls itself recursively to print sub-tables"
	},
	usesToString = {__tostring = function () return "__tostring functions are called automatically" end},
	["$YMBOL$"] = "keys that aren't Lua identifiers are quoted";
	[{also = "tables as keys work too";}] = "in case you need that",
	cyclic = {note = "cyclical tables are printed as just {CYCLIC}"}
}
-- create a cycle:
myTable.cyclic.cyclic = myTable.cyclic
 
local reprSettings = {
	pretty = false;              -- print with \n and indentation?
	semicolons = false;          -- when printing tables, use semicolons (;) instead of commas (,)?
	sortKeys = true;             -- when printing dictionary tables, sort keys alphabetically?
	spaces = 3;                  -- when pretty printing, use how many spaces to indent?
	tabs = false;                -- when pretty printing, use tabs instead of spaces?
	robloxFullName = false;      -- when printing Roblox objects, print full name or just name? 
	robloxProperFullName = true; -- when printing Roblox objects, print a proper* full name?
	robloxClassName = true;      -- when printing Roblox objects, also print class name in parens?
}
print(repr(myTable, reprSettings))
```
]=]
return require("repr") :: (
	value: any?,
	configuration: {
		pretty: boolean?,
		robloxFullName: boolean?,
		robloxProperFullName: boolean?,
		robloxClassName: boolean?,
		tabs: boolean?,
		semicolons: boolean?,
		spaces: number?,
		sortKeys: boolean?,
	}?
) -> string
