# Automated reactor

This project will demonstrate using a [`Microcontroller`](/objects/Microcontroller) to automate a singular [`Reactor`](/objects/Reactor) using [`Polysilicon`](/objects/Polysilicon) and [`Dispenser`](/objects/Dispenser). While the model only contains one reactor, the code should be able to handle more reactors provided you set them up correctly. **Note:** If you are using this in survival, make sure to implement a system to collect the [`Plutonium`](/objects/Plutonium) / [`Uranium`](/objects/Uranium) that will spawn out the back of the reactors.

![Reactor setup](/image/examples/reactor/structure.png)

**_Special configurations:_**

- Microcontroller: **StartOnSpawn** is **true**
- Dispenser: **Filter** is **Uranium**

```lua
local TARGET_TEMPERATURE = 1000
local REFUEL_THRESHOLD = 0.5

for _, port in Network:GetPorts() do
	local subnet = Network:GetSubnet(port)
	local dispenser = subnet:GetPart("Dispenser")
	local reactor = subnet:GetPart("Reactor")
	local poly = subnet:GetPart("Polysilicon")

	if not reactor then
		warn("no reactor on port " .. port.PortID)
	elseif not dispenser then
		warn("no dispenser on port " .. port.PortID)
	elseif not poly then
		warn("no polysilicon on port " .. port.PortID)
		continue
	end

	-- connect to .Loop event (fires when the reactor gets updated by the game)
	reactor.Loop:Connect(function()
		local temperature = reactor:GetTemp()

		-- temperature regulation
		if temperature < TARGET_TEMPERATURE then
			poly.PolysiliconMode = "Deactivate"
			poly.Frequency = 3 -- trigger it three times
			poly:Trigger()
		elseif temperature > TARGET_TEMPERATURE then
			poly.PolysiliconMode = "Activate"
			poly.Frequency = 3 -- trigger it three times
			poly:Trigger()
		end

		local shouldDispense = false

		-- check if reactor needs refueling
		for _, fuel in reactor:GetFuel() do
			-- if it's already empty, dispense immediately
			if fuel <= 0 then
				shouldDispense = true
				break
			end

			-- if it's less than the threshold, trigger polysilicon on flip-flop mode to eject waste
			if fuel <= REFUEL_THRESHOLD then
				poly.PolysiliconMode = "FlipFlop"
				poly.Frequency = 1 -- trigger it once
				poly:Trigger()
			end
		end

		if shouldDispense then
			dispenser:Dispense()
			shouldDispense = false -- make sure we don't keep dispensing every tick
		end
	end)
end
```

![Reactor in action](/image/examples/reactor/running.png)

Model code:

```json
{
	"m": null,
	"t": "buffer",
	"zbase64": "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"
}
```
