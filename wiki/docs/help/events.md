# Events

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
