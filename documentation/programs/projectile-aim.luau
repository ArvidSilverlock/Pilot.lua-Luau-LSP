local PROJECTILE_GRAVITY = 100
local PROJECTILE_SPEED_PER_BARREL_STUD = {
	Artillery = 75,
	Cannon = 50,
}

-- Point a gyro in a direction such that the provided projectile launcher (often
-- an artillery or cannon) perfect hits the target.
local function pointAtTarget(
	gyro: Gyro,
	projectileLauncher: (Artillery | Cannon | PilotObject)?,
	target: Vector3,
	solution: ("direct" | "indirect")?
): Vector3?
	local lookVector

	local projectileSpeed = if projectileLauncher
		then PROJECTILE_SPEED_PER_BARREL_STUD[projectileLauncher.ClassName]
		else nil

	if projectileSpeed then
		local gyroCFrame = CFrame.lookAt(gyro.Position, Vector3.new(target.X, gyro.Position.Y, target.Z))
		local relativeCFrame = gyroCFrame:PointToObjectSpace(target)

		local dx, dy = -relativeCFrame.Z, relativeCFrame.Y
		local velocity = projectileLauncher.Size.Y * projectileSpeed

		local discriminant = velocity ^ 4 - PROJECTILE_GRAVITY * (PROJECTILE_GRAVITY * dx ^ 2 + 2 * dy * velocity ^ 2)
		if discriminant < 0 then
			return
		end

		local solutionSign = if solution == "indirect" then 1 else -1

		local yDirection = velocity ^ 2 + math.sqrt(discriminant) * solutionSign
		local xDirection = PROJECTILE_GRAVITY * dx
		local pitch = math.atan2(yDirection, xDirection)

		local lookCFrame = gyroCFrame * CFrame.Angles(pitch, 0, 0)
		lookVector = lookCFrame.LookVector
	else
		lookVector = (target - gyro.Position).Unit
	end

	gyro:PointAlong(lookVector)

	return lookVector
end
