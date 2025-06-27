-- define names of people who are allowed.
local WHITELIST = {
	ArvidSilverlock = true,
	-- could also do `["ArvidSilverlock"] = true,`
}

local sift = require("sift") -- fancy module provided by wos to modify tables

-- try and find the connected keyboard, throw an error if we don't find one
local keyboard = assert(GetPart("Keyboard"), "no keyboard connected!")

-- make one big table with all the `Extractor`s and `MiningLaser`s
local connectedObjects = sift.Array.concat(GetParts("Extractor"), GetParts("MiningLaser"))

keyboard.TextInputted:Connect(function(rawText, username)
	-- don't run the code if the person who inputted text into the keyboard isn't whitelisted
	if not WHITELIST[username] then
		return
	end

	-- remove the trailing line break the game leaves
	local strippedText = rawText:gsub("\n$", "")

	-- iterate over every object that is connected and assign the `MaterialToExtract` configurable to the keyboard input
	for _, object in connectedObjects do
		object.MaterialToExtract = strippedText
	end
end)
