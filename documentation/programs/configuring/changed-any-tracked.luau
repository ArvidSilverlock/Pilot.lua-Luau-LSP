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

local object = GetPart()

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
