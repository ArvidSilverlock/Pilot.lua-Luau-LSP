# Keeping Your Microcontroller Enabled

## The problem

A simple program like this, one that does something, but only once, then never does anything again won't work.

```lua
local screen = assert(Network:GetPart("Screen"), "no screen connected")

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.fromScale(1, 1)
textLabel.Text = "Hello, World!" -- very original, i know
textLabel.Parent = screen:GetCanvas()
```

This is because, when the microcontroller realises its work is done _it will turn itself off_, and, when a microcontroller turns itself off, any instances that it created will all be destroyed by the game (except ones made through [`Screen:CreateElement()`](/objects/Screen#CreateElement)!).

You may be wondering why doesn't this happen with more complex programs, like the following:

```lua
-- get the library for converting user ids to usernames
local players = require("players")

-- get the objects
local lifeSensor = assert(Network:GetPart("LifeSensor"), "no life sensor connected")
local screen = assert(Network:GetPart("Screen"), "no screen connected")

-- add the text label we're outputting the usernames on
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.fromScale(1, 1)
textLabel.Text = ""
textLabel.Parent = screen:GetCanvas()

-- every game tick
Microcontroller.Loop:Connect(function()
	-- retrieve the user ids of the players in the game
	local userIds = lifeSensor:ListPlayers()

	-- convert each user id to the player's username
	local usernames = {}
	for _, userId in userIds do
		table.insert(usernames, players:GetUsername(userId))
	end

	-- output the text on the screen
	local text = table.concat(usernames, ", ")

	-- only update it if it's changed, don't want to keep refiltering the text
	if textLabel.ContentText ~= text then
		textLabel.Text = text
	end
end)
```

Well, this is because, when you connect an event in Waste of Space, _it automatically keeps your microcontroller on_ until all your events are disconnected! This means that you don't need to manually keep your microcontroller running if you have an event connected (same goes for when you have a `while true do` loop, as _there is still code running_)

## How to fix it?

To resolve this, there are a handful of methods, the preferred one is the following:

```lua
-- your code

coroutine.yield()
```

This works because `coroutine.yield()` is sort of just doing `task.wait(infinity)` (for more technical people, you may think `task.wait(math.huge)` would work the same, but waiting `math.huge` or `nan` seconds just waits 0 seconds instead!).

Some other alternatives include:

```lua
-- your code

task.wait(1e9) -- wait 1 billion seconds!
```

This is kind of yucky, what if, hypothetically, you were in the server for a billion seconds! it would turn off!

```lua
-- your code

while true do
	task.wait(1)
end
```

This is also a bit yucky, you're basically telling roblox 'hey, check up on me every single second' and, when roblox checks up on you, you just do nothing!
