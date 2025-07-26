Provides several functions for working with [<code>Coordinate</code>s](/types/Universe%20Info/Coordinates)

Note that you will see references to a 'CoordinateBounds' type, this is just an array structed as:

```lua
{
	Vector2.new(-100, 100), -- universe x ranges from -100 to 100 (inclusive)
	Vector2.new(-100, 100), -- universe y ranges from -100 to 100 (inclusive)
	Vector2.new(-10, 10), -- solar x ranges from -10 to 10 (inclusive)
	Vector2.new(-10, 10), -- solar y ranges from -10 to 10 (inclusive)
}
```

That being, an array containing for <code>Vector2</code>s, each one representing the minimm and maximum value for that component of the coordinate.

### new(ux, uy, sx, sy, inPlanet)

<code>ux</code> and <code>uy</code> are integers and represent the universe <code>X</code> and <code>Y</code> coordinaes of the resulting coordinate.

<code>sx</code> and <code>sy</code> are integers and represent the solar <code>X</code> and <code>Y</code> coordinaes of the resulting coordinate.

<code>inPlanet</code> is a boolean as to whether the resulting coordinate should represent a planet or a planets orbit.

### fromString(coordinate, bounds)

Returns a <code>Coordinate</code> given the familiar format of a string <code>"0, 0, 0, 0, false"</code>.

<code>bounds</code> is a <code>CoordinateBounds</code>, and will clamp the <code>coordinate</code> string.

### fromVectors(universeCoordinate, solarCoordinate, inPlanet)

Returns a <code>Coordinate</code> given the format <code>Vector2.new(universeX, universeY), Vector2.new(solarX, solarY), false</code>. This function does not apply any <code>CoordinateBounds</code>.

### DEFAULT_COORDINATE_BOUNDS

A <code>CoordinateBounds</code> of ±100 for universe coordinates and ±10 for solar coordinates.

### NO_COORDINATE_BOUNDS

A completely unbounded <code>CoordinateBounds</code> of ±∞ for universe coordinates and ±∞ for solar coordinates.
