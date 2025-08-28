local signal = require("signal")

local function getInstanceConfigurableChangedSignal(object: PilotObject, configurable: string)
	local signal = signal.new()

	local previousConfiguration = object[configurable]

	object.Configured:Connect(function()
		local currentConfiguration = object[configurable]
		if currentConfiguration == previousConfiguration then
			return
		end

		signal:Fire(currentConfiguration, previousConfiguration)

		previousConfiguration = currentConfiguration
	end)

	return signal
end

local gyro = assert(Network:GetPart("Gyro"), "no gyro connected!")
getInstanceConfigurableChangedSignal(gyro, "Seek"):Connect(function(currentConfiguration, previousConfiguration)
	print(`{object}'s 'Seek' configurable was changed from {previousConfiguration} to {currentConfiguration}!`)
end)
