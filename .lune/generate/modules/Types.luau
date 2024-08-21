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

export type Describable = {
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

export type Object = ({
	categories: { string }?,
	methods: { [string]: FunctionObject }?,
	properties: { [string]: PropertyObject }?,
	events: { [string]: EventObject }?,
	extends: string?,
} & Describable & Typed) | string

export type FunctionObject = {
	parameters: { string | { string } }?,
	returns: { string | { string } }?,
} & Describable & Typed

export type FunctionDictionaryObject = {
	keys: { [string]: FunctionObject },
} & Describable

export type PropertyObject = {
	type: string?,
} & Describable & Typed

export type EventObject = ({
	parameters: { string | { string } }?,
} & Describable & Typed) | boolean

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

export type LuauType = any

export type Described = {
	Description: string,
	LearnMoreLink: string,
	CodeSample: string,
}

export type PropertyData = {
	IsDeprecated: boolean,
	IsReadOnly: boolean,
	Type: LuauType,
} & Described

export type ParameterData = {
	Name: string?,
	Description: string?,
	Type: LuauType,
}

export type MethodData = {
	Parameters: { ParameterData },
	Returns: { ParameterData },
} & Describable

export type EventData = {
	Parameters: { ParameterData },
} & Describable

export type ObjectData = {
	InheritenceChain: { string },
	Categories: { string },
	Members: (
		{ Group: "Methods", Reference: MethodData }
		| { Group: "Properties", Reference: PropertyData }
		| { Group: "Configurables", Reference: PropertyData }
		| { Group: "Events", Reference: EventData }
	) & {
		Name: string,
		Source: string,
	},

	Methods: { [string]: MethodData },
	Properties: { [string]: PropertyData },
	Configurables: { [string]: PropertyData },
	Events: { [string]: EventData },
} & Describable

export type PilotData = {
	Raw: RawPilotData,
	Objects: { [string]: ObjectData },
}

return nil
