--!strict

export type DocumentationParameter = {
	name: string?,
	documentation: string?,
}

export type DocumentationParameters = { DocumentationParameter }

export type DocumentationObject = {
	documentation: string?,
	keys: { [string]: string }?,
	params: DocumentationParameters?,
	returns: { string }?,
	learn_more_link: string?,
	code_sample: string?,
}

export type Documentation = {
	[string]: DocumentationObject,
}

export type DescribableRaw = {
	deprecated: boolean?,
	readonly: boolean?,
	description: string?,
	codesample: string?,
	learnmore: string?,
}

export type Typed = {
	unknowntype: boolean?,
	generate: string?,
}

export type Object = {
	categories: { string }?,
	methods: { [string]: FunctionObject }?,
	properties: { [string]: PropertyObject }?,
	events: { [string]: EventObject | boolean }?,
	extends: string?,
} & DescribableRaw & Typed

export type FunctionObject = {
	parameters: { string | { string } }?,
	returns: { string | { string } }?,
} & DescribableRaw & Typed

export type FunctionDictionaryObject = {
	keys: { [string]: FunctionObject },
} & DescribableRaw

export type PropertyObject = {
	type: string?,
	constraints: {
		min: number?,
		max: number?,
		step: number?,
		default: any?,
	}?,
} & DescribableRaw & Typed

export type EventObject = {
	parameters: { string | { string } }?,
} & DescribableRaw & Typed

export type RawPilotData = {
	globals: {
		functions: { [string]: FunctionObject | FunctionDictionaryObject },
		types: { [string]: any },
		values: { [string]: any },
	},
	classes: {
		abstractclasses: { [string]: Object },
		objects: { [string]: Object },
		components: { string },
	},
	types: { [string]: any },
	events: { [string]: EventObject },
}

export type LuauType = {
	Luau: string,
	Definition: string?,
	Wiki: string?,
	Unknown: boolean,

	InsertDefinition: (DefinitionOutput) -> ()?,
	InsertDocumentation: (any) -> ()?,
	InsertSelene: (any) -> ()?,
	InsertWiki: (any) -> ()?,
}

export type Describable = {
	Description: string?,
	LearnMoreLink: string?,
	CodeSample: string?,
	Deprecated: (string | boolean)?,
}

export type PropertyData = {
	ReadOnly: boolean,
	Type: LuauType,
	Minimum: number?,
	Maximum: number?,
	Step: number?,
	Default: any?,
} & Describable

export type ParameterData = {
	Name: string?,
	Description: string?,
	Type: LuauType,
}

export type FunctionData = {
	Parameters: { ParameterData },
	Returns: { ParameterData },
	Type: LuauType,
} & Describable

export type FunctionDictionaryData = {
	Functions: { [string]: FunctionData },
} & Describable

export type EventData = {
	Parameters: { ParameterData },
} & Describable

export type MemberData = (
	{ Group: "Methods", Reference: FunctionData }
	| { Group: "Properties", Reference: PropertyData }
	| { Group: "Configurables", Reference: PropertyData }
	| { Group: "Events", Reference: EventData }
) & {
	Name: string,
	Source: string,
}

export type ObjectData = {
	Name: string,

	Inherits: { string },
	InheritenceChain: { string },

	Categories: { string },
	Members: { [string]: MemberData },

	Methods: { [string]: FunctionData },
	Properties: { [string]: PropertyData },
	Configurables: { [string]: PropertyData },
	Events: { [string]: EventData },
} & Describable

export type PilotData = {
	Raw: RawPilotData,
	ObjectDefinitionOrder: { string },
	Objects: { [string]: ObjectData },
	Functions: { [string]: FunctionData },
	FunctionDictionaries: { [string]: FunctionDictionaryData },
	Values: { [string]: PropertyData },
	Types: {
		Global: { [string]: FunctionData },
		Local: { [string]: FunctionData },
		References: {
			Name: string,
			Group: "Global" | "Local",
			Reference: FunctionData,
		},
	},
}

export type DefinitionOutput = {
	GlobalTypes: { string },
	LocalTypes: { string },
	GlobalFunctions: { string },
	GlobalValues: { string },
	Objects: { string },
}

return nil
