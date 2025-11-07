-- Get a reference to the telescope.
local telescope = assert(Network:GetPart("Telescope"), "expected telescope to be connected")

-- Keep track of 'threads' that are waiting for data.
local yieldingThreads = {}

-- Whenever region info is loaded, we need to pass it to the yielding threads.
telescope:WhenRegionLoads(function(regionInfo)
	-- Convert the region info coordinate to a string.
	local coordinateString = regionInfo.Coordinate:CoordStringWithoutPlanet()

	-- Look for the threads that want this coordinate info, do nothing if there aren't any.
	local yielding = yieldingThreads[coordinateString]
	if yielding then
		-- Resume all the threads that are waiting, providing the region info.
		for _, thread in yielding do
			coroutine.resume(thread, regionInfo)
		end
		-- Remove the threads from the waiting list.
		yieldingThreads[coordinateString] = nil
	end
end)

local function retrieveRegionInfo(coordinate: string): CompleteRegionInfo
	-- If another thread is already waiting, we need to add this thread to the
	-- existing list, otherwise create a new list with just this thread in it.
	if yieldingThreads[coordinate] then
		table.insert(yieldingThreads[coordinate], coroutine.running())
	else
		yieldingThreads[coordinate] = { coroutine.running() }
	end

	-- Set the view coordinates to the orbit of the planet.
	telescope.ViewCoordinates = `{coordinate}, false`

	-- Wait for a response
	return coroutine.yield()
end

-- Normally you would want this at the top of your script, but this is the "example use" area.
local repr = require("repr")

-- Retrieve information, this will automatically wait.
local data = retrieveRegionInfo("0, 0, 0, 0")
print(repr(data))
