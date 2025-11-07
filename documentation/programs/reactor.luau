local DISPENSE_COOLDOWN = 1

for _, port in Network:GetPorts() do
	local subnet = Network:GetSubnet(port)
	local reactor = subnet:GetPart("Reactor")
	local dispenser = subnet:GetPart("Dispenser")

	if not reactor or not dispenser then
		warn("invalid port", reactor, dispenser)
		continue
	end

	local dispenseCooldown = 0
	dispenser.Filter = "Uranium"

	reactor.Loop:Connect(function(tickInterval)
		dispenseCooldown = math.max(dispenseCooldown - tickInterval, 0)
		if dispenseCooldown > 0 then
			return
		end

		for _, fuel in reactor:GetFuel() do
			if fuel <= 0 then
				dispenser:Dispense()
				dispenseCooldown = DISPENSE_COOLDOWN
				break
			end
		end
	end)
end
