local fs = require("@lune/fs")

local CodeSamples = {}

function CodeSamples.addIndividualCodeSample(output, codeSample)
	if not codeSample then
		return
	end

	output:Push("\n```lua\n")

	local source = if codeSample:match("^.-%.luau$")
		then fs.readFile(`documentation/programs/{codeSample}`)
		else codeSample
	local trimmedSource = source:match("^%s*(.-)%s*$")
	output:Push(trimmedSource)

	output:Push("\n```")
end

function CodeSamples.addCodeSamples(output, data)
	if typeof(data.documentation) ~= "table" then
		return
	end

	if data.documentation["code-sample"] then
		CodeSamples.addIndividualCodeSample(output, data.documentation["code-sample"])
	end

	local codeSamples = data.documentation["code-samples"]
	if codeSamples then
		for _, codeSample in codeSamples do
			CodeSamples.addIndividualCodeSample(output, codeSample)
		end
	end
end

return CodeSamples
