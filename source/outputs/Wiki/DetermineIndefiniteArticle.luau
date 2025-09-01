-- Hardcoded indefinite articles for all uses. This is to avoid non-phonetic spellings messing with the articles.
local indefiniteArticles = {
	json = "a",
	range = "a",
	network = "a",
	port = "a",
	random = "a",
	callback = "a",
	event = "an",
	file = "a",
	arcursor = "an",
	blade = "a",
	boolean = "a",
	canvas = "a",
	cframe = "a",
	color = "a",
	component = "a",
	coordinates = "a",
	coupler = "a",
	cursor = "a",
	enum = "an",
	folder = "a",
	frame = "a",
	handle = "a",
	instance = "an",
	instrument = "an",
	microcontroller = "a",
	modem = "a",
	number = "a",
	object = "an",
	one = "a", -- not used anywhere, but included just in case
	part = "a",
	permission = "a",
	pilot = "a",
	player = "a",
	polysilicon = "a",
	region = "a",
	relay = "a",
	remote = "a",
	resource = "a",
	scanner = "a",
	sound = "a",
	string = "a",
	user = "a",
	vector = "a",
	vehicle = "a",
	world = "a",
}

local function determineIndefiniteArticle(str)
	local firstWord = (str:match("^%u*%l*") or str):lower()
	local indefiniteArticle = indefiniteArticles[firstWord]

	-- Guess the indefinite article based on the first letter, not reliable ('an umbrella' vs 'a uniform').
	if not indefiniteArticle then
		warn(`No guarantee the used indefinite article of '{firstWord}' is correct.`)
		return if table.find({ "a", "e", "i", "o" }, str:sub(1, 1):lower()) then "an" else "a"
	end

	return indefiniteArticle
end

return determineIndefiniteArticle
