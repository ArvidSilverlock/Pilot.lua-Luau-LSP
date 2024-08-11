> All the current documentation is generated from the `PartData.json` found in the dependencies Eggs D Studios repo, and is therefore highly outdated in many areas. I am awaiting a patch in unstable's model loader, after which I will update as much of the information as I can.

If you have any questions about contributing or setting up, send them in the #questions channel of my [Pilot.lua LSP discord](https://discord.gg/5Uxx2CKkxN) or in my dms.

## Installation
Install the [Luau LSP](https://marketplace.visualstudio.com/items?itemName=JohnnyMorganz.luau-lsp) visual studio code extension.

Install [lune](https://lune-org.github.io/docs), a luau runtime.

Run these commands in order:
```
git clone https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP.git
cd Pilot.lua-Luau-LSP
lune run pilot setup
lune run pilot generate json
```

Open the generated `workspace` folder as the root folder in visual studio code.

## Contributing

Navigate to the `.lune/generate` folder, you should see `documentation.json` and `documentation.yaml`. You can contribute to either of these files (just make sure to swap the last parameter in `generate` to either `json` or `yaml` depending, it will sync both files after each generation to the one used during generation).

The structure is as follows:
- `globals`: 
  - `functions`: Global functions, such as `Beep`, `GetPartsFromPort`, `JSONEncode` and the like.
  - `values`: Global values such as `Microcontroller`, `SandboxID` along with values like `FileSystem` and `RawFilesSystem`.
  - `types`: These are that are shared throughout all the scripts, like `RegionInfo`, `RegionLogs` or `Cursor`
- `types`:  Basic types that aren't shared with other scripts, mostly for utility or types with recursive definitions.
- `objectbase`: Contains documentation information for the base object other pilot objects inherit from (i.e., `Color`, `Size`, `Durability` and such)
- `objects`: The meat of the data, contains all the information about individual object types, like `Gyro`s and `Screen`s.

Here is a description of the `objects` using psuedocode based off of luau types (not valid luau types).
```luau
type Describable = {
	description: string?,
	readonly: boolean?,
	deprecated: (boolean | string)?, -- If it's a string it will be interpreted
	                                 -- as a sort of description for the deprecated
	                                 -- tag, i.e., a suggestion on what to use instead
	learnmore: string?, -- a link to documentation (could be a discord message for the information source)
}

type LuauType = string -- Interpreted as a type name, like `number?` or `RegionInfo`
	| {
		"or" | "or?" | "and" | "and?",
		...any
	} -- {"or", "a", "b", "c"} = `a | b | c`
	  -- {"or?", "a", "b", "c"} = `(a | b | c)?`
	  -- {"and", "a", "b", "c"} = `a & b & c`
	  -- {"and?", "a", "b", "c"} = `(a & b & c)?`
	| {string} -- {"a", "b", "c"} = "a" | "b" | "c"
	| {
		[string]: LuauType
	} -- A struct, { a = "number?" } -> { a: number? }

type Object = {
	categories: { string }?,

	properties: {
		[string]: ({
			type: LuauType,
		} | {
			unknowntype: boolean?,
		}) & Describable
	}?,
	methods: {
		[string]: ({
			parameters: {
				{ [1]: "typeName: LuauType", [2]: string } | "typeName: LuauType"
				-- 1 is the type name and type, 2 is the description, if you don't need a
				-- description you can omit the table brackets and leave it as a string.
			}?,
			returns: {
				{ [1]: LuauType, [2]: string } | LuauType
				-- Same as the `parameters`, but no names.
			}?
		} | {
			unknowntype: boolean?,
		}) & Describable
	}?,
	events: {
		[string]: {
			parameters: {
				{ [1]: "typeName: LuauType", [2]: string } | "typeName: LuauType"
				-- Same as the `methods."".parameters`
			}
		} & Describable
	}?
} & Describable
```

I do realise that this description isn't all too helpful, but I hope you can get a feel for it from reading the files themselves.