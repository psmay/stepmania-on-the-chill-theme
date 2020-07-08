
-- TODO: Put this somewhere else
function map(source, transform)
	local result = {}
	local count = #source
	for i = 1, count do
		result[i] = transform(source[i])
	end
	return result
end

function imap(source, transform)
	local result = {}
	local count = #source
	for i = 1, count do
		result[i] = transform(i, source[i])
	end
	return result
end



-- This returns a copy of the source array sorted by the key selected using the key_selector function. A nil key is
-- treated as equal to another nil key. Otherwise, a nil key is sorted after any non-nil value (or before any non-nil
-- value if nil_values_first is true). If two keys are equal, the order from the original array is preserved.

function sorted_by_key(source, key_selector, nil_values_first)
	nil_values_first = nil_values_first or false

	local rows = imap(source, function(i, v)
		return {
			i = i,
			v = v,
			k = key_selector(v),
		}
	end)

	-- In Lua, a compare function(a,b) is expected to return a < b.
	-- If a == b, the result is expected to be false.
	local comparer = function(a, b)
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

	return map(rows, function(row)
		return row.v
	end)
end

function sorted_by_z_index(source)
	local key_selector = function(v)
		return v.z_index
	end
	return sorted_by_key(source, key_selector, true)
end

-- *********************

local SQ = 480

