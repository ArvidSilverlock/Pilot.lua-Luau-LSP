export type CoordinateBounds = { Vector2 }
return {} :: {
    new: (ux: number, uy: number, sx: number, sy: number, inPlanet: boolean) -> Coordinate,
    fromVectors: (UniverseCoordinates: Vector2, SolarCoordinates: Vector2, inPlanet: boolean) -> Coordinate,
    withBounds: (
        bounds: CoordinateBounds,
        ux: number,
        uy: number,
        sx: number,
        sy: number,
        inPlanet: boolean
    ) -> Coordinate,
    fromString: (coordinate: string, bounds: CoordinateBounds?) -> Coordinate,
    DEFAULT_COORDINATE_BOUNDS: CoordinateBounds,
    NO_COORDINATE_BOUNDS: CoordinateBounds,
}
