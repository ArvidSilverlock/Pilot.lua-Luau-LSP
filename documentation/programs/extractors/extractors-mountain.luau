-- Define the list of resources to cycle through
local MOUNTAIN_RESOURCES = {
	"Stone",
	"Ruby",
	"Quartz",
	"Silicon",
	"Flint",
	"Sulfur",
	-- Remove the '--' if you also want to harvest these!
	-- "Ice",
	-- "Oil",
	-- "Helium",
}

-- how often we want to change what resource is being mined (in seconds)
local UPDATE_RATE = 1

local sift = require("sift") -- fancy module provided by wos to modify tables

-- make one big table with all the `Extractor`s and `MiningLaser`s
local connectedObjects = sift.Array.concat(GetParts("Extractor"), GetParts("MiningLaser"))

-- variable to keep track of which material is being mined
local resourceIndex = 1

-- variable to keep track of how long it's been since we last, start it off high so we immediately update
local timeSinceLastUpdate = math.huge

-- every game tick we want to change what resource is being mined
Microcontroller.Loop:Connect(function(deltaTime)
	-- increment how long it's been since we checked
	timeSinceLastUpdate += deltaTime

	-- if it's not been as long as we want since we last updated, exit out early
	if timeSinceLastUpdate < UPDATE_RATE then
		return
	end
	deltaTime %= UPDATE_RATE -- loop back round (i.e., 1.06 goes to 0.06 when UPDATE_RATE is 1)

	-- increment what resource we're currently meant to be mining
	resourceIndex += 1
	if resourceIndex > #MOUNTAIN_RESOURCES then
		resourceIndex = 1 -- loop back round when we reach the end of the list
	end

	-- get the name of the resource we want to mine
	local resource = MOUNTAIN_RESOURCES[resourceIndex]

	-- iterate over every object that is connected and assign the `MaterialToExtract` configurable
	for _, object in connectedObjects do
		object.MaterialToExtract = resource
	end
end)
