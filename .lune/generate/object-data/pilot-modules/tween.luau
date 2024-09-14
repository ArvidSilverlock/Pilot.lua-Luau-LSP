type Tween = {
	GetValue: (
		self: Tween,
		alpha: number,
		easingStyle: Enum.EasingStyle,
		easingDirection: Enum.EasingDirection
	) -> number,
}

return {} :: Tween