local get_current_stage_info = function()
	local info = {
		stage = GAMESTATE:GetCurrentStage(),
		number = GAMESTATE:GetCurrentStageIndex() + 1,
		play_mode = GAMESTATE:GetPlayMode(),
		is_course_mode = GAMESTATE:IsCourseMode(),
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
	
	if info.is_course_mode then
		local course = GAMESTATE:GetCurrentCourse()
		info.course_title = course:GetDisplayFullTitle()
		info.course_type = ToEnumShortString(course:GetCourseType()) 

		local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
		local trail_time = SecondsToMSSMsMs(TrailUtil.GetTotalSeconds(trail))
		local estimated_stage_count = course:GetEstimatedNumStages()
		local stage_or_stages = estimated_stage_count == 1 and "Stage" or "Stages"
		info.course_length_info = estimated_stage_count .. " " .. stage_or_stages .. " / " .. trail_time
	else
		local song = GAMESTATE:GetCurrentSong()
		info.song_title = song:GetDisplayFullTitle()
		info.song_artist = song:GetDisplayArtist()
		info.song_length_info = SecondsToMSSMsMs(song:MusicLengthSeconds())
	end

	return info
end




-- **********************





local schedule_delays = function(actor_elements)
	local main_initial_delay = 0.3
	local main_staying_delay = 10.5
	local main_delay_increment = 0.1
	local main_transition_delay = 0.1

	local initial_delay = main_initial_delay
	for i, v in ipairs(actor_elements) do
		v.transition_delay = main_transition_delay
		v.initial_delay = initial_delay
		initial_delay = initial_delay + main_delay_increment
	end

	local staying_delay = main_staying_delay
	for i = #actor_elements, 1, -1 do
		actor_elements[i].staying_delay = staying_delay
		staying_delay = staying_delay + (2 * main_delay_increment)
	end

	return actor_elements
end

local get_backdrop_actor_element = function()
	local x1 = 0
	local x0 = x1 - SCREEN_WIDTH
	local y = 0
	local actor_element = {
		actor = Def.ActorFrame {
			Def.Quad {
				InitCommand = cmd(
					zoomto, SCREEN_WIDTH, SCREEN_HEIGHT * 0.8;
					diffuse, color("#000000"); -- FIXME
					diffusealpha, 0.5);
			}
		},
		x0 = x0,
		y0 = y,
		x1 = x1,
		y1 = y,
		zoom = 1
	}
	return actor_element
end

local get_stage_stat_actor_elements = function(stage_stat_lines)
	local actor_elements = imap(stage_stat_lines, function(i, text)
		local info_actor_y_offset = 0
		local info_actor_y_offset_increment = SQ * 0.05

		local y = info_actor_y_offset + ((i - 1) * info_actor_y_offset_increment)
		return {
			actor = Def.ActorFrame {
				LoadFont("Common Normal") .. {
					Text = text;
					InitCommand = cmd(horizalign, right; vertalign, top; diffuse, statsColor);
				}
			},
			x0 = -SCREEN_WIDTH,
			x1 = 0,
			y0 = y,
			y1 = y,
			zoom = (i == 3) and 0.75 or 1,
			z_index = 10,
		}
	end)
	return actor_elements
end

local get_stage_stat_lines = function(stage_info)
	local title_line_text = stage_info.course_title
	if title_line_text == nil then title_line_text = stage_info.song_title end

	local course_type_or_song_artist_text = stage_info.course_type
	if course_type_or_song_artist_text == nil then course_type_or_song_artist_text = stage_info.song_artist end

	local length_info_text = stage_info.course_length_info
	if length_info_text == nil then length_info_text = stage_info.song_length_info end

	return {
		title_line_text,
		course_type_or_song_artist_text,
		length_info_text,
	}
end

local determine_actors = function ()

	local stage_info = get_current_stage_info()

	-- FIXME: Spikes for testing
	stage_info.is_numbered_stage = false -- FIXME: Remove this
	stage_info.short_name = "Event" -- FIXME: Remove this
	stage_info.number = 5 -- FIXME: Remove this

	local backdrop_actor_element = get_backdrop_actor_element()
	local stage_stat_actor_elements = get_stage_stat_actor_elements(get_stage_stat_lines(stage_info))

	if stage_info.is_numbered_stage then
		if stage_info.number >= 10 then
			-- TODO: Figure out making multiple digits work
			return nil
		else
			local zoom_for_rendered_actors = 0.5

			local hidari_at_left_x = -48
			local migi_at_right_x = 100
			local padding = -60

			if stage_info.number == 1 then
				migi_at_right_x = 130
				padding = -10
			end

			local migi_x1 = migi_at_right_x - padding
			local migi_x0 = migi_x1 - SCREEN_WIDTH
			local migi_y = 0

			local hidari_x1 = hidari_at_left_x + padding
			local hidari_x0 = hidari_x1 + SCREEN_WIDTH
			local hidari_y = 15

			local stats_x = 17
			local stats_y = 105


			if stage_info.number == 1 then
				stats_x = 25 -- 25, 105
			elseif stage_info.number == 4 then
				stats_x = 195 -- 195, 105
			elseif stage_info.number == 6 then
				stats_y = 85 -- 17, 85
			elseif stage_info.number == 7 then
				stats_y = 120 -- 17, 120
			elseif stage_info.number == 8 then
				stats_y = 85 -- 17, 85
			end

			for i, v in ipairs(stage_stat_actor_elements) do
				v.x0 = v.x0 + stats_x
				v.x1 = v.x1 + stats_x
				v.y0 = v.y0 + stats_y
				v.y1 = v.y1 + stats_y
			end

			local actor_elements = {
				backdrop_actor_element,
				{
					actor = LoadActor("numeral " .. stage_info.number),
					x0 = migi_x0,
					y0 = migi_y,
					x1 = migi_x1,
					y1 = migi_y,
					zoom = zoom_for_rendered_actors,
				},
				{
					actor = LoadActor("word stage"),
					x0 = hidari_x0,
					y0 = hidari_y,
					x1 = hidari_x1,
					y1 = hidari_y,
					zoom = zoom_for_rendered_actors,
				},
				unpack(stage_stat_actor_elements),
			}

			return actor_elements
		end
	elseif stage_info.short_name == "Event" then

		-- event mode
		-- zoom = 0.3
		-- migi is word mode 187.5, 62
		-- hidari is word event 0, -10
		-- stats at 287, 100
		
		-- final stage
		-- zoom = 0.4
		-- migi is word stage 110, 72
		-- hidari is word final 0, -20
		-- stats at 120, 114

		-- extra stage (Extra1)
		-- zoom = 0.3
		-- migi is word stage 155, 72
		-- hidari is word extra 0, -20
		-- stats at 162, 104
		-- (Extra2) add word another at -153, -80

		-- endless mode
		-- zoom = 0.23
		-- migi is word mode 217, 52
		-- hidari is word endless 0, -10
		-- stats at 133, 58

		-- nonstop mode
		-- zoom = 0.21
		-- migi is word mode 215, 40
		-- hidari is word nonstop 0, -10
		-- stats at 135, 42

		-- oni mode
		-- zoom 0.5
		-- migi is word mode 72, 50
		-- hidari is word oni 0, -40
		-- stats 238, 108

		-- demo mode
		-- zoom 0.35
		-- migi is word mode 177 70
		-- hidari is word demo 0 -20
		-- stats 52 80

		local zoom_for_rendered_actors = 0.35

		
		local migi_x1 = 177
		local migi_x0 = migi_x1 - SCREEN_WIDTH
		local migi_y = 70

		local hidari_x1 = 0
		local hidari_x0 = hidari_x1 + SCREEN_WIDTH
		local hidari_y = -20

		local stats_x
		local stats_y

		stats_x = 52
		stats_y = 80


		for i, v in ipairs(stage_stat_actor_elements) do
			v.x0 = v.x0 + stats_x
			v.x1 = v.x1 + stats_x
			v.y0 = v.y0 + stats_y
			v.y1 = v.y1 + stats_y
		end

		local actor_elements = {
			backdrop_actor_element,
			{
				actor = LoadActor("word mode"),
				x0 = migi_x0,
				y0 = migi_y,
				x1 = migi_x1,
				y1 = migi_y,
				zoom = zoom_for_rendered_actors,
				z_index = 1,
			},
			{
				actor = LoadActor("word demo"),
				x0 = hidari_x0,
				y0 = hidari_y,
				x1 = hidari_x1,
				y1 = hidari_y,
				zoom = zoom_for_rendered_actors,
			},
			unpack(stage_stat_actor_elements),
		}

		return actor_elements
	else
		-- TODO: Implement non-numeral modes
		return {}
	end

end






local t = Def.ActorFrame {} -- { InitCommand=cmd(x,SCREEN_CENTER_X; y, SCREEN_CENTER_Y); }
local tx = Def.ActorFrame {} -- { InitCommand=cmd(x,SCREEN_CENTER_X; y, SCREEN_CENTER_Y); }
t[#t+1] = tx

local scheduled_actor_elements = schedule_delays(determine_actors())

for i, v in ipairs(sorted_by_z_index(scheduled_actor_elements)) do
	tx[#tx+1] = v.actor .. {
		InitCommand=cmd(
			zoom, v.zoom;
			diffusealpha, 0;
			sleep, v.initial_delay;
			x, v.x0;
			y, v.y0;
			diffusealpha, 1;
			linear, v.transition_delay;
			x, v.x1;
			y, v.y1;
			sleep, v.staying_delay;
			linear, v.transition_delay;
			x, v.x0;
			y, v.y0;
			diffusealpha, 0);
	};
end


return t;
