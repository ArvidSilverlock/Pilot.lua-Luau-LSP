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

export type Definition = { string }

export type DocumentationDefinitionPair = {
	documentation: Documentation,
	definition: Definition,
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

export type Output = {
	localTypes: {},
	generatedTypes: { { [any]: string } | string },

	globalTypes: {},
	globalValues: {},
	globalFunctions: { { string } },
	generatedGlobals: { string },

	pilotObjects: { string },

	documentation: Documentation,
	selene: { [any]: any },
}

export type Options = {
	key: string?,
	name: string,
	within: string?,

	output: Output,
	documentationSubKeys: { [string]: string }?,
}

export type ObjectOptions = {
	object: Object,
	name: string,
	objectType: string,
} & Options

export type FunctionOptions = {
	object: FunctionObject,
	isMethod: boolean?,
	standardLuauNotation: boolean?,
} & Options

export type ValueOptions = {
	object: PropertyObject,
} & Options

export type EventOptions = {
	object: EventObject,
} & Options

export type ObjectData = {
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

-- stylua: ignore
export type Generator = {
	parseObject: (ObjectOptions) -> DocumentationDefinitionPair,
	parseFunction: (FunctionOptions) -> DocumentationDefinitionPair,
	parseProperty: (ValueOptions) -> DocumentationDefinitionPair,
	parseEvent: (EventOptions) -> DocumentationDefinitionPair,
} | (
	  ("Object", ObjectOptions) -> DocumentationDefinitionPair
	& ("Function", FunctionOptions) -> DocumentationDefinitionPair
	& ("Property", ValueOptions) -> DocumentationDefinitionPair
	& ("Event", EventOptions) -> DocumentationDefinitionPair
)

return nil
