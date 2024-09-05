local Type = {}

function Type.parse(input: any)
	if typeof(input) == "table" then
		if
			#input > 0
			and typeof(input[1]) == "string"
			and (input[1]:match("^and%??$") or input[1]:match("^or%??$"))
		then
			local operation = input[1]
			local output = {}

			for index = 2, #input do
				table.insert(output, Type.parse(input[index]))
			end

			local concatenation = table.concat(output, if operation:match("^and") then " & " else " | ")
			return if operation:sub(-1, -1) == "?" then `({concatenation})?` else concatenation
		elseif #input > 0 and typeof(input[1]) == "string" and input[1] == "?" then
			return `({Type.parse(input[2])})?`
		elseif typeof((next(input))) == "string" then
			local output = {}

			for key, value in input do
				local formattedKey = if key:sub(1, 1) == "[" and key:sub(-1, -1) == "]"
					then key
					elseif key:match("^[_%a][_%w]*$") then key
					else `[{string.format("%q", key)}]`
				table.insert(output, `{formattedKey}: {Type.parse(value)}`)
			end

			return `\{ {table.concat(output, ", ")} }`
		else
			local output = {}
			for _, string: string in input :: any do
				table.insert(output, string.format("%q", string))
			end
			return table.concat(output, " | ")
		end
	else
		return input
	end
end

return Type
