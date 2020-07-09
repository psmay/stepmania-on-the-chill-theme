
local _Utility = {}

-- Create a new list by applying `transform()` to each element of `source`.
function _Utility.map(source, transform)
	local result = {}
	local count = #source
	for i = 1, count do
		result[i] = transform(source[i])
	end
	return result
end

-- Creates a new list by applying `transform()` to each index and element of `source`.
function _Utility.imap(source, transform)
	local result = {}
	local count = #source
	for i = 1, count do
		result[i] = transform(i, source[i])
	end
	return result
end

-- Appends all elements of `source` to the end of `destination`.
function _Utility.push_all(destination, source)
	for i, v in ipairs(source) do
		table.insert(destination, v)
	end
	return destination
end

-- This returns a copy of the `source` sorted by the key selected using the `key_selector()` function. A `nil` key is
-- treated as equal to another `nil` key. Otherwise, a `nil` key is sorted after (if not `nil_values_first`) or before
-- (if `nil_values_first`) any non-`nil` value. If two keys are equal, the order from the `source` is preserved.
function _Utility.sorted_by_key(source, key_selector, nil_values_first)
	nil_values_first = nil_values_first or false

	local rows = Utility.imap(source, function(i, v)
		return {
			i = i,
			v = v,
			k = key_selector(v),
		}
	end)

	-- In Lua, a compare function(a,b) is expected to return a < b.
	-- If a == b, the result is expected to be false.
	local function comparer(a, b)
		if a.k == b.k then
			return a.i < b.i
		elseif a.k ~= nil then
			if b.k ~= nil then
				return a.k < b.k
			else
				-- a.k is defined, b.k is nil
				return not nil_values_first
			end
		else
			-- a.k is nil, b.k is defined
			return nil_values_first
		end
	end

	table.sort(rows, comparer)

	return Utility.map(rows, function(row)
		return row.v
	end)
end

Utility = _Utility
