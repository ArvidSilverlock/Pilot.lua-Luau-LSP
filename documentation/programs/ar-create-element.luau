-- Try and get the ar controller, throw an error if we don't find it using `assert`.
local screen = assert(GetPart("ARController"), "no ar controller connected")

-- Clear the left over screen elements from the last time GUIs were loaded onto it.
-- Note: If you utilise the `Instance.new` API instead, you do not need to do this,
--       as objects created through said API are *automatically* deleted when the
--       microcontroller stops running.
screen:ClearElements()

-- We're going to spawn 32 randomly sized/coloured/positioned cubes.
for index = 1, 32 do
	-- Generate a random `Vector3` in a -16 to 16 cube region.
	local position = Vector3.new(math.random(-16, 16), math.random(-16, 16), math.random(-16, 16))

	-- This may be confusing if you've never worked with `CFrame`s, 'why is pi here?'
	-- the reason is that pi is 180 degrees when working in 'radians' (the angle system
	-- used by `CFrame`s). `math.random` with *no* parameters returns a random decimal
	-- number between 0 and 1, so each parameter is just a number between 0 and pi.
	local orientation = CFrame.Angles(math.random() * math.pi, math.random() * math.pi, math.random() * math.pi)

	-- Select a size between 0 and 4 for all axes, `Vector3.one` is shorthand for
	-- `Vector3.new(1, 1, 1)`, we multiply it by a number between 1 and 4 and this
	-- gives us a vector with a side length of 1 to 4 on all axes.
	local size = Vector3.one * (1 + math.random() * 3)

	-- Pick a random colour with 3 `math.random` calls
	local color = Color3.new(math.random(), math.random(), math.random())

	-- Call the `CreateElement` method with the `ClassName` of the object you want to create,
	-- and a dictionary of the properties to apply (you cannot specify the `Parent` property).
	-- Note the `"3D"` context parameter, this says we want to use the instance viewport, you
	-- could alternatively use `CreateElement3D` to avoid this third parameter.
	local object = screen:CreateElement("Part", {
		CFrame = orientation + position + Microcontroller.Position,
		Size = size,
		Color = color,
		TopSurface = Enum.SurfaceType.Smooth, -- The `Top` and `Bottom` surfaces
		BottomSurface = Enum.SurfaceType.Smooth, -- have a stud pattern by default.
	}, "3D")
end

-- Keep the microcontroller on by permanently 'yielding' the code (making it wait).
coroutine.yield()
