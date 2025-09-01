local function sortedIterate<T>(dictionary: { [string]: T }, deprioritizeDeprecated: boolean?): () -> (string, T)
	local primary, secondary = {}, {}
	for key, value in dictionary do
		if
			typeof(value) == "table"
			and deprioritizeDeprecated
			and value.documentation
			and value.documentation.deprecated
		then
			table.insert(secondary, key)
		else
			table.insert(primary, key)
		end
	end

	table.sort(primary)
	if deprioritizeDeprecated then
		table.sort(secondary)
	end

	local index = 0
	return function()
		index += 1
		local key = primary[index] or secondary[index - #primary]
		return key, dictionary[key]
	end
end

return sortedIterate
