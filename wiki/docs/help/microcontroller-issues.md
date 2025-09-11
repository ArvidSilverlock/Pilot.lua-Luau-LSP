# Known Microcontroller Issues

Here is a list of bugs that are known about microcontrollers that are not yet patched:

## `_PLTinterruptCheck` Syntax Errors

Issues [#461](https://github.com/Eggs-D-Studios/wos-issues/issues/461) and [#547](https://github.com/Eggs-D-Studios/wos-issues/issues/547) are related to the insertion of Waste of Space's interrupt checks (related to game crash prevention) being unable to handle return types properly.

Speculation as to the cause (specifically of #461, #547 is only triggered if you are intentionally trying to):

```lua
local function foobar(): number -- works, `:` token is read, `number` token is skipped.

end
```

```lua
local function foobar(): { [string]: number } -- fails, `:` token is read, `{` token is skipped, `_PLTinterruptCheck` inserted here incorrectly
	local foobar = 32
	return { a = foobar }
end
```

A fix for the above is as follows:

```lua
local function foobar(): { [string]: number }
	do end -- works, I cannot tell you why it correctly skips the tokens in this context, though
	local foobar = 32
	return { a = foobar }
end
```
