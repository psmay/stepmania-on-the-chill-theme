
local _Smotc = {}

-- Create a new list by applying `transform()` to each element of `source`.
function _Smotc.map(source, transform)
	local result = {}
	local count = #source
	for i = 1, count do
		result[i] = transform(source[i])
	end
	return result
end

-- Creates a new list by applying `transform()` to each index and element of `source`.
function _Smotc.imap(source, transform)
	local result = {}
	local count = #source
	for i = 1, count do
		result[i] = transform(i, source[i])
	end
	return result
end

-- Appends all elements of `source` to the end of `destination`.
function _Smotc.push_all(destination, source)
	for i, v in ipairs(source) do
		table.insert(destination, v)
	end
	return destination
end

-- This returns a copy of the `source` sorted by the key selected using the `key_selector()` function. A `nil` key is
-- treated as equal to another `nil` key. Otherwise, a `nil` key is sorted after (if not `nil_values_first`) or before
-- (if `nil_values_first`) any non-`nil` value. If two keys are equal, the order from the `source` is preserved.
function _Smotc.sorted_by_key(source, key_selector, nil_values_first)
	nil_values_first = nil_values_first or false

	local rows = Smotc.imap(source, function(i, v)
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

	return Smotc.map(rows, function(row)
		return row.v
	end)
end

-- Collects and returns information about current stage.
-- * stage: e.g. "Stage_1st", "Stage_Final"
-- * number: e.g. 1 (for "Stage_1st"), contains correct number for "Stage_Next"
-- * is_numbered_stage: true if number should be displayed instead of short_name
-- * play_mode: e.g. "PlayMode_Rave", "PlayMode_Endless"
-- * short_name: e.g. "1st", "Endless" (from combination of stage and play_mode)
-- * is_course: true if currently playing a course
-- * title: Title of course or song
-- * artist: Artist (when not is_course)
-- * course_type: Course type (when is_course)
-- * length_info: Course stage count and time (when is_course) or song time
function _Smotc.get_current_stage_info()
	local info = {
		stage = GAMESTATE:GetCurrentStage(),
		number = GAMESTATE:GetCurrentStageIndex() + 1,
		play_mode = GAMESTATE:GetPlayMode(),
		is_course = GAMESTATE:IsCourseMode(),
	}

	local should_use_stage_for_short_name_if_mode = {
		PlayMode_Regular = true,
		PlayMode_Rave = true,
		PlayMode_Battle = true,
	}

	local stage_or_mode = info.play_mode
	if should_use_stage_for_short_name_if_mode[info.play_mode] then
		stage_or_mode = info.stage
	end

	info.short_name = ToEnumShortString(stage_or_mode)

	local stage_with_short_name_uses_number = {
		["1st"] = true,
		["2nd"] = true,
		["3rd"] = true,
		["4th"] = true,
		["5th"] = true,
		["6th"] = true,
		Next = true,
	}
	
	info.is_numbered_stage = (stage_with_short_name_uses_number[info.short_name] == true)
	
	if info.is_course then
		local course = GAMESTATE:GetCurrentCourse()
		info.title = course:GetDisplayFullTitle()
		info.course_type = ToEnumShortString(course:GetCourseType()) 

		local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
		local trail_time = SecondsToMSSMsMs(TrailUtil.GetTotalSeconds(trail))
		local estimated_stage_count = course:GetEstimatedNumStages()
		local stage_or_stages = estimated_stage_count == 1 and "Stage" or "Stages"
		info.length_info = estimated_stage_count .. " " .. stage_or_stages .. " / " .. trail_time
	else
		local song = GAMESTATE:GetCurrentSong()
		info.title = song:GetDisplayFullTitle()
		info.artist = song:GetDisplayArtist()
		info.length_info = SecondsToMSSMsMs(song:MusicLengthSeconds())
	end

	return info
end

-- Gets the path for a pre-rendered StepTech word.
function _Smotc.get_rendered_text_path(key, outline_kind)
	if outline_kind == nil then
		outline_kind = "fulloutline"
	end
	return THEME:GetPathG("_StepTech display", "text/" .. outline_kind .. " " .. key)
end

-- Gets the path for a pre-rendered StepTech halfoutline word.
function _Smotc.get_rendered_half_outline_text_path(key)
	return _Smotc.get_rendered_text_path(key, "halfoutline")
end

Smotc = _Smotc
