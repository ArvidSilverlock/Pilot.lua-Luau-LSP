-- Try and get the screen part, throw an error if we don't find it using `assert`.
local screen = assert(Network:GetPart("Screen"), "no screen connected")

-- Store the current screen size.
local previousScreenSize = screen:GetDimensions()

-- Connect to the `Loop` event of the `Microcontroller` that is running the code,
-- this will make the code within run precisely every game tick.
Microcontroller.Loop:Connect(function()
	-- Get the new current screen dimensions.
	local screenSize = screen:GetDimensions()

	-- Compare these new dimensions with the previously recorded dimensions, if
	-- they are equal, cancel this running code with 'return'.
	if screenSize == previousScreenSize then
		return
	end

	-- Do something with the information about the screen dimensions changing,
	-- in this case, it triggers a print statement.
	print(`The screen size changed! It used to be {previousScreenSize}, but is now {screenSize}!`)

	-- Update the stored current dimensions as to make them accurately reflect reality.
	previousScreenSize = screenSize
end)
