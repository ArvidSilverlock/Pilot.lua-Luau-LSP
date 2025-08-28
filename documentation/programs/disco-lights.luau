local sift = require("sift") -- Grab this fancy library for manipulating tables provided by wos.

-- Get all of the types of objects with a `:SetColor` method and merge them into one big table.
local objects = sift.Array.merge(
	Network:GetParts("Light"),
	Network:GetParts("LightTube"),
	Network:GetParts("SpotLight"),
	Network:GetParts("EnergyShield")
)

-- We want this to run infinitely, but we want to run it every frame, rather than every game
-- tick, so we won't use the `Microcontroller.Loop` event.
while true do
	-- First we want to get the current time, the function `os.clock` gives us a very precise
	-- measurement of the current time (if you want to know, it basically uses the internal
	-- clock of the computer running the code).
	local currentTime = os.clock()

	-- We then use the 'modulo' operator, what this does is it gives you the 'remainder'
	-- from the division. So if you do something like `5.25 % 1` you get out the `0.25`,
	-- or if you do, say, `31 % 2`, since 31 isn't divisble by 2 you get a remainder of `1`.

	-- We do this so we just get the fractional aspect of the time (which would be the
	-- milliseconds), giving us a number between 0 and 1.
	local hue = currentTime % 1

	-- We then construct a `Color3` passing in the value we just calculated, which, since
	-- we used the modulo operator is always going to be between 0 and 1, the exact range
	-- needed for the 'hue' of the `fromHSV`. We just set the 'saturation' and 'brightness'
	-- to 1 to keep the colour nice and bright.

	-- A helpful feature of the HSV colour space is that a hue of both `0` and `1` are red!
	local color = Color3.fromHSV(hue, 1, 1)

	-- Now we have our colour, we just want to apply it to all of our objects, so we'll use
	-- a simple for loop. The 'index' or 'key' value is named '_' since we don't need it,
	-- and naming it '_' is a good way to say it's an unused variable.
	for _, object in objects do
		-- Simply call the `SetColor` method (since it's a method, we use a `:` when
		-- calling the function, rather than a `.`) passing in the `Color3`!
		object:SetColor(color)
	end

	-- Wait a little bit before updating the colour again!
	task.wait()
end
