
local function sorted_by_z_index(source)
	local function key_selector(v)
		return v.z_index
	end
	return Utility.sorted_by_key(source, key_selector, true)
end

-- *********************

local SQ = 480

local function get_current_stage_info()
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





local function schedule_delays(actor_elements)
	local main_initial_delay = 0.3
	local main_staying_delay = 1.5
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

local function get_backdrop_actor_element()
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

local function get_stage_stat_actor_elements(stage_stat_lines, x, y)
	local actor_elements = Utility.imap(stage_stat_lines, function(i, text)
		local info_actor_y_offset = y
		local info_actor_y_offset_increment = 24

		local info_actor_y = info_actor_y_offset + ((i - 1) * info_actor_y_offset_increment)
		return {
			actor = Def.ActorFrame {
				LoadFont("Common Normal") .. {
					Text = text;
					InitCommand = cmd(horizalign, right; vertalign, top);
				}
			},
			x0 = x + -SCREEN_WIDTH,
			x1 = x,
			y0 = info_actor_y,
			y1 = info_actor_y,
			zoom = (i == 3) and 0.75 or 1,
			z_index = 10,
		}
	end)
	return actor_elements
end

local function get_stage_stat_lines(stage_info)
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

local SCALE_STAGE = 0.4
local SCALE_ANOTHER = 0.3
local SCALE_MODE = 0.4

local COLOR_NORMAL = ColorSchemeColors.FullyOn
local COLOR_HIGHLIGHT = ColorSchemeColors.Indicator
local COLOR_EXTRA = ColorSchemeColors.Extra

