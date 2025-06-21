An incredibly simple library, does not actually provide support for <code>Tween</code> instances, but rather exposes [<code>TweenService:GetValue()</code>](https://create.roblox.com/docs/reference/engine/classes/TweenService#GetValue), a simple function that remaps a number between <code>0</code> and <code>1</code> based on <code>TweenService</code> interpolation styles.

Here is an example program written using the <code>tween</code> library to tween a <code>GuiObject</code>'s position, given a target, duration and easing style/direction.

```lua
local tween = require("tween")

local function tweenPosition(object: GuiObject, targetPosition: UDim2, duration: number, easingStyle: Enum.EasingStyle?, easingDirection: Enun.EasingDirection?)
	local initialPosition = object.Position
	local alpha = 0

	repeat
		local remappedAlpha = tween:GetValue(alpha, easingStyle, easingDuration)
		object.Position = initialPosition:Lerp(targetPosition, remappedAlpha)

		local deltaTime = task.wait() / duration
		alpha = math.min(alpha + deltaTime, 1)
	until alpha == 1

	object.Position = targetPosition
end

-- This function *yields* (waits) until the tween completes, if you didn't want it to wait, you could do:
task.spawn(tweenPosition, object, targetPosition, duration, easingStyle, easingDirection)

-- Instead of:
tweenPosition(object, targetPosition, duration, easingStyle, easingDirection)
```

If you do not wish to grapple directly with the <code>tween</code> library, you can use [this](https://discord.com/channels/616089055532417036/1281197116030713897) module that losely replicates the behaviour of <code>TweenService</code>.
