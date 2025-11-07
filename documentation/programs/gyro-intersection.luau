-- Given a list of gyros, you can estimate where they are all pointing.
-- You don't have to understand it, you just have to use it!
-- https://medium.com/data-science/intersect-multiple-3d-lines-closest-point-93e06b296f15
-- https://math.stackexchange.com/questions/61719
-- https://en.wikipedia.org/wiki/Skew_lines#More_than_two_lines
-- https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection#Nearest_points_to_skew_lines
local function estimateGyroTarget(gyros: { Gyro }): Vector3?
	local A = {
		{ 0, 0, 0 },
		{ 0, 0, 0 },
		{ 0, 0, 0 },
	}
	local b = { 0, 0, 0 }

	for _, gyro in gyros do
		local p = gyro.Position
		local u = gyro.CFrame.UpVector

		local ux, uy, uz = u.X, u.Y, u.Z
		local px, py, pz = p.X, p.Y, p.Z

		local M = {
			{ 1 - ux * ux, -ux * uy, -ux * uz },
			{ -ux * uy, 1 - uy * uy, -uy * uz },
			{ -ux * uz, -uy * uz, 1 - uz * uz },
		}

		for r = 1, 3 do
			for c = 1, 3 do
				A[r][c] += M[r][c]
			end
		end

		b[1] += M[1][1] * px + M[1][2] * py + M[1][3] * pz
		b[2] += M[2][1] * px + M[2][2] * py + M[2][3] * pz
		b[3] += M[3][1] * px + M[3][2] * py + M[3][3] * pz
	end

	for k = 1, 3 do
		local maxVal, piv = math.abs(A[k][k]), k
		for r = k + 1, 3 do
			local v = math.abs(A[r][k])
			if v > maxVal then
				maxVal, piv = v, r
			end
		end

		if maxVal < 1e-12 then
			return nil
		end

		if piv ~= k then
			A[k], A[piv] = A[piv], A[k]
			b[k], b[piv] = b[piv], b[k]
		end

		for i = k + 1, 3 do
			local f = A[i][k] / A[k][k]
			for j = k, 3 do
				A[i][j] -= f * A[k][j]
			end
			b[i] -= f * b[k]
		end
	end

	local x = { 0, 0, 0 }
	for i = 3, 1, -1 do
		local s = b[i]
		for j = i + 1, 3 do
			s -= A[i][j] * x[j]
		end
		x[i] = s / A[i][i]
	end

	return Vector3.new(x[1], x[2], x[3])
end

-- Get the AR controller and the gyros (make sure they are connected with assert)
local arController = assert(Network:GetPart("ARController"), "expected ar controller to be connected")
local gyros = Network:GetPartsFromPort(1, "Gyro")
assert(#gyros > 1, "there must be more than 1 gyro connected")

-- Configure all the gyros to seek an alien core
for _, gyro in gyros do
	gyro.Seek = "Radar AlienCore"
end

-- Create an indicator part on the AR controller
local point = Instance.new("Part")
point.Shape = Enum.PartType.Ball
point.Size = Vector3.one * 3
point.Transparency = 0.5
point.Material = Enum.Material.Neon
point.BrickColor = BrickColor.new("Bright green")
point.Parent = arController:GetCanvas("3D")

-- Every tick, estimate the target and update the indicator part, if it
-- fails to estimate the target, make the indicator red
Microcontroller.Loop:Connect(function()
	local intersection = estimateGyroTarget(gyros)
	if intersection then
		point.Position = intersection
		point.BrickColor = BrickColor.new("Bright green")
	else
		point.BrickColor = BrickColor.new("Bright red")
	end
end)
