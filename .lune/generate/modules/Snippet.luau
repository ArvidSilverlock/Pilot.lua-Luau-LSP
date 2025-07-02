local Snippet = {}
Snippet.__index = Snippet

function Snippet.new(name: string?)
	local self = setmetatable({
		_lines = {},
		_indent = 0,
	}, Snippet)

	return self
end

function Snippet:Insert(index: number?, value: any?)
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

	table.insert(text, (str:gsub("\n\t*", "\n" .. indent):gsub("\n%s+\n", "\n\n")))
	table.insert(self._lines, index or #self._lines + 1, table.concat(text))

	return self
end

function Snippet:NewLine(count: number?)
	self:Push(string.rep("\n", count or 1))
	return self
end

function Snippet:Push(...: any)
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

function Snippet:PushLine(...: any)
	if select("#", ...) > 0 then
		self:Push(...)
		table.insert(self._lines, "\n")
	end
	return self
end

function Snippet:Indent(amount: number?)
	self._indent += amount or 1
	return self
end

function Snippet:Dedent(amount: number?)
	self._indent -= amount or 1
	self._lines[#self._lines] = self._lines[#self._lines]:gsub("\t+", function(str)
		return string.rep("\t", math.max(#str - (amount or 1), 0))
	end)
	return self
end

function Snippet:ConditionalPush(condition: boolean?, ...: any)
	if condition then
		self:Push(...)
	end
	return self
end

function Snippet:Call(callback: (any, ...any) -> (), ...: any)
	callback(self, ...)
	return self
end

function Snippet:ConditionalCall(condition: boolean?, callback: (any, ...any) -> (), ...: any)
	if condition then
		callback(self, ...)
	end
	return self
end

function Snippet:Break()
	table.insert(self._lines, "")
	return self
end

function Snippet:__tostring(): string
	return table.concat(self._lines, "")
end

function Snippet.isSnippet(value: any?): boolean
	return type(value) == "table" and getmetatable(value) == Snippet
end

return Snippet
