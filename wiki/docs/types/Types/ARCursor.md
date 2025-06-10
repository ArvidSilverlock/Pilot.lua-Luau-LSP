# ARCursor

This is manually transcribed.

## Player

The name of the player the cursor is for.

It is a <code>string</code>

## UserId

The user ID of the player.

It is a <code>number</code>

## Origin

A CFrame indicating where the mouse originated from. It is positioned at the camera and oriented toward the mouse's 3D position.

It is a <code>Vector3</code>

## UnitRay

A Ray directed toward the mouse's position in 3D space. It originates from the CFrame of the camera. Like all unit rays, it has a magnitude of 1.

It is a <code>Ray</code>

## WorldPosition

The world position of the mouse cursor.

It is a <code>Vector3</code>

## Target

The PartObject that is being hovered over. You can call methods on this part!

It is a <code>PilotObject</code>

## Pressed

A boolean for whether or not the mouse button is pressed.

It is a <code>boolean</code>

## UserInput

A table of input data (would suggest printing with repr) - Contains Mouse, Keyboard, Gamepad, VREnabled, KeyboardEnabled, TouchEnabled, GamepadEnabled, and LastInputType.

It is an <code>ARInput</code>

## ScreenPosition

The XY screen position of the mouse cursor.

It is a <code>Vector2</code>

## UserCFrames

Contains <code>Head</code>, <code>LeftHand</code>, and <code>RightHand</code> <code>CFrame</code>s for VR.

### Head

The <code>CFrame</code> of the user's head

### Right Hand

The <code>CFrame</code> of the user's right hand

### Left Hand

The <code>CFrame</code> of the user's left hand

## X

The <code>X</code> position of the cursor on the screen.

It is a <code>number</code>

## Y

The <code>Y</code> position of the cursor on the screen.

It is a <code>number</code>

## VirtualWorldPosition

The world position of the mouse cursor in the virtual 3D space.

It is a <code>Vector3</code>

## Hit

The <code>CFrame</code> the user's mouse is located at.

It is a <code>CFrame</code>

## VirtualTarget

The hovered part in the virtual 3D space.

It is a <code>BasePart</code>

## MouseDelta

The current chane in position of the mouse for the frame that was sent.

It is a <code>Vector2</code>

## Camera

The camera of the player associated with the mouse.

It is an <code>ARCamera</code>
