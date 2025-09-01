# Legacy Code

There are a lot of unmaintained, and therefore outdated sources of information.

Some things you shouldn't do:

## Retrieving Parts

You used to do:

```lua
local screen = GetPartFromPort(1, "Screen")
local screen = GetPart("Screen")

local screens = GetPartsFromPort(1, "Screen")
local screens = GetParts("Screen")
```

These functions will be removed in future, as such, you should use their new counterparts:

```lua
local screen = Network:GetPartFromPort(1, "Screen")
local screen = Network:GetPart("Screen")

local screens = Network:GetPartsFromPort(1, "Screen")
local screens = Network:GetParts("Screen")
```

They function identically, but are not at risk for removal.

## Event Connections

To connect to events, you used to do this:

```lua
object:Connect("EventName", function()

end)
```

In modern Waste of Space, you should do the following:

```lua
object.EventName:Connect(function()

end)
```

## Configuring Objects

You used to need to use the <code>:Configure</code> on objects to configure them, this hasn't been the case for quite some time.

```lua
object:Configure({
	ConfigurableA = configurableAValue,
	ConfigurableB = configurableBValue,
})
```

You should prefer configuring objects how you would a standard Roblox instance or a table.

```lua
object.ConfigurableA = configurableAValue
object.ConfigurableB = configurableBValue
```
