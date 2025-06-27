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
