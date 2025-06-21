--[[
An array of 4 `Vector2`s, the first being the min & max ux, the second being the min & max uy, the third being the min and max sx, and the fourth being the min and max sy
]]
export type CoordinateBounds = { Vector2 }

return require("coordinate") :: {
	new: (ux: number, uy: number, sx: number, sy: number, inPlanet: boolean) -> Coordinate,
	withBounds: (
		bounds: CoordinateBounds,
		ux: number,
		uy: number,
		sx: number,
		sy: number,
		inPlanet: boolean
	) -> Coordinate,
	fromString: (coordinate: string, bounds: CoordinateBounds?) -> Coordinate,
	--- NOTE: Does not apply any coordinate bounds
	fromVectors: (universeCoordinate: Vector2, solarCoordinate: Vector2, inPlanet: boolean) -> Coordinate,

	--- The default bounds of the universe
	DEFAULT_COORDINATE_BOUNDS: CoordinateBounds,
	--- Unlimited boundaries
	NO_COORDINATE_BOUNDS: CoordinateBounds,
}
