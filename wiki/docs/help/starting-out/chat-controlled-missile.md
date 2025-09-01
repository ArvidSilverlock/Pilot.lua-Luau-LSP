import ReactPlayer from "react-player";

# Chat Controlled Missile

This project will demonstrate using a [`Microphone`](/objects/Microphone) to launch a missile using [`Switch`](/objects/Switch), and a [`TriggerSwitch`](/objects/TriggerSwitch) to arm the warhead. It also contains code to detect if the player chatting is on the whitelist, and will only launch if the message contains a specified prefix.

![Missile](/image/examples/missile/structure.png)

**_Special configurations:_**

- Microcontroller: **StartOnSpawn** is **true**

```lua
-- see http://arvidsilverlock.github.io/Pilot.lua-Luau-LSP/modules/players
local players = require("players")

local microphone = assert(Network:GetPart("Microphone"), "no microphone connected")
local triggerswitch = assert(Network:GetPart("TriggerSwitch"), "no trigger switch connected")
local switch = assert(Network:GetPart("Switch"), "no switch connected")
local gyro = assert(Network:GetPart("Gyro"), "no gyro connected")

local WHITELIST = {
	-- replace with your username (case sensitive)...
	["xXnoob_slayer227Xx"] = true,
}

local PREFIX = "!"

local function missile(target)
	-- give power to the thruster
	switch.SwitchValue = true

	-- allow trigger signals from the touchsensor to detonate the energybomb
	triggerswitch.SwitchValue = true

	gyro.Seek = target
end

microphone.Chatted:Connect(function(player_id, message)
	-- make sure that this message was sent from
	-- a whitelisted player by converting player_id into username,
	-- then checking against the whitelist
	local player = players:GetUsername(player_id)
	if not WHITELIST[player] then
		return
	end

	-- process message, making sure that it starts with the prefix
	-- and if it does, we can launch the missile
	if message:sub(1, #PREFIX) ~= PREFIX then
		return
	end

	-- strip out prefix from message
	local target = message:sub(#PREFIX + 1)

	-- nuke em
	missile(target)
end)
```

<video controls width="100%" name="media">
	<source
		src="/Pilot.lua-Luau-LSP/image/examples/missile/video.mp4"
		type="video/mp4"
	/>
</video>

Model code:

```json
{
	"m": null,
	"t": "buffer",
	"zbase64": "KLUv/WDeDL0rAMpCKA5I8JTUAczhYXG0PgcuTZ+By/DjxBm4Gts/pWHRlgojUu4IyN0o7UbAj4oPza5oBPiFeCgftQqAp9eTrYoTL4g4i7O1nRLptjsF2wDaAL0AKRTqpDQCgDJA2kQcaRP9KJss+et9MbcIKEDAZADIJAbBJBJ9QCUlplFM1MVevK0U6+5+xuUVZzYBpC4ACNRtAkPSn+7OZiYFy4uDBQkODpwAwDDBpEKgoE5KI1Fo624SqLvBzBPcukPc1nVzoM/W3Ruou9TdMlb0xkZIgm+JrB9FfJxOp1h3w3aQRpL05OjujsV0d6vgOALr8e7uEN1BhMhwvlisg3jo7r5RkwHWo5IK0jNk7IYJ6aahoUGwIqLCA9ZBehrW0w0kxUIPaaGjR3d3j7pHMbo/PN0Bj0u/pa25mCnN/5vj7K9ToNB5NfzlMzIvKFpmXkq4sLfmYm8txJmlUq3ynTH5XfzlX604s/ejpOexVKrVX1rS+Osvx/drc5z5OD87biAZLy4kSpzuj6O9udrP3o/CmE6YaBmBspVWuGtxfRnxKy1JJQYTEUKE4k4gFoRK4pcpTeZ+GNI7IyDlg4cOKZRPyQYZaVdq4f3aoiEDhgulVIXa/Zznys6PGLkotCacmEbciXWpi9AqAoQHpRMTd2qw8uGB49396bhtgS9QYG/NJaRikAABAgKqFMqJaRQgxQkrzfd3qv28JnPwM6bjZyrSfOb62PGkOaZi9jzF7H9L7K8zyQ8nxk96C6Q4q1X+vlbLkgJ+zlNkcXkeWN/zl+v8y7jsrYWdJyOt7D/PavODbrNj8SstaW+O43HWkGKn2XGcnfflOFu4Oi/7i9lt9vs0O/PfoSErf3hnXv1IMaakV0vzV8scFQOVv7zmhUQLixgbHogvb/aX36h4ajpgwIBxZNbWGh6VTee5XC7W79BMcX3sj+e38idnvQHg81ASYh7nl9hIKkckrChIqWZ8ZuTM+Ek6s3kuNzJilMw8wZkfZiuNRCGQyQvOQ4AaFy1otpIMN2KxIkaFgw7mRIQCmaBoLhbr7r86M6YjdD46svBMmK1PzTULrN955PvrlNVjXfAJ/vJcWp/Rm7G/Xs5q4K0LK1mJU1ZfLefodX7+NG/ht6Bn6jnUwTp5aM7fmb+Ycb4zY890kt7C/9k7A+t7vWX+e2OTbfUc2nksmvwuKfjlnZdxpTOcHlaq8734eX0xt2yu1AOA/KgBMVTKmUBmgqQgSZoDgAKhKavNARJAsIGoK5kxhMyMBCJyi1JQVHnwdAErZTI0sxznyPJ78tLWHk6x/vwtoFhUySh0vSL6J+jPjBiLaykE6eehVLRILOfgkdBDRzUveU4ZaSDIAhGOu5hzVR3f9g22WAx6KowuJsjW62tb8ihm12jnbZkhACY18Dknyh70heQvWllmbcLngOgihlEUtNAHVbxcQ9thm7QPZYaJo7rfkYJCmo0hiP4oiX3/oymmXP9j0vuQUDNjzhIjdgn5KdKy5wzTTvX/bnqSG10+AhZR82Ho/9XSlkyMPa80OkVhTvYDl9IaJRfRZ9ne1mvDWrYjmYb+6UhEjTwf3RPnUj5SZP4A0HY8gP1yfri6E3QSFEw0bM9u9EYuls1hHvjIBgk8EwWEtK5KZ922D7herP53eP/kdQAsC3rX+QMH9g7YaAdCj/JlWotCKn0p0VKAl/5QwV7Gnuih79106WbGHkBXEHAt72yKnr2qHVD4ijDM9Y3V00qQ+dWAN9B7Yh7/1w3FeJsJe0SnNpufGk1jrCrdwuAddZZYKplHXhmNBOYjDTfzkBF7LAUiZeERX5+ZU191BVMEUexZs/ufm5tnYR+Yei/Rngy7elkTDTsGRHFrS47xFFtiKzU="
}
```
