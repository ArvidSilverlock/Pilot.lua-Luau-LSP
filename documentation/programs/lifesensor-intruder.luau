-- Get access to the Waste of Space provided 'module' that lets us access player usernames if
-- we provide it a `UserId`.
local players = require("players")

-- Create a whitelist of `UserId`s, it uses a 'dictionary' format, where the keys are the `UserId`s
-- and the values are `true` so we can access whether someone is whitelisted by doing `WHITELIST[userId]`
-- rather than `table.find(WHITELIST, userId)`, which is both cleaner and "faster" (faster is in quotes
-- because the performance difference is minimal if you only have a few people in your whitelist)
local WHITELIST = {
	[1178125707] = true,
}

-- Don't know your `UserId`? You can find it at runtime by using the `players:GetUserId("YourUsername")`
-- function. Note that this will add a bit of extra overhead (if you're not in the server, waste of
-- space has to make a web request), so it is not reccomended.
-- local WHITELIST = {
--     [players:GetUserId("ArvidSilverlock")] = true,
-- }

-- Try and get the life sensor, throw an informative error if we don't find it using `assert`.
local lifeSensor = assert(GetPart("LifeSensor"), "no life sensor connected")

-- Create a 'function' that we'll run whenever we find a player outside of the whitelist.
-- You may notice the `: number` and `: CFrame`, these are 'types', they tell luau what types
-- of values variables are storing (the `CFrame?` just means `CFrame` or `nil`), which helps
-- with autofill and linting (linting is the squiggly lines that show up when you do bad things)
local function foundThreat(threatUserId: number, position: CFrame?)
	-- Get the player's username from their `UserId` using the `players` module that is
	-- provided by Waste of Space via `require("players")`.
	local threatUsername = players:GetUsername(threatUserId)

	-- If we have been given the position (and therefore the player is within the life sensor range)
	-- then we can utilise the player's position in our operations.
	if position then
		-- What we do here is get the position of the target player *relative* to the life sensor,
		-- then get the 'magnitude' of the resulting value, which is the fancy way of saying 'length'.
		local distance = (position.Position - lifeSensor.Position).Magnitude

		-- Output the player's username and their distance.
		print(`There is a threat! Their name is {threatUsername} and they are {math.floor(distance)} studs away!`)
	else
		-- Output just the player's username, and add a note about how they're too far away to know their distance.
		print(`There is a threat! Their name is {threatUsername}! They are too far away to tell their distance.`)
	end
end

-- Connect to the `Loop` event of the `Microcontroller` that is running the code,
-- this will make the code within run precisely every game tick.
Microcontroller.Loop:Connect(function()
	-- Get an 'array' of the player `UserId`s, this function ignores the range limit.
	local presenceReading = lifeSensor:ListPlayers()

	-- This one returns a 'dictionary' where the keys are the player `UserId's`, and
	-- the values are the positions of the specific players, but it only includes
	-- players within 2,000 studs of the `LifeSensor`, which is why we need
	-- the result of `ListPlayers`.
	local positionalReading = lifeSensor:GetPlayers()

	-- Iterate over each of the players returned by `ListPlayers`, the 'index' variable is
	-- called `_` as is customary when defining a variable that is not ever used.
	for _, userId in presenceReading do
		-- If the user is whitelisted, skip to the next player using a `continue` statement.
		if WHITELIST[userId] then
			continue
		end

		-- Here, we try and get the player's position from the `GetPlayers` dictionary, if the
		-- player is outside of the `LifeSensor`'s range, this will be `nil` and *won't* throw
		-- any sort of error.
		local playerPosition = positionalReading[userId]

		-- Merely call the `foundThread` function, giving it the user who we're talking about,
		-- along with their position (their position *may* or *may not* be specified.)]

		-- Note: If you were to do some computation within `foundThread` that takes a lot of
		--       time (or maybe has a `task.wait` or two), you would want to do something
		--       like `task.spawn(foundThread, userId, playerPosition)` instead, as this
		--       will allow this function to keep looking for other players whilst the
		--       `foundThreat` function is running (rather than waiting for it to finish).
		--       Look into the roblox task scheduler if you want to know more.
		foundThreat(userId, playerPosition)
	end
end)
