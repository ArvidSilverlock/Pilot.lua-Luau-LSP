The partdata module provides information about objects in game, such as what configurables the object has, what 'programmable events' it has, default size, durability and many other facts.

Here is the structure, wrttien using [Luau's type system](https://luau.org/typecheck):

```lua
type FaceOpacities = {
	[Enum.NormalId]: {
		Internal: "Push" | "Pull" | "Opaque",
		External: "Push" | "Pull" | "Opaque",
	} | "Exit" | "Enter",
}

type ClassType = "Natural" | "Craftable" | "Tool" | "Unused"
type Category = "Logic" | "Tools" | "Weapons" | "Electrical" | "Templates" | "Propulsion" | "Resources" | string
type ClassState = "Solid" | "Liquid" | "Gas"

type ConfigValue = {
	Name: string,
	Description: string,
} & ({
	Type: string,
	[string]: any,
} | {
	Type: "number",
	Default: number,
	Options: { number },
} | {
	Type: "boolean",
	Default: boolean,
} | {
	Type: "string",
	Default: string,
} | {
	Type: "Selection",
	Default: number?,
	Options: { string },
})

type ComponentInfo = {
	-- Metadata
	ClassName: string,
	Description: string?,

	ConfigData: { ConfigValue }?,

	-- Behaviour
	Conflicts: { string }?,
	Events: { string }?,
}

type PartInfo = {
	-- Metadata
	ClassName: string,
	Categories: { Category },
	ClassState: ClassState,
	ClassType: ClassType,
	Description: string?,
	Color: Color3?,

	Recipe: { [string]: number }?,
	ConfigData: { ConfigValue }?,

	Spawnable: boolean,
	Craftable: boolean,

	-- Physical properties
	Malleability: number,
	BaseSize: Vector3,
	BaseDurability: number,
	BaseHeatCapacity: number,

	-- Behaviour
	Flammable: boolean,
	FaceOpacity: FaceOpacities?,
	Events: { string }?,
	ProgrammableEvents: { string }?,

	ResourceType: string?,
	ResourceAmount: number?,

	GeneratorType: string?,
	GeneratorAmount: number?,

	HeatPowerProduct: number?,
	HeatGeneratorProduct: number?,
}

type partdata = {
	Components: { [string]: ComponentInfo },
	Parts: { [string]: PartInfo },
}
```
