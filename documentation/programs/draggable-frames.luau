-- Get the touch screen.
local screen = assert(Network:GetPart("TouchScreen"), "expected touch screen to be connected")

-- Initialise our lists of draggable frames and the currently dragged frames.
local frames = {}
local dragging = {}

-- Create 100 random draggable frames.
local canvasSize = screen:GetDimensions()
for index = 1, 100 do
	-- Random colour, size and position (position will avoid going off-screen).
	local colour = Color3.new(math.random(), math.random(), math.random())
	local sizeX, sizeY = math.random(20, 100), math.random(20, 100)
	local positionX, positionY = math.random(0, canvasSize.X - sizeX), math.random(0, canvasSize.Y - sizeY)

	-- Create the frame.
	local frame = Instance.new("Frame")
	frame.BorderSizePixel = 0
	frame.BackgroundColor3 = colour
	frame.Size = UDim2.fromOffset(sizeX, sizeY)
	frame.Position = UDim2.fromOffset(positionX, positionY)
	frame.ZIndex = index
	frame.Parent = screen:GetCanvas()

	-- Register it as draggable.
	frames[frame] = true
end

-- This is not optimised, you can replace it with a more optimised version.
-- You can do lots of things, like maintaining the highest frames at the front
-- of your frames list, or grouping frames based on their positions & sizes
-- as to reduce the amount of frames to check for any given position.
local function findFrameAtPosition(position: Vector2): (Frame?, number)
	local candidate = nil
	local maxZIndex = 0

	-- For each of the frames.
	for frame in frames do
		-- If this is a new biggest ZIndex, register it. Otherwise, if it
		-- is lower than the current selection candidate, ignore it.
		if frame.ZIndex > maxZIndex then
			maxZIndex = frame.ZIndex
		elseif candidate and frame.ZIndex <= candidate.ZIndex then
			continue
		end

		-- Compute the position relative to the frame, so (0, 0) is top
		-- left and (1, 1) is bottom right.
		local relativePosition = (position - frame.AbsolutePosition) / frame.AbsoluteSize

		-- If it's within the bounds, we're hovered over it, this is our
		-- new candidate.
		if
			relativePosition.X >= 0
			and relativePosition.Y >= 0
			and relativePosition.X <= 1
			and relativePosition.Y <= 1
		then
			candidate = frame
		end
	end

	return candidate, maxZIndex
end

screen.CursorPressed:Connect(function(cursor)
	-- Find the frame the user is hovered over.
	local cursorPosition = Vector2.new(cursor.X, cursor.Y)
	local selectedFrame, maxZIndex = findFrameAtPosition(cursorPosition)

	if not selectedFrame then
		return
	end

	-- Move the selected frame to the top.
	selectedFrame.ZIndex = maxZIndex + 1

	-- Get the cursor's position relative to the top left corner of the frame.
	local positionalOffset = selectedFrame.AbsolutePosition - cursorPosition

	-- Register the fact this cursor is dragging this frame.
	dragging[cursor.Player] = { frame = selectedFrame, offset = positionalOffset }
end)

screen.CursorMoved:Connect(function(cursor)
	-- If they're not dragging anything, cancel.
	local selected = dragging[cursor.Player]
	if not selected then
		return
	end

	-- If they've deselected it, say as much then cancel.
	if not cursor.Pressed then
		dragging[cursor.Player] = nil
		return
	end

	-- Extract the frame, the frame's parent, and the cursor offset.
	local selectedFrame, offset = selected.frame, selected.offset
	local parent = selectedFrame.Parent

	-- If there's a parent, we have to account for the possibility of the parent
	-- not being in the top left corner. We just add the cursor offset to the
	-- current cursor position.
	local targetPosition = if parent
		then UDim2.fromOffset(
			cursor.X + offset.X - parent.AbsolutePosition.X,
			cursor.Y + offset.Y - parent.AbsolutePosition.Y
		)
		else UDim2.fromOffset(cursor.X + offset.X, cursor.Y + offset.Y)

	-- Just update the position.
	selectedFrame.Position = targetPosition
end)
