# Assert

You'll see assert calls dotted around, often doing things such as:

```lua
local screen = assert(GetPart("Screen"), "no screen connected")
```

This may be confusing to people who have never seen assert before, but all it is doing, is taking the first parameter, checking if it is <code>false</code> or <code>nil</code>, and if it _is_, throwing the text in the second parameter as an error, but if it _isn't_, it returns the first parameter.

For example, doing something like:

```lua
local value = assert(32, "value is nil!") -- this will run fine
print(value) -- '32'
```

```lua
-- This will error
local value = assert(nil, "value is nil!") -- 'value is nil!'
print(value) -- this will not run
```

This same logic applies to the return value of <code>GetPart(s)(FromPort)</code>, allowing us to easily throw useful errors if no object is connected, which helps prevents the whole class of "attempt to index nil with ..." relating to objects being disconnected.

Another benefit of this is for people who use full typechecking (most easily accessible in Visual Studio Code, using the [typechecking part of this wiki](https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP?tab=readme-ov-file#installation)), it removes the warnings about the possibility of the object being `nil` whenever you reference members of it.
