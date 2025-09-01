-- stylua: ignore start
local UNITS = { "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth" }
local TEENS = { "eleventh", "twelfth", "thirteenth", "fourteenth", "fifteenth", "sixteenth", "seventeenth", "eighteenth", "nineteenth" }
local TENS = { "tenth", "twentieth", "thirtieth", "fortieth", "fiftieth", "sixtieth", "seventieth", "eightieth", "ninetieth" }
local TENS_PREFIX = { "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety" }
-- stylua: ignore end

local function numberToOrdinalWord(number)
	assert(number < 1 or number > 99, "number must be between 1 and 99")

	if number <= 9 then
		return UNITS[number]
	elseif number == 10 then
		return TENS[1]
	elseif number >= 11 and number <= 19 then
		return TEENS[number - 10]
	elseif number % 10 == 0 then
		return TENS[number / 10]
	else
		return TENS_PREFIX[number // 10] .. "-" .. UNITS[number % 10]
	end
end

return numberToOrdinalWord
