local Snippet = {}
Snippet.__index = Snippet

function Snippet.new(): Snippet
	local self = setmetatable({
		_lines = {},
		_indent = 0,
	}, Snippet)

	return self
end

function Snippet.Insert(self: Snippet, index: number?, value: any?)
	local str = tostring(value)
	if str == nil or str == "" then
		return self
	end

	local indent = string.rep("\t", self._indent)
	local text = {}

	local previousLine = if index then self._lines[index - 1] else self._lines[#self._lines]
	if previousLine == nil or previousLine:match("\n$") then
		table.insert(text, indent)
	end

	table.insert(text, (str:gsub("\n", "\n" .. indent):gsub("\n%s+\n", "\n\n")))
	table.insert(self._lines, index or #self._lines + 1, table.concat(text))

	return self
end

function Snippet.StripTrailingWhitespace(self: Snippet)
	while #self._lines > 0 do
		self._lines[#self._lines] = self._lines[#self._lines]:gsub("%s+$", "")
		if self._lines[#self._lines] ~= "" then
			break
		end
		table.remove(self._lines)
	end
	return self
end

function Snippet.NewLine(self: Snippet, count: number?)
	self:Push(string.rep("\n", count or 1))
	return self
end

function Snippet.Push(self: Snippet, ...: any)
	for index = 1, select("#", ...) do
		local line = select(index, ...)
		if type(line) == "table" then
			for _, subLine in line._lines or line do
				self:Insert(nil, subLine)
			end
		elseif line ~= nil then
			self:Insert(nil, line)
		end
	end
	return self
end

function Snippet.PushLine(self: Snippet, ...: any)
	if select("#", ...) > 0 then
		self:Push(...)
		table.insert(self._lines, "\n")
	end
	return self
end

function Snippet.Indent(self: Snippet, amount: number?)
	self._indent += amount or 1
	return self
end

function Snippet.Dedent(self: Snippet, amount: number?)
	self._indent -= amount or 1
	self._lines[#self._lines] = self._lines[#self._lines]:gsub("\t+", function(str)
		return string.rep("\t", math.max(#str - (amount or 1), 0))
	end)
	return self
end

function Snippet.ConditionalPush(self: Snippet, condition: boolean?, ...: any)
	if condition then
		self:Push(...)
	end
	return self
end

function Snippet.Call(self: Snippet, callback: (any, ...any) -> (), ...: any)
	callback(self, ...)
	return self
end

function Snippet.ConditionalCall(self: Snippet, condition: boolean?, callback: (any, ...any) -> (), ...: any)
	if condition then
		callback(self, ...)
	end
	return self
end

function Snippet.Break(self: Snippet)
	table.insert(self._lines, "")
	return self
end

function Snippet.__tostring(self: Snippet): string
	return table.concat(self._lines, "")
end

function Snippet.isSnippet(value: any?): boolean
	return type(value) == "table" and getmetatable(value) == Snippet
end

export type Snippet = typeof(setmetatable(
	{} :: {
		_lines: { string },
		_indent: number,
	},
	Snippet
))

return Snippet
