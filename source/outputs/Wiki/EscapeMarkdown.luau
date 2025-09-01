local function escapeMarkdown(text)
	local markdownCharacters = [[\`*_{}[%]()#+-.!|<>]]
	return (text:gsub("([" .. markdownCharacters .. "])", "\\%1"))
end

return escapeMarkdown
