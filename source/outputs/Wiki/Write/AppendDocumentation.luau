local fs = require("@lune/fs")
local serde = require("@lune/serde")

local MarkdownSnippet = require("../../../modules/MarkdownSnippet")

local rawPartData = serde.decode("json", fs.readFile("documentation/partdata.json")) :: any

local CodeSamples = require("./CodeSamples")
local sortedIterate = require("../SortedIterate")
local sizes = require("../FindPossibleSizes")

local function appendDocumentation(
	output: MarkdownSnippet.MarkdownSnippet,
	object: any,
	metadata: any?,
	dontWriteDescription: boolean?,
	objectName: string?,
	imageLink: string?
)
	if imageLink then
		output
			:PushLine('<div class="clearfix">')
			:Indent()
			:PushLine('<img src="', imageLink, '" style={{float: "right", marginRight: "1em"}} />')
	end

	if typeof(object.documentation) == "string" then
		if not dontWriteDescription then
			output:PushLine(object.documentation)
		end
		return
	elseif typeof(object.documentation) ~= "table" then
		return
	end

	local documentation = object.documentation

	if typeof(documentation) == "table" then
		if documentation.description and not dontWriteDescription then
			output:Push(documentation.description)
		end

		local incrementSuffix = if documentation.increment
			then ", and an increment of " .. documentation.increment
			else ""
		if documentation.minimum then
			output:PushLine("It has a minimum value of ", documentation.minimum, incrementSuffix, ".")
		elseif documentation.maximum then
			output:PushLine("It has a maximum value of ", documentation.maximum, incrementSuffix, ".")
		else
			if documentation.range then
				output:PushLine("It ranges between ", documentation.range[1], " and ", documentation.range[2], ".")
			end
			if documentation.increment then
				output:PushLine("It increments by ", documentation.increment, ".")
			end
		end
	elseif documentation and not dontWriteDescription then
		output:Push(documentation)
	end

	if documentation.length then
		output:PushLine("It will always have a length of ", documentation.length, ".\n")
	elseif documentation["max-length"] then
		output:PushLine("It has a maximum length of ", documentation["max-length"], ".\n")
	end

	local rawData = rawPartData.Parts[objectName]
	if rawData then
		output:Push("\n")

		output:Push(
			`It is a{if rawData.Craftable and rawData.Spawnable
				then " craftable and spawnable"
				elseif rawData.Craftable then " craftable"
				elseif rawData.Spawnable then " spawnable"
				else ""} {if rawData.Flammable then "flammable" else "non-flammable"} {if rawData.ClassState
				then rawData.ClassState:lower()
				else "object"}.\n\n`
		)

		if rawData.ResourceType and rawData.ResourceAmount then
			if rawData.ResourceType == "Power" then
				output:Push(`It consumes {rawData.ResourceAmount} power per tick.\n\n`)
			elseif rawData.ResourceType ~= "Trigger" then
				output:Push(`It generates {rawData.ResourceAmount} <code>{rawData.ResourceType}</code> per tick.\n\n`)
			end
		end

		if rawData.Malleability == 0 then
			output:Push(`It cannot be resized.\n\n`)
		elseif rawData.Malleability then
			local possibleSizes = sizes.findPossibleSizes(rawData.Malleability)
			if #possibleSizes > 0 then
				output:Push(
					`Here is a list of possible sizes that reach the maximum malleability ({rawData.Malleability}) that have integer components: `
				)
				output:Push(table.concat(possibleSizes, ", "))
				output:Push("\n\n")
			else
				output:Push(
					"It has a malleability of ",
					rawData.Malleability,
					". You cannot reach this size with only integer components.\n\n"
				)
			end
		end

		local defaultSize = sizes.formatSize(unpack(rawData.BaseSize))

		if rawData.BaseDurability == "inf" then
			output:Push("It has infinite durability and a default size of ", defaultSize, ".\n\n")
		elseif rawData.BaseDurability then
			local baseVolume = rawData.BaseSize[1] * rawData.BaseSize[2] * rawData.BaseSize[3]
			output:Push("At its default size (", defaultSize, ") it has a durability of ", rawData.BaseDurability)

			if rawData.Malleability and rawData.Malleability > 0 then
				output:Push(
					", at its maximum size it has a durability of ",
					math.floor((rawData.Malleability / baseVolume) ^ (1 / 3) * rawData.BaseDurability + 1)
				)
			end

			output:Push(".\n\n")
		elseif rawData.BaseSize then
			output:PushLine("It has a default size of ", defaultSize, ".\n\n")
		end

		if rawData.Color then
			local hex = string.format("%02x%02x%02x", unpack(rawData.Color))
			output:PushLine(
				"By default, its colour is <span style={{color: '#{",
				hex:upper(),
				"'}}>#",
				hex,
				"</span>.\n"
			)
		end

		if rawData.Recipe then
			local recipe = { "It requires " }
			for key, value in sortedIterate(rawData.Recipe) do
				table.insert(recipe, `{value} <code>{key}</code>`)
				if #recipe > 1 then
					table.insert(recipe, ", ")
				end
			end

			if #recipe > 3 then
				recipe[#recipe - 2] = if #recipe == 5 then " and " else ", and "
				recipe[#recipe] = " "
			end
			table.insert(recipe, "to be crafted.")

			output:Push(table.concat(recipe) .. "\n\n")
		end
	end

	if imageLink then
		output:Dedent():PushLine("\n</div>")
	end

	if metadata then
		metadata.tags = if documentation.categories then table.clone(documentation.categories) else {}
	end

	CodeSamples.addCodeSamples(output, object)
end

return appendDocumentation