local function determine_actors()
	local stage_info = get_current_stage_info()

	local backdrop_actor_element = get_backdrop_actor_element()

	local key = stage_info.is_numbered_stage and stage_info.number or stage_info.short_name

	local actor_elements_metrics_table = {
		[1] = {
			stats_info = { x = 25, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = "numeral 1", x = 140, y = 0, zoom = 0.5 },
				{ from_left = true, actor_name = "word stage", x = -58, y = 15, zoom = 0.5 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[2] = {
			stats_info = { x = 17, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = "numeral 2", x = 160, y = 0, zoom = 0.5 },
				{ from_left = true, actor_name = "word stage", x = -108, y = 15, zoom = 0.5 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[3] = {
			stats_info = { x = 17, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = "numeral 3", x = 160, y = 0, zoom = 0.5 },
				{ from_left = true, actor_name = "word stage", x = -108, y = 15, zoom = 0.5 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[4] = {
			stats_info = { x = 195, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = "numeral 4", x = 160, y = 0, zoom = 0.5 },
				{ from_left = true, actor_name = "word stage", x = -108, y = 15, zoom = 0.5 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[5] = {
			stats_info = { x = 17, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = "numeral 5", x = 160, y = 0, zoom = 0.5 },
				{ from_left = true, actor_name = "word stage", x = -108, y = 15, zoom = 0.5 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[6] = {
			stats_info = { x = 17, y = 85 },
			elements_info = {
				{ from_left = false, actor_name = "numeral 6", x = 160, y = 0, zoom = 0.5 },
				{ from_left = true, actor_name = "word stage", x = -108, y = 15, zoom = 0.5 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[7] = {
			stats_info = { x = 17, y = 120 },
			elements_info = {
				{ from_left = false, actor_name = "numeral 7", x = 160, y = 0, zoom = 0.5 },
				{ from_left = true, actor_name = "word stage", x = -108, y = 15, zoom = 0.5 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[8] = {
			stats_info = { x = 17, y = 85 },
			elements_info = {
				{ from_left = false, actor_name = "numeral 8", x = 160, y = 0, zoom = 0.5 },
				{ from_left = true, actor_name = "word stage", x = -108, y = 15, zoom = 0.5 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[9] = {
			stats_info = { x = 17, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = "numeral 9", x = 160, y = 0, zoom = 0.5 },
				{ from_left = true, actor_name = "word stage", x = -108, y = 15, zoom = 0.5 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		Event = {
			stats_info = { x = 287, y = 100 },
			elements_info = {
				{ from_left = true, actor_name = "word event", x = 0, y = -10, zoom = 0.3 },
				{ from_left = false, actor_name = "word mode", x = 187.5, y = 62, zoom = 0.3 * SCALE_MODE, color = COLOR_HIGHLIGHT },
			},
		},
		Final = {
			stats_info = { x = 120, y = 114 },
			elements_info = {
				{ from_left = true, actor_name = "word final", x = 0, y = -20, zoom = 0.4 },
				{ from_left = false, actor_name = "word stage", x = 110, y = 72, zoom = 0.4 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		Extra1 = {
			stats_info = { x = 162, y = 104 },
			elements_info = {
				{ from_left = true, actor_name = "word extra", x = 0, y = -20, zoom = 0.3, color = COLOR_EXTRA },
				{ from_left = false, actor_name = "word stage", x = 155, y = 72, zoom = 0.3 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		Extra2 = {
			stats_info = { x = 162, y = 104 },
			elements_info = {
				{ from_left = true, actor_name = "word extra", x = 0, y = -20, zoom = 0.3, color = COLOR_EXTRA },
				{ from_left = false, actor_name = "word stage", x = 155, y = 72, zoom = 0.3 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
				{ from_left = true, actor_name = "word another", x = -153, y = -80, zoom = 0.3 * SCALE_ANOTHER },
			},
		},
		Endless = {
			stats_info = { x = 133, y = 58 },
			elements_info = {
				{ from_left = true, actor_name = "word endless", x = 0, y = -10, zoom = 0.23 },
				{ from_left = false, actor_name = "word mode", x = 217, y = 52, zoom = 0.23 * SCALE_MODE, color = COLOR_HIGHLIGHT },
			},
		},
		Nonstop = {
			stats_info = { x = 135, y = 42 },
			elements_info = {
				{ from_left = true, actor_name = "word nonstop", x = 0, y = -10, zoom = 0.21 },
				{ from_left = false, actor_name = "word mode", x = 215, y = 40, zoom = 0.21 * SCALE_MODE, color = COLOR_HIGHLIGHT },
			},
		},
		Oni = {
			stats_info = { x = 238, y = 108 },
			elements_info = {
				{ from_left = true, actor_name = "word oni", x = 0, y = -40, zoom = 0.5 },
				{ from_left = false, actor_name = "word mode", x = 72, y = 50, zoom = 0.5 * SCALE_MODE, color = COLOR_HIGHLIGHT },
			},
		},
		Demo = {
			stats_info = { x = 52, y = 80 },
			elements_info = {
				{ from_left = true, actor_name = "word demo", x = 0, y = -20, zoom = 0.35 },
				{ from_left = false, actor_name = "word mode", x = 177, y = 70, zoom = 0.35 * SCALE_MODE, color = COLOR_HIGHLIGHT },
			},
		},
		_default = {
			stats_info = { x = (SCREEN_WIDTH * 0.5) - 24, y = (SCREEN_HEIGHT * -0.5) + 24 },
			elements_info = {},
		},
	}

	local metrics_to_use = actor_elements_metrics_table[key]
	if metrics_to_use == nil then
		metrics_to_use = actor_elements_metrics_table._default
	end

	local custom_actor_elements = Utility.map(metrics_to_use.elements_info, function(ei)
		local x = ei.x
		local y = ei.y

		return {
			actor = LoadActor(ei.actor_name),
			x0 = ei.from_left and (x - SCREEN_WIDTH) or (x + SCREEN_WIDTH),
			y0 = y,
			x1 = x,
			y1 = y,
			zoom = ei.zoom,
			z_index = ei.z_index,
			color = ei.color,
		}
	end)

	local stage_stat_actor_elements = get_stage_stat_actor_elements(get_stage_stat_lines(stage_info),
		metrics_to_use.stats_info.x, metrics_to_use.stats_info.y)

	local actor_elements = { backdrop_actor_element }
	Utility.push_all(actor_elements, custom_actor_elements)
	Utility.push_all(actor_elements, stage_stat_actor_elements)

	return actor_elements

end






local t = Def.ActorFrame {}
local tx = Def.ActorFrame {}
t[#t+1] = tx

local scheduled_actor_elements = schedule_delays(determine_actors())

for i, v in ipairs(sorted_by_z_index(scheduled_actor_elements)) do
	local color = v.color ~= nil and v.color or COLOR_NORMAL
	local zoom = v.zoom ~= nil and v.zoom or 1

	tx[#tx+1] = v.actor .. {
		InitCommand=cmd(
			diffuse, color;
			zoom, zoom;
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
