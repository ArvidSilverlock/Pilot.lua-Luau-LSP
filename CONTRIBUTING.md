# Contributing to Documentation

There is a unified system for both the generation of the wiki and the generation of the typechecking.

You will find this in the `documentation/documentation.yaml` file.

As this file needs to be able to represent all possible Luau types in a vaguely readable tabular form, it is rather complex.

First, it is a good idea to ignore the `variables` section, as you'll see the `&` symbol, these are not actually used in the typechecking, they are just shorthands for common types that use [YAML's anchors and aliases](https://support.atlassian.com/bitbucket-cloud/docs/YAML-anchors/).

Only values with a key that refers to a type are included in the generated documentation, this is how folders are produced on the wiki, for example:

```yaml
foo: # foo is not a type, as it doesn't have a type specified
  bar: # bar is a type
    type: any
  baz: # baz is a type
    type: any
```

These will show under the `foo` directory.

## Type Key Prefixes

Note that `type` is not the only type key, there are others that will be covered later, but these prefixes can also be applied to them.

### Nullables

All types can be prefixed with `nullable` (i.e., `nullable-type`, `nullable-union`) to mean 'this value can be nil' (exactly like `T?` in Luau types).

### Arrays

For arrays, you would do.

- You could also transform the type into `{T}` by doing `array-type`
- If you wanted to do `{T?}` you would need `sparse-array-type`,
- If you were even bolder, and wanted `{T?}?`, you would furthermore do `nullable-sparse-array-type`.
- By extension, if you hadn't figured it out already `nullable-array-type` is still possible, this meaning `{T}?`.

### Strings

It is often annoying to write out a string that Luau would consider valid (i.e., having to escape your quotes and whatnot).

For this there is a shorthand, you are able to write things such as:

```yaml
foobar:
  string-type: Planet
```

And this will accurately be interpreted as `"Planet"`. This will handle all the requisite escapes for you, as internally it just passes it through [string.format("%q", ...)](https://create.roblox.com/docs/reference/engine/libraries/string#format)

## Standard Types

The `type` key both represents types of the form `T` and of the form `{ key: T, [string]: V }`.

This is just done by either doing:

```yaml
foobar:
  type: T
```

Or, for the dictionary type:

```yaml
foobar:
  type:
    key:
      type: T
    [string]: # this is an abuse of the YAML syntax (the key is treated as an array), it may change in future
      type: V
```

## Unions & Intersections

You may be familiar with these from Luau typechecking, or even set theory.

A '[union](https://luau.org/typecheck#union-types)' of a type basically means it is of type 'a' **or** 'b'.
Whereas an '[intersection](https://luau.org/typecheck#intersection-types)' is _both_ 'a' **and** 'b'.

Here, you would use the key `union` or `intersection` (all the other prefixes still apply)

Do note that you would not do `union-type` or `intersection-type`. These are not prefixes, but standalone root keys that define composite types.

These keys do not directly go into their type, as usual, but rather, are an array of many other descendant types, for example:

```yaml
foobar:
  union:
    - type: string
    - type: number
foobaz:
  intersection:
    - type: string
    - type: number
```

`foobar` represents the type `string | number`, and `foobaz` represents the type `string & number` (this second one is rather nonsensical, but will make more sense when we introduce dictionaries).

For the `union` types, you are also able to prefix it with `string` and, only in combination with `string`, `open`:

```yaml
a:
  string-union:
    - foo
    - bar
    - baz
b:
  open-string-union:
    - foo
    - bar
    - baz
```

In these cases:

- `a` is the type `"foo" | "bar" | "baz"`
- `b` is the type `"foo" | "bar" | "baz" | string`

You might wonder why the `open` prefix exists, why bother specifying possible strings if you're not going to strictly enforce them? This is because it provides autofill, along with some concrete examples for what the value _could_ look like.

## Methods & Functions

These are rather simple, the definitions of methods and functions are identical syntactically (save for `function` being swapped for `method` and vice versa), so we'll just focus on `function` for now.

All you need is to specify an array of `parameters` and `returns`, note that none of the prefixes work with these two. Something to note with these is that you're allowed to specify a _name_ at the same scope level as the type key.

Variadic returns/parameters are done through setting the name to `...`.

You are allowed to leave either `parameters` or `returns` blank, but if you leave both blank, YAML will attempt to discard the `function` or `method` key, so you need to explicitly specify it as `{}`.

Remember that you can still prefix these with things like `nullable-function` or `array-function`.

```yaml
a:
  function:
    parameters:
      - name: parameter # that's a new one! a name!
        type: string
    returns:
      - name: ... # variadic return
        type: any
b:
  function:
    returns:
      - name: namedReturn # Luau does not support named returns; names are used here solely for wiki documentation
        type: any
c:
  function: {} # YAML discards empty keys, we have to be explicit about this having no members
```

In these examples:

- `a` is `(parameter: string) -> ...any`
- `b` is `() -> any`, see how the name is discarded in the type. This doesn't mean you shouldn't write them, though.
- `c` is `() -> ()`

## Generics

To specify [generic types](https://luau.org/typecheck#generics), there are two keys (which are siblings of the type key), them being, `generics` and `generic-definitions`.

The reason these are separate keys as it needs to be possible to support types such as the following:

```lua
type Type<K = string, V = number> = OtherType<V, K>
```

As an example, I will show how this type is represented in the YAML format:

```yaml
Type:
  generic-definitions:
    - name: K
      type: string # this specifies the default
    - name: V
      type: number
  type: OtherType
  generics:
    - type: V
    - type: K
```

As of writing this document, there is no way to specify generic functions, if you are in need of generic functions, please make an issue about it or contact me on discord, and I will implement it, or, if you feel capable, you can implement it yourself.

## Self

Sometimes you need to manually specify what should be considered `self` for a type's methods (i.e., in the case of metatables, where the methods are defined separate from the data).
To do this, as a sibling to the type key, you construct another type key (meaning it could technically be `self-union` or some other such construct), but prefixed with `self`.

For example:

```yaml
foobar:
  self-type: HelloWorld
  type:
    Method:
      method: {}
```

Would represent the type:

```lua
type foobar = {
	Method: (self: HelloWorld) -> ()
}
```

Rather than (if you left `self` unspecified):

```lua
type foobar = {
	Method: (self: foobar) -> ()
}
```

You'll see a better example in the next section, which is on metatables.

## Metatables

Metatables are a big part of Luau, I couldn't really find a neat way to specify metatables nicely, so I opted for:

```yaml
FoobarMetatable:
  export: false # you've not seen this yet, but this just prevents this type from being exposed as a global type
  self-type: Foobar
  type:
    Method:
      method: {}
    __index:
      type: FoobarMetatable
Foobar:
  type:
    foo:
      type: string
    bar:
      type: number
  metatable-type: FoobarMetatable
```

Wow, that is a huge type. Let's see what it actually represents:

```lua
type FoobarMetatable = {
	__index: FoobarMetatable,
	Method: (self: Foobar) -> (), -- 'Foobar', not 'FoobarMetatable', we specified the `self-type`.
}

type Foobar = typeof(setmetatable(
	{} :: {
		foo: string,
		bar: number,
	},
	{} :: FoobarMetatable
))
```

Hypothetically, the following would also work, which does avoid the use of two types, but is often not actually representative of the true type (given the standard style of faux-oop in Roblox).

```yaml
Foobar:
  type:
    foo:
      type: string
    bar:
      type: number
  metatable-type:
    __index:
      type:
        Method:
          method: {}
```

## Self & Metatable Addendum

Do note that it is also possible to separate the `self-type` into `self` and `type` separately (the same goes for `metatable-type`), like so:

```yaml
EventConnectionMetatable:
  self:
    type: EventConnection
    generics:
      - type: Name
      - type: Callback
```

This is done, as you may have noticed, to group `type` and `generics` together and avoid `self-type` and `self-generics` being sibling keys.

## Object Classes

The object classes do not directly represent a Luau type, there is a step in-between to translate them into a (less-readable, as it is more verbose) lower level form (found in `/source/modules/Hydrators.luau`).

'Hydrators' is a poor name for it, the idea is that you take a useless form of data and 'hydrate' it into a usuable form.

```yaml
PilotObject:
  hydrator:
    name: wos-object # this is a wos object
    abstract: true # this object doesn't really exist, it is just a tool for reusing definitions
    events: # events that are present
      EventName:
        parameters: # like a function, but with no returns
          - name: userId
            type: number
    methods: # methods that are present
      MethodName: # here it diverges, this is not a `method` type, it is translated to that later
        parameters:
          - name: parameter
            type: string # this is all the same though
        returns:
          - name: ...
            type: any
    properties: # read only configurables, only PilotObject has these
      PropertyName:
        type: string # standard type key
    configurables: # configurables that are present
      ConfigurableName:
        type: string # standard type key
```

All you have is a `hydrator` key, with the `name` set to `wos-object` (if this object is incredibly simple, such as grass, you can directly set `hydrator` to the string `wos-object` rather than make it an object).

This hydrator key has the keys `events`, `methods`, `configurables` and `properties` (you rarely need properties, they are only used for the `PilotObject` class to specify things like `Position`).

It also has an `abstract` key (i.e., if you made a `ContainerObject` class, it doesn't really exist in the game, but many objects act like containers) to specify whether it is a real object or just a class of object (like Roblox `BasePart`s).

For objects like `100k`, which are not valid Luau identifiers (as they start with numbers). You should specify them with a `class-name` and a different type name, like so:

```yaml
Part100k:
  hydrator:
    name: wos-object
    class-name: 100k
```

There is also an `extends` key for inheritence, it defaults to `PilotObject` for classes who have `abstract` as undefined or `false`.

The only divergence between how the types are specified once categoried is that `events` are their own custom format (and are later translated to normal Luau types), and `methods` directly specify `parameters` and `returns` without specifying the `method` key.

## Documentation

So far, we've only covered types, but, of course, you can also attach descriptions to types or their members using the documentation key.

This is done through a `documentation` key, which is a sibling of any type keys (it doesn't just have to be the root type, you can also document subkeys, for example `RegionInfo.SubType` could have a description, and so could `RegionInfo` itself).

### Basic Documentation

The `documentation` key can just directly be a string, for example:

```yaml
PortLike:
  documentation: A value that will be accepted as a port by the <code>GetPart(s)(FromPort)</code> functions.
  union:
    - type: Port
    - type: number
```

### Range & Increment

This is good for simple types, which just need a description, but if you wish to specify that a value is _deprecated_, or maybe a range/increment, you would do something like (with a `description` key as a within the `documentation` key):

```yaml
Transparency:
  type: number
  documentation:
    description: The transparency of the AR display.
    range: [0, 1]
    increment: 0.1
```

Note that, for ranges that only have a bound in one direction, you can just specify `min` and `max` instead of `range` (do not specify `min` and `max` both at once).

### Deprecation

If specifying something as deprecated, you can either set it to the boolean value of `true`, or set it to a `string` (if it is a string, it will be treated as a note about the deprecated, like an alternative to use, why the deprecation happened, what behaviour the now deprecated function exhibits).

```yaml
CraftItems:
  documentation:
    description: Will craft the specified set of items.
    deprecated: true
  parameters: ...
GetInventory:
  documentation:
    deprecated: Returns an empty, frozen table.
  returns: ...
```

### Categories

You can specify an array of `categories` within the `documentation` key, such as:

```yaml
Grass:
  documentation:
    description: ...
    categories: [Natural, Resources, Spawnable]
  hydrator: wos-object
```

### Code Examples

Another available documentation is `code-sample` or `code-samples`. `code-sample` is a string of just a single code example, whereas `code-samples` is an array of multiple code examples.

Each of the specified code examples (for either the plural or singular keys) can be specified as a file path to a file in `/documentation/programs`.

### Information Sources

If you have a source for where you got the information from, you can specify a `source` or `sources` key with a link to the information source. These sources could be developer messages or people talking about the feature working in the way you've documented.

# Contributing to Module Documentation

This is really quite simple, if you want to contribute _types_ for the modules, navigate to `/documentation/modules` and either modify the `.luau` file, or create one.

Rather, if you wish to provide wiki documentation for the module, navigate to `/wiki/docs/modules` and merely write a markdown file there.

# Contributing to Wiki _Generation_

If you want to alter the _aesthetics_ of the wiki (i.e., change sidebars, change colouring), navigate to the `wiki` directory where you'll find a [docusaurus](https://docusaurus.io/) website.

If you want to alter how pages are generated, modify the source in `/source/outputs/Wiki.luau`.

You can read how to get a local copy of the wiki up and running in `/wiki/README.md`.

# Contributing to Typechecking _Generation_

All the possible outputs are generated by a module in `/source/outputs/**`.

For example, the part that generates the _types_ is `Definition.luau`, and the part that generates the in-editor documentation is `Documentation.luau`.

If you wish to add a new generation output, you must add a new luau file to this directory, and then enter `/source/main.luau` and implement the requisite optioning (i.e., should it be enabled for the `--release` option).

You must also go down to the end of the program and register it with the alongside the other modules with the `generate` calls.
