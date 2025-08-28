local UPDATES_PER_TICK = 16 -- How many times to rotate per tick, higher is smoother.
local ANGLE_INCREMENT = 4 -- Every 1/UPDATES_PER_TICK seconds increment the servo angle by this.
local SHIFT_HELD_MULTIPLIER = 0.25 -- When shift is held, multiply the angle increment by this.

-- Who can rotate the servos.
local WHITELIST = {
	[1178125707] = true,
}

-- Get references to all the hardware, everything is *required* except for the
-- seat, which is optional.
local yawServo = assert(Network:GetPartFromPort(1, "Servo"), "no yaw servo connected")
local pitchServo = assert(Network:GetPartFromPort(2, "Servo"), "no pitch servo connected")
local keyboard = assert(Network:GetPart("Keyboard"), "no keyboard connected")
local seat = Network:GetPart("Seat")

-- Make sure the servos are wired properly!
assert(yawServo ~= pitchServo, "there is only one servo connected")

local servoAngles = {}
local heldKeys = {}

local function incrementAngle(servo, direction)
	-- Make the `ANGLE_INCREMENT` negative if the direction is specified as `-1`
	-- with a bit of multiplication.
	local baseIncrement = ANGLE_INCREMENT * direction

	-- If we need to initialise the target angle of the servo:
	if not servoAngles[servo] then
		-- Rotate it back to 0 degrees and initialise the current state.
		servo:SetAngle(0)
		servoAngles[servo] = 0
	end

	-- Here we return a new function, that when called, applies the angle increment
	-- operation to the servo, this is a trick called a "closure".
	return function()
		-- Calculate the new angle, check if we're holding shift, if we are multiply
		-- the increment by the `SHIFT_HELD_MULTIPLIER`
		local multiplier = if heldKeys[Enum.KeyCode.LeftShift] then SHIFT_HELD_MULTIPLIER else 1
		local currentAngle = baseIncrement * multiplier

		-- Update both the real and internal servo angle.
		servo:SetAngle(currentAngle)
		servoAngles[servo] = currentAngle
	end
end

-- Register all of the angle incrementing functions that should keep running
-- whilst the user keeps holding the bind.
local HOLD_BINDS = {
	[Enum.KeyCode.W] = incrementAngle(pitchServo, 1),
	[Enum.KeyCode.A] = incrementAngle(yawServo, 1),
	[Enum.KeyCode.S] = incrementAngle(pitchServo, -1),
	[Enum.KeyCode.D] = incrementAngle(yawServo, -1),
}

-- Register all of the general binds that only run on key down.
local BINDS = {
	[Enum.KeyCode.F] = function()
		TriggerPort(3) -- Assume port 3 has something like guns!
	end,
}

-- If we have a seat, we can detect when the user gets up and clear all the
-- held keys as if they stopped inputting.
if seat then
	seat.OccupantChanged:Connect(function(occupant)
		if occupant then
			return
		end -- If someone just sat down, cancel
		table.clear(heldKeys) -- Whereas if someone got up, clear the held keys
	end)
else
	-- Provide a warning about issues that might occur when no seat is connected.
	warn([[There is no seat connected to the microcontroller!
              If a player jumps whilst holding an input, the input will get stuck!]])
end

keyboard.UserInput:Connect(function(input, userId)
	-- Check if the user is whitelisted, if they're not, cancel.
	if not WHITELIST[userId] then
		return
	end

	-- If the bind pressed has a function to run on key down, run it.
	if BINDS[input.KeyCode] then
		local callback = BINDS[input.KeyCode]
		callback()
	end

	-- If the user *started* pressing the key, register it as held, otherwise
	-- deregister it.
	if input.UserInputState == Enum.UserInputState.Begin then
		heldKeys[input.KeyCode] = true
	elseif input.UserInputState == Enum.UserInputState.End then
		heldKeys[input.KeyCode] = nil
	end
end)

-- For each tick we want to call all the functions that should run for held keys.
-- You could alternatively use a simple `while true do` loop, but this keeps it
-- tick aligned, and tick alignment may provide benefits in some cases.
Microcontroller.Loop:Connect(function(tickDuration)
	for index = 1, UPDATES_PER_TICK do
		for key, callback in HOLD_BINDS do
			-- If we're not holding this bind, look at the next bind.
			if not heldKeys[key] then
				continue
			end
			callback()
		end

		-- Wait a little for for the next time we should update.
		task.wait(tickDuration / UPDATES_PER_TICK)
	end
end)
