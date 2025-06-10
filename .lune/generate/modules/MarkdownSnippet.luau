local Snippet = require("./Snippet")

local MarkdownSnippet = Snippet.new()
MarkdownSnippet.__index = MarkdownSnippet
MarkdownSnippet.__tostring = Snippet.__tostring

function MarkdownSnippet.new(title: string)
	local self = setmetatable({}, MarkdownSnippet)
	self.title = title
	self._lines = {}
	self._indent = 0
	self._bulletPointDepth = 0
	self._toc = {}
	return self
end

function MarkdownSnippet:Insert(index: number?, value: any?)
	local str = tostring(value)
	if str == nil or str == "" then
		return self
	end

	local indent = string.rep("\t", self._indent)
	local text = {}

	local prefix = ""
	if self._bulletPointDepth > 0 then
		prefix = string.rep("  ", self._bulletPointDepth) .. "- "
	end

	local previousLine = self._lines[#self._lines]
	if previousLine == nil or previousLine:match("\n%s*$") then
		table.insert(text, indent)
		table.insert(text, prefix)
	end

	table.insert(text, (str:gsub("\n", "\n" .. indent):gsub("\n%s+\n", "\n\n")))
	table.insert(self._lines, index or #self._lines + 1, table.concat(text))

	return self
end

function MarkdownSnippet:BlockStart(block: string)
	self:Push("<", block, ">")
	return self
end

function MarkdownSnippet:BlockEnd(block: string)
	self:Push("</", block, ">")
	return self
end

function MarkdownSnippet:InlineWrap(block, ...)
	self:BlockStart(block):Push(...):BlockEnd(block)
	return self
end

function MarkdownSnippet:MultilineWrap(block, ...)
	self:BlockStart(block):PushLine(...):BlockEnd(block)
	return self
end

function MarkdownSnippet:Delimiter()
	self:Push("\n\n---\n\n")
	return self
end

function MarkdownSnippet:BulletPointUp()
	self._bulletPointDepth += 1
	return self
end

function MarkdownSnippet:BulletPointDown()
	self._bulletPointDepth -= 1
	return self
end

function MarkdownSnippet:MemberHeader(id: string, title: string?, group: string?)
	if group and group ~= "group" then
		self:Delimiter():Push('<Member id="', id, '" group="', group, '">', title or id, "</Member>\n\n")
	else
		self:Push('\n\n<Member id="', id, '" group="group">', title or id, "</Member>\n\n")
	end
	-- table.insert(self._toc, `\{value: "{id .. if group == "method" then "()" else ""}", id: "{id}", "level": 3\}`)
	return self
end

local function createInlineWrapper(block)
	return function(self, ...)
		self:InlineWrap(block, ...)
		return self
	end
end

local function createMultilineWrapper(block: string, blockEnd: string?)
	if blockEnd then
		return function(self, ...)
			self:PushLine(block):Push(...):PushLine(blockEnd)
			return self
		end, function(self)
			self:PushLine(block)
			return self
		end, function(self)
			self:PushLine(blockEnd)
			return self
		end
	else
		return function(self, ...)
			self:MultilineWrap(block, ...)
			return self
		end, function(self)
			self:BlockStart(block)
			return self
		end, function(self)
			self:BlockEnd(block)
			return self
		end
	end
end

-- if isDeprecated then
-- 	table.insert(output, "\n:::warning\n\n") -- warning admonition
-- 	table.insert(output, "This method is deprecated.")
-- 	if typeof(isDeprecated) == "string" then
-- 		table.insert(output, " " .. isDeprecated)
-- 	end
-- 	table.insert(output, "\n\n:::\n\n")
-- end

MarkdownSnippet.Bold = createInlineWrapper("b")
MarkdownSnippet.Italic = createInlineWrapper("i")
MarkdownSnippet.Code, MarkdownSnippet.CodeStart, MarkdownSnippet.CodeEnd = createMultilineWrapper("```lua", "```")
MarkdownSnippet.InlineCode = createInlineWrapper("code")
MarkdownSnippet.Strikethrough = createInlineWrapper("del")

function MarkdownSnippet:AdmonitionStart(blockName: string, title: string?)
	self:Push("\n:::", blockName)
	if title then
		self:Push("[", title, "]")
	end
	self:Push("\n\n")
	return self
end

function MarkdownSnippet:AdmonitionEnd()
	self:PushLine("\n\n:::\n\n")
	return self
end

local function createAdmonitionWrapper(blockName: string)
	return function(self, ...)
		self:AdmonitionStart(blockName):Push(...):AdmonitionEnd()
		return self
	end
end

MarkdownSnippet.NoteAdmonition = createAdmonitionWrapper("note")
MarkdownSnippet.TipAdmonition = createAdmonitionWrapper("tip")
MarkdownSnippet.InfoAdmonition = createAdmonitionWrapper("info")
MarkdownSnippet.WarningAdmonition = createAdmonitionWrapper("warning")
MarkdownSnippet.DangerAdmonition = createAdmonitionWrapper("danger")

return MarkdownSnippet
