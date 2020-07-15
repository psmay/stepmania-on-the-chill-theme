
local function sorted_by_z_index(source)
	local function key_selector(v)
		return v.z_index
	end
	return Smotc.sorted_by_key(source, key_selector, true)
end

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
					diffuse, ColorSchemeColors.FullyOff;
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
	local actor_elements = Smotc.imap(stage_stat_lines, function(i, text)
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
	local title_line_text = stage_info.title
	local course_type_or_artist_text = stage_info.is_course and stage_info.course_type or stage_info.artist
	local length_info_text = stage_info.length_info

	return {
		title_line_text,
		course_type_or_artist_text,
		length_info_text,
	}
end

local SCALE_STAGE = 0.4
local SCALE_ANOTHER = 0.3
local SCALE_MODE = 0.4

local COLOR_NORMAL = ColorSchemeColors.FullyOn
local COLOR_HIGHLIGHT = ColorSchemeColors.Indicator
local COLOR_EXTRA = ColorSchemeColors.Extra


local function kind_display_text(kind, name)
	return THEME:GetPathG("_StepTech display", "text/" .. kind .. " " .. name)
end

local function half_display_text(name)
	return kind_display_text("halfoutline", name)
end

local function full_display_text(name)
	return kind_display_text("fulloutline", name)
end

local NUMERAL_0 = half_display_text("numeral 0")
local NUMERAL_1 = half_display_text("numeral 1")
local NUMERAL_2 = half_display_text("numeral 2")
local NUMERAL_3 = half_display_text("numeral 3")
local NUMERAL_4 = half_display_text("numeral 4")
local NUMERAL_5 = half_display_text("numeral 5")
local NUMERAL_6 = half_display_text("numeral 6")
local NUMERAL_7 = half_display_text("numeral 7")
local NUMERAL_8 = half_display_text("numeral 8")
local NUMERAL_9 = half_display_text("numeral 9")

local WORD_ANOTHER = full_display_text("word another")
local WORD_DEMO = full_display_text("word demo")
local WORD_ENDLESS = full_display_text("word endless")
local WORD_EVENT = full_display_text("word event")
local WORD_EXTRA = full_display_text("word extra")
local WORD_FINAL = full_display_text("word final")
local WORD_MODE = full_display_text("word mode")
local WORD_NONSTOP = full_display_text("word nonstop")
local WORD_ONI = full_display_text("word oni")
local WORD_STAGE = full_display_text("word stage")

local function determine_actors()
	local stage_info = Smotc.get_current_stage_info()

	local backdrop_actor_element = get_backdrop_actor_element()

	local key = stage_info.is_numbered_stage and stage_info.number or stage_info.short_name

	local actor_elements_metrics_table = {
		[1] = {
			stats_info = { x = 25, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = NUMERAL_1, x = 140, y = -45, zoom = 1.0 * 1.5 },
				{ from_left = true, actor_name = WORD_STAGE, x = -58, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[2] = {
			stats_info = { x = 17, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = NUMERAL_2, x = 160, y = -45, zoom = 1.5 },
				{ from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[3] = {
			stats_info = { x = 17, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = NUMERAL_3, x = 160, y = -45, zoom = 1.5 },
				{ from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[4] = {
			stats_info = { x = 195, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = NUMERAL_4, x = 160, y = -45, zoom = 1.5 },
				{ from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[5] = {
			stats_info = { x = 17, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = NUMERAL_5, x = 160, y = -45, zoom = 1.5 },
				{ from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[6] = {
			stats_info = { x = 17, y = 85 },
			elements_info = {
				{ from_left = false, actor_name = NUMERAL_6, x = 160, y = -45, zoom = 1.5 },
				{ from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[7] = {
			stats_info = { x = 17, y = 120 },
			elements_info = {
				{ from_left = false, actor_name = NUMERAL_7, x = 160, y = -45, zoom = 1.5 },
				{ from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[8] = {
			stats_info = { x = 17, y = 85 },
			elements_info = {
				{ from_left = false, actor_name = NUMERAL_8, x = 160, y = -45, zoom = 1.5 },
				{ from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		[9] = {
			stats_info = { x = 17, y = 105 },
			elements_info = {
				{ from_left = false, actor_name = NUMERAL_9, x = 160, y = -45, zoom = 1.5 },
				{ from_left = true, actor_name = WORD_STAGE, x = -108, y = -10, zoom = SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		Event = {
			stats_info = { x = 287, y = 100 },
			elements_info = {
				{ from_left = true, actor_name = WORD_EVENT, x = 0, y = -28, zoom = 0.6 },
				{ from_left = false, actor_name = WORD_MODE, x = 187.5, y = 55, zoom = 0.6 * SCALE_MODE, color = COLOR_HIGHLIGHT },
			},
		},
		Final = {
			stats_info = { x = 120, y = 114 },
			elements_info = {
				{ from_left = true, actor_name = WORD_FINAL, x = 0, y = -44, zoom = 0.8 },
				{ from_left = false, actor_name = WORD_STAGE, x = 111, y = 53, zoom = 0.8 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		Extra1 = {
			stats_info = { x = 162, y = 104 },
			elements_info = {
				{ from_left = true, actor_name = WORD_EXTRA, x = 0, y = -38, zoom = 0.6, color = COLOR_EXTRA },
				{ from_left = false, actor_name = WORD_STAGE, x = 155, y = 58, zoom = 0.6 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
			},
		},
		Extra2 = {
			stats_info = { x = 162, y = 104 },
			elements_info = {
				{ from_left = true, actor_name = WORD_EXTRA, x = 0, y = -38, zoom = 0.6, color = COLOR_EXTRA },
				{ from_left = false, actor_name = WORD_STAGE, x = 155, y = 58, zoom = 0.6 * SCALE_STAGE, color = COLOR_HIGHLIGHT },
				{ from_left = true, actor_name = WORD_ANOTHER, x = -153, y = -85, zoom = 0.6 * SCALE_ANOTHER },
			},
		},
		Endless = {
			stats_info = { x = 133, y = 58 },
			elements_info = {
				{ from_left = true, actor_name = WORD_ENDLESS, x = 0, y = -24, zoom = 0.46 },
				{ from_left = false, actor_name = WORD_MODE, x = 217, y = 46, zoom = 0.46 * SCALE_MODE, color = COLOR_HIGHLIGHT },
			},
		},
		Nonstop = {
			stats_info = { x = 135, y = 42 },
			elements_info = {
				{ from_left = true, actor_name = WORD_NONSTOP, x = 0, y = -35, zoom = 0.42 },
				{ from_left = false, actor_name = WORD_MODE, x = 215, y = 35, zoom = 0.42 * SCALE_MODE, color = COLOR_HIGHLIGHT },
			},
		},
		Oni = {
			stats_info = { x = 238, y = 108 },
			elements_info = {
				{ from_left = true, actor_name = WORD_ONI, x = 0, y = -90, zoom = 1.0 },
				{ from_left = false, actor_name = WORD_MODE, x = 72, y = 38, zoom = 1.0 * SCALE_MODE, color = COLOR_HIGHLIGHT },
			},
		},
		Demo = {
			stats_info = { x = 52, y = 80 },
			elements_info = {
				{ from_left = true, actor_name = WORD_DEMO, x = 0, y = -41, zoom = 0.7 },
				{ from_left = false, actor_name = WORD_MODE, x = 177, y = 61, zoom = 0.7 * SCALE_MODE, color = COLOR_HIGHLIGHT },
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

	local custom_actor_elements = Smotc.map(metrics_to_use.elements_info, function(ei)
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
	Smotc.push_all(actor_elements, custom_actor_elements)
	Smotc.push_all(actor_elements, stage_stat_actor_elements)

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
