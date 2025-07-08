# Events

## Introduction

The events section of the pages shows the information in the format of <code>EventName(parameterA, parameterB)</code>, to connect to an event like this you would do:

```lua
object.EventName:Connect(function(parameterA, parameterB)
	print("Event fired!")
end)
```

Events also return 'connections', these can be used to _disconnect_ the event (i.e., stop it from running in future).

```lua
local connection = object.EventName:Connect(function(parameterA, parameterB)
	print("Event fired!")
end)

task.wait(5) -- Wait 5 seconds before disconnecting the event.

connection:Disconnect() -- You can alternatively use `connection:Unbind()`
```

This code will only accept the event for 5 seconds.

## `Event:Wait()` and `Event:Once()`

You may be familiar with roblox's events, these are not like that, they do not implement `Event:Wait()` or `Event:Once()`.

### `Event:Once()`

Here's how you do `Event:Once()`. This is actually how we did it (and still sometimes do, when you need to conditionally disconnect!) before `Event:Once()` was a feature in roblox.

```lua
local connection
connection = object.EventName:Connect(function()
	connection:Disconnect()
	-- code
end)
```

`connection` is declared before you initialise it with the event connection because, if you do it otherwise, you won't have access to the variable from within the connection.

If you're wondering why we define `connection` like that, you can read about it [here](https://www.lua.org/pil/6.2.html) (scroll down to the part about `local function`, it's sort of like that).

### `Event:Wait()`

Here's how you do `Event:Wait()`, this may be confusing to people who don't understand threads and coroutines.

```lua
local awaiting = coroutine.running()

local connection
connection = object.EventName:Connect(function(...)
	connection:Disconnect()
	coroutine.resume(awaiting, ...)
end)

local eventParameterA, eventParameterB = coroutine.yield()
```

See how we borrow the code for `Event:Once()` but with some extra 'coroutine' stuff?

What we're doing is getting the currently running coroutine (thread, code, whatever) and making it wait, but before making it wait, we connect to the event we want to wait for (and make it disconnect after being fired once) and then resuming the code that we just paused (and passing the event parameters through with `...`).
