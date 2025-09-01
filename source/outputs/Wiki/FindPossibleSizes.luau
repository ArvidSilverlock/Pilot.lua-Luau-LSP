local sizes = {}

function sizes.formatSize(x, y, z)
	return (string.format("%.2fx%.2fx%.2f", x, y, z):gsub("%.00", ""):gsub("(%.%d)0*", "%1"))
end

-- This finds all possible sizes that multiply to the given malleability,
-- with each dimension being at most 2048 and an integer.
function sizes.findPossibleSizes(malleability)
	local possibleSizes = {}

	for i = 1, math.min(math.sqrt(malleability), 2048) do
		if malleability % i ~= 0 then
			continue
		end

		local remaining = malleability / i
		for j = i, math.min(math.sqrt(remaining), 2048) do
			if remaining % j ~= 0 then
				continue
			end

			local k = remaining / j

			local order = { i, j, k }
			table.sort(order)

			local formatted = sizes.formatSize(unpack(order))
			if k <= 2048 and not table.find(possibleSizes, formatted) then
				table.insert(possibleSizes, formatted)
			end
		end
	end

	return possibleSizes
end

return sizes
