type Players = {
	GetUserId: (self: Players, username: string) -> number,
	GetUsername: (self: Players, userId: number) -> string,
}

return require("players") :: Players
