return require("tween") :: {
	GetValue: (
		self: Tween,
		alpha: number,
		easingStyle: Enum.EasingStyle,
		easingDirection: Enum.EasingDirection
	) -> number,
}
