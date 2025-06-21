An incredibly simple library, exposes roblox's [<code>Players:GetNameFromUserIdAsync</code>](https://developer.roblox.com/api-reference/function/Players/GetNameFromUserIdAsync) and [<code>Players:GetUserIdFromNameAsync</code>](https://developer.roblox.com/api-reference/function/Players/GetNameFromUserIdAsync), likely with some modification.

I am unsure whether these functions error or return <code>nil</code> in the event of failure.

<code>players:GetUsername(userId)</code> returns the username a player given their user ID.
<code>players:GetUserId(username)</code> returns the user ID a player given their username.

You can see an example of it being used in the [<code>LifeSensor</code>](/objects/LifeSensor) documentation.
