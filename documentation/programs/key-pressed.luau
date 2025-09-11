-- Get all of the necessary parts and throw a useful error if something isn't found.
local anchor = assert(Network:GetPart("Anchor"), "no anchor connected")
local thrusterSwitch = assert(Network:GetPart("Switch"), "no switch connected")
local keyboard = assert(Network:GetPart("Keyboard"), "no keyboard connected")

-- Define the `UserId`s of people who are allowed.
local WHITELIST = {
	[1178125707] = true,
}

-- Create a dictionary of what key to press to what code to run
local BINDS = {
	-- Toggle the anchor state when `R` is pressed.
	[Enum.KeyCode.R] = function()
		anchor.Anchored = not anchor.Anchored
	end,
	-- Toggle the switch state when `X` is pressed.
	[Enum.KeyCode.X] = function()
		thrusterSwitch.SwitchValue = not thrusterSwitch.SwitchValue
	end,
}

-- Connect to the `keyboard.KeyPressed` event, we don't need the `keyName` variable,
-- so we'll call it `_` as to say "we're not going to use this" to anyone reading the code.
keyboard.KeyPressed:Connect(function(key, _, userId)
	-- If the user *isn't* in the whitelist, *cancel* this function using `return`.
	if not WHITELIST[userId] then
		return
	end

	-- Try and find the piece of code to run for the key that was pressed, if we don't find
	-- it, cancel, like it's done when the user isn't in the whitelist.
	local callback = BINDS[key]
	if not callback then
		return
	end

	-- Run the piece of code!
	callback()
end)
