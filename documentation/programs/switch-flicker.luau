local sift = require("sift") -- Grab this fancy library for manipulating tables provided by wos.

-- Get all of the types of objects with a `SwitchValue` (save for `TemperatureGate`) configurable
-- and merge them into one big table.
local objects = sift.Array.merge(
	Network:GetParts("Switch"),
	Network:GetParts("TriggerSwitch"),
	Network:GetParts("Valve"),
	Network:GetParts("Hatch"),
	Network:GetParts("HeatValve")
)

-- Have a 50/50 chance to be on/off when the code starts running.
local initialState = math.random() > 0.5

-- Iterate over all of the switch objects and disable them. `_` is used as a placeholder variable.
for _, switch in objects do
	-- You could alternatively do `switch:Configure({ SwitchValue = initialState })`
	switch.SwitchValue = initialState
end

-- Connect to the `Loop` event of the `Microcontroller` that is running the code,
-- this will make the code within run precisely every game tick.
Microcontroller.Loop:Connect(function()
	-- Iterate over all the switches again!
	for _, switch in objects do
		-- Here we *read* the `SwitchValue`, then invert it, then write it back, as
		-- to toggle the switch.
		switch.SwitchValue = not switch.SwitchValue
	end
end)
