return require("players") :: {
	GetUserId: (self: Players, username: string) -> number,
	GetUsername: (self: Players, userId: number) -> string,
}
