---
sidebar_position: 3
---

# Screens & User Interfaces

In Waste of Space, you can make UI elements using <code>Instance.new</code>, however it must be through a [`Screen`](/objects/Screen) or an [`ARController`](/objects/ARController), and you must parent the element to the _canvas_ of the part. For more info on each element, see [Roblox's official UI guide](https://create.roblox.com/docs/ui)

Note: at the time of writing, TextBoxes do not sync their values to serverside (where microcontroller code runs). Use alternative methods of input instead (keyboard, microphone)

![Screen demo](/image/examples/screen/green.png)

```lua
local screen = assert(Network:GetPart("Screen"), "no screen connected")
-- we need to parent UI instances to canvas (wont render otherwise)
-- if you wanted to use an AR controller, simply replace screen with it
-- local canvas = AR controller:GetCanvas("2D")
local canvas = screen:GetCanvas()

local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(1, 1)
frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
frame.Parent = canvas

coroutine.yield()
```

To make parts in 3D space (AR controller), first Instance.new a Part then parent to the 3D canvas instead.

![ARController demo](/image/examples/screen/purple.png)

```lua
local arController = assert(Network:GetPart("ARController"), "no ar controller connected")
local canvas = arController:GetCanvas("3D")

-- spawn a part at y = 1024 (this is the height of the top of the baseplate)
local part = Instance.new("Part")
part.Size = Vector3.new(8, 8, 8)
part.Position = Vector3.new(0, 1024, 0)
part.Color = Color3.fromRGB(255, 0, 242)
part.Shape = Enum.PartType.Ball
part.Parent = canvas

coroutine.yield()
```
