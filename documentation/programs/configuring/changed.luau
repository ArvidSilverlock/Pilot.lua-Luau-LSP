local TRACKED_CONFIGURABLE = "Seek"

local object = GetPart("Gyro")
local previousConfiguration = object[TRACKED_CONFIGURABLE]

object.Configured:Connect(function()
	local currentConfiguration = object[TRACKED_CONFIGURABLE]
	if currentConfiguration == previousConfiguration then
		return
	end

	print(`{object}'s '{TRACKED_CONFIGURABLE}' configurable was changed from {previousConfiguration} to {currentConfiguration}!`)

	previousConfiguration = currentConfiguration
end)
