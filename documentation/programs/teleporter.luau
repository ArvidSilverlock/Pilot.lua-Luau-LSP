local coordinate = require("coordinate")

local teleporter = assert(Network:GetPart("Teleporter"), "expected teleporter to be connected")
local keyboard = assert(Network:GetPart("Keyboard"), "expected keyboard to be connected")

local FALSE_TELEPORTER_COORDINATES = coordinate.new(0, 0, 0, 0, false)

keyboard.TextInputted:Connect(function(text)
	teleporter.Coordinates = coordinate.fromString(text)
	teleporter:Trigger()
	teleporter.Coordinates = FALSE_TELEPORTER_COORDINATES
end)
