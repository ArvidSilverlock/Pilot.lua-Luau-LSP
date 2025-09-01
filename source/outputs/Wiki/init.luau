local fs = require("@lune/fs")

local MarkdownSnippet = require("./../modules/MarkdownSnippet")

local partDocumentation = require("./../modules/PilotDocumentation")

local WIKI_DIRECTORY = "./wiki/docs/"

local generateTypePage = require("@self/Write/Types")
local generateObjectPage = require("@self/Write/Objects")

local Wiki = {}

function Wiki.generate(_options)
	local codeBlockLinks = {}
	local generatedPages = {
		objects = {},
		types = {},
	}

	generateTypePage("types", partDocumentation.types, nil, "", generatedPages, codeBlockLinks)

	for objectName, object in partDocumentation.classes do
		generatedPages.objects[objectName] = generateObjectPage(objectName, object, codeBlockLinks)
	end

	return generatedPages, codeBlockLinks
end

local function recursiveWrite(pages, path, codeBlockLinks)
	if not fs.isDir(path) then
		fs.writeDir(path)
	end

	for name, value in pages do
		if typeof(value) == "table" then
			recursiveWrite(value, `{path}/{name}`, codeBlockLinks)
			continue
		end

		local content = value:gsub("<code>(.-)</code>", function(match)
			local codeBlock = `<code>{match}</code>`
			return if codeBlockLinks[match] then `[{codeBlock}]({codeBlockLinks[match]})` else codeBlock
		end)

		local writePath = `{path}/{name}.mdx`
		if not fs.isFile(writePath) or fs.readFile(writePath) ~= content then
			fs.writeFile(writePath, content)
		end
	end
end

function Wiki.save(options, generatedPages, codeBlockLinks)
	recursiveWrite(generatedPages.objects, `{WIKI_DIRECTORY}/objects`, codeBlockLinks)
	recursiveWrite(generatedPages.types, `{WIKI_DIRECTORY}/types`, codeBlockLinks)

	local rawDocumentation = fs.readFile("documentation/documentation.yaml")
	local rawDocumentationSnippet = MarkdownSnippet.new(rawDocumentation)

	rawDocumentationSnippet
		:PushLine("Use Ctrl+F, or ⌘+F on Mac to search for information you need.")
		:NewLine()
		:PushLine("```yaml")
		:PushLine(rawDocumentation)
		:PushLine("```")

	fs.writeFile("./wiki/docs/raw-documentation.md", tostring(rawDocumentationSnippet))

	local contributingContent = fs.readFile("CONTRIBUTING.md")
	local contributingSections = {}

	for _, section in contributingContent:sub(3):split("\n# ") do
		local title, content = section:match("^(.-)\n(.*)")
		if title and content then
			local sanitizedTitle = title:match("^%s*(.-)%s*$"):gsub("%s+", "-"):gsub("[^%w%-]", ""):lower()
			contributingSections[sanitizedTitle] = "# " .. section
		end
	end

	local contributingDir = "./wiki/docs/contributing"
	if not fs.isDir(contributingDir) then
		fs.writeDir(contributingDir)
	end

	for title, content in contributingSections do
		local filePath = `{contributingDir}/{title}.md`
		fs.writeFile(filePath, content)
	end
end

return Wiki
