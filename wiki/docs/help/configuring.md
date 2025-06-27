# Configuring Objects

There are two different ways to configure objects in Waste of Space.

The first way is through an operation like this, this is the preferred method:

```lua
object.Configurable = configurableValue
```

An older _legacy_ method for configuring objects looked like this, you shouldn't do this anymore for both stylistic reasons and 'performance' reasons (performance loss is incredibly minor, i.e., on the order of microseconds, not because of the function call, but because of the creation of a table).

```lua
object:Configure({
	Configurable = configurableValue,
})
```

Do note that you can read the configurable of an object as well, you do this just by doing:

```lua
print(object.Configurable) -- prints the current value in the configurable
```

## Detecting changes to the configuration

If you just want to know _when_ the configuration changes, but not _what_ actual configurable changed, you can simplify use the `Configured` [event](/help/events) like so:

```lua
object.Configured:Connect(function()
	print(`The object '{object}' was configured!`)
end)
```

### Filtering for a specific configurable

If you want to filter it to a specific configurable, such as [`Gyro.Seek`](/objects/Gyro#Seek), you can simply do the following:

```lua
local TRACKED_CONFIGURABLE = "Seek"

local previousConfiguration = object[TRACKED_CONFIGURABLE]

object.Configured:Connect(function()
	local currentConfiguration = object[TRACKED_CONFIGURABLE]
	if currentConfiguration == previousConfiguration then return end

	print(`{object}'s '{TRACKED_CONFIGURABLE}' configurable was changed from {previousConfiguration} to {currentConfiguration}!`)

	previousConfiguration = currentConfiguration
end)
```

You could alternatively do (note that, as of writing this, the `signal` module is not available in game, so you cannot do this unless you acquire your own implementation of the `signal` module):

```lua
local signal = require("signal")

local function getInstanceConfigurableChangedSignal(object: PilotObject, configurable: string)
	local signal = signal.new()

	local previousConfiguration = object[configurable]

	object.Configured:Connect(function()
		local currentConfiguration = object[configurable]
		if currentConfiguration == previousConfiguration then return end

		signal:Fire(currentConfiguration, previousConfiguration)

		previousConfiguration = currentConfiguration
	end)

	return signal
end

local gyro = assert(GetPart("Gyro"), "no gyro connected!")
getInstanceConfigurableChangedSignal(gyro, "Seek"):Connect(function(currentConfiguration, previousConfiguration)
	print(`{object}'s 'Seek' configurable was changed from {previousConfiguration} to {currentConfiguration}!`)
end)
```

### Identifying any & all changed configurables

If you want to know which configurable (out of all configurables) was changed, you'll need to put a little more work in.

```lua
local function tabulateConfigurables(object: PilotObject, configuration: { [string]: any })
	local changes = {}

	for _, configurableData in object:GetConfigurables() do
		local configurableName = configurableData.Name
		local configurableValue = object[configurableName]

		if configuration[configurableName] ~= configurableValue then
			table.insert(changes, configurableName)
			configuration[configurableName] = configurableValue
		end
	end

	return changes
end

local configuration = {}

-- initialise with the current configuration, but discard
-- what 'changes' occurred (they are not actually changes)
tabulateConfigurables(object, configuration)

object.Configured:Connect(function()
	local changes = tabulateConfigurables(object, configuration)

	for _, change in changes do
		local value = configuration[change]
		print(`{object}'s '{change}' configurable was changed to {value}!`)
	end
end)
```

### Tracking current and previous values for all configurables

If you need to keep track of the previous value, you can do the following (\*you need to keep the `tabulateConfigurables` function):

```lua
local previousConfiguration = {}

-- initialise with the current configuration, but discard
-- what 'changes' occurred (they are not actually changes)
tabulateConfigurables(object, previousConfiguration)

object.Configured:Connect(function()
	local currentConfiguration = table.clone(previousConfiguration)
	local changes = tabulateConfigurables(object, currentConfiguration)

	for _, change in changes do
		local previous, current = previousConfiguration[change], currentConfiguration[change]
		print(`{object}'s '{change}' configurable was changed from {previous} to {current}!`)
	end

	previousConfiguration = currentConfiguration
end)
```
