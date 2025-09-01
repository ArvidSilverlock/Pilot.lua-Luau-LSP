# Player Targeting UI

This project will demonstrate how to use a [`LifeSensor`](/objects/LifeSensor) along with a screen to display a targetting UI with player selection and a big red fire button.

![Targetting UI](/image/examples/screen/turret.png)

```lua
local screen = assert(Network:GetPart("Screen"), "expected screen to be connected")
local canvas = screen:GetCanvas("2D")

local lifeSensor = assert(Network:GetPart("LifeSensor"), "expected life sensor to be connected")
local gyro = assert(Network:GetPart("Gyro"), "expected gyro to be connected")
local guns = Network:GetParts("Gun")

local scrollingFrame
local targetDisplay
local playerElements = {}

local function fireWeapons()
	for _, gun in guns do
		gun:Trigger()
	end
end

local function updateInterface()
	local players = lifeSensor:GetReading()

	-- update player list
	local index = 0
	for player, _ in pairs(players) do
		if not playerElements[player] then
			local element = Instance.new("TextButton")
			element.Size = UDim2.fromScale(1, 0.05)
			element.Position = UDim2.fromScale(0.0, index * 0.05)
			element.Text = player

			element.MouseButton1Click:Connect(function()
				-- on click, set gyro target
				gyro.Seek = player
				targetDisplay.Text = player
			end)

			playerElements[player] = element

			element.Parent = scrollingFrame
		end

		index += 1
	end

	index = 0
	for player, element in pairs(playerElements) do
		-- this player left, destroy their corresponding UI element
		if not players[player] then
			playerElements[player]:Destroy()
			playerElements[player] = nil
			continue
		end

		element.Position = UDim2.fromScale(0.0, index * 0.05)
		index += 1
	end

	return players
end

do -- construct the ui
	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromScale(1, 1)
	frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	frame.Parent = canvas

	scrollingFrame = Instance.new("ScrollingFrame")
	scrollingFrame.Size = UDim2.fromScale(0.5, 1)
	scrollingFrame.Parent = frame

	targetDisplay = Instance.new("TextLabel")
	targetDisplay.Size = UDim2.fromScale(0.5, 0.1)
	targetDisplay.Position = UDim2.fromScale(0.5, 0.0)
	targetDisplay.Text = "nil"
	targetDisplay.Parent = frame

	local fireButton = Instance.new("TextButton")
	fireButton.Size = UDim2.fromScale(0.5, 0.2)
	fireButton.Position = UDim2.fromScale(0.5, 0.8)
	fireButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	fireButton.Text = "Fire"
	fireButton.Parent = frame

	fireButton.MouseButton1Click:Connect(fireWeapons)
end

while true do
	updateInterface()
	task.wait(1)
end
```

Model code:

```json
{
	"m": null,
	"t": "buffer",
	"zbase64": "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"
}
```
