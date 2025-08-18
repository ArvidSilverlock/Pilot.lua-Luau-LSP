-- Try and get the screen part, throw an error if we don't find it using `assert`.
local screen = assert(GetPart("Screen"), "no screen connected")

-- Clear the left over screen elements from the last time GUIs were loaded onto it.
-- Note: If you utilise the `Instance.new` API instead, you do not need to do this,
--       as objects created through said API are *automatically* deleted when the
--       microcontroller stops running.
screen:ClearElements()

-- Call the `CreateElement` method with the `ClassName` of the object you want to create,
-- and a dictionary of the properties to apply (you cannot specify the `Parent` property).
local textLabel = screen:CreateElement("TextLabel", {
	Text = "Hello, world!",
	Size = UDim2.fromScale(1, 1),
	BorderSizePixel = 0,
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
})

-- Keep the microcontroller on by permanently 'yielding' the code (making it wait).
coroutine.yield()
