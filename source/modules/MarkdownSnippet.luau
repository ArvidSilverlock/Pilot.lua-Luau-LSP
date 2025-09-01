local Snippet = require("./Snippet")

local MarkdownSnippet = Snippet.new() :: any
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

function MarkdownSnippet.Insert(self: MarkdownSnippet, index: number?, value: any?)
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

function MarkdownSnippet.BlockStart(self: MarkdownSnippet, block: string)
	self:Push("<", block, ">")
	return self
end

function MarkdownSnippet.BlockEnd(self: MarkdownSnippet, block: string)
	self:Push("</", block, ">")
	return self
end

function MarkdownSnippet.InlineWrap(self: MarkdownSnippet, block, ...)
	self:BlockStart(block):Push(...):BlockEnd(block)
	return self
end

function MarkdownSnippet.MultilineWrap(self: MarkdownSnippet, block, ...)
	self:BlockStart(block):PushLine(...):BlockEnd(block)
	return self
end

function MarkdownSnippet.Delimiter(self: MarkdownSnippet)
	self:Push("\n\n---\n\n")
	return self
end

function MarkdownSnippet.BulletPointUp(self: MarkdownSnippet)
	self._bulletPointDepth += 1
	return self
end

function MarkdownSnippet.BulletPointDown(self: MarkdownSnippet)
	self._bulletPointDepth -= 1
	return self
end

function MarkdownSnippet.MemberHeader(self: MarkdownSnippet, id: string, title: string?, group: string?, depth: number?)
	if group and group ~= "group" then
		self:Delimiter()
	else
		self:Push("\n\n")
	end

	self:Push('<Member id="', id, '" group="', group, '"')

	if depth then
		self:Push(" depth={", depth, "}")
	end

	self:Push(">", title or id, "</Member>\n\n")

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
		return function(self: MarkdownSnippet, ...)
			self:PushLine(block):Push(...):PushLine(blockEnd)
			return self
		end, function(self: MarkdownSnippet)
			self:PushLine(block)
			return self
		end, function(self: MarkdownSnippet)
			self:PushLine(blockEnd)
			return self
		end
	else
		return function(self: MarkdownSnippet, ...)
			self:MultilineWrap(block, ...)
			return self
		end, function(self: MarkdownSnippet)
			self:BlockStart(block)
			return self
		end, function(self: MarkdownSnippet)
			self:BlockEnd(block)
			return self
		end
	end
end

MarkdownSnippet.Bold = createInlineWrapper("b")
MarkdownSnippet.Italic = createInlineWrapper("i")
MarkdownSnippet.Code, MarkdownSnippet.CodeStart, MarkdownSnippet.CodeEnd = createMultilineWrapper("```lua", "```")
MarkdownSnippet.InlineCode = createInlineWrapper("code")
MarkdownSnippet.Strikethrough = createInlineWrapper("del")

function MarkdownSnippet.AdmonitionStart(self: MarkdownSnippet, blockName: string, title: string?)
	self:Push("\n:::", blockName)
	if title then
		self:Push("[", title, "]")
	end
	self:Push("\n\n")
	return self
end

function MarkdownSnippet.AdmonitionEnd(self: MarkdownSnippet)
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

export type MarkdownSnippet = any

return MarkdownSnippet
