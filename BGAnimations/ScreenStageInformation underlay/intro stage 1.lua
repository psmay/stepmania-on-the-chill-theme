
-- Such as "Stage_1st" or "Stage_Event"
local get_current_stage = function()
	return GAMESTATE:GetCurrentStage()
end

-- Such as "PlayMode_Rave" or "PlayMode_Oni"
local get_current_play_mode = function()
	return GAMESTATE:GetPlayMode()
end

-- Such as "Stage_1st" in some modes or "PlayMode_Oni" in other modes
local get_current_stage_or_play_mode = function()
	local playMode = get_current_play_mode()

	if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
		return playMode;
	else
		return get_current_stage()
	end
end

-- Such as "1st" or "Oni"
local get_current_short_name = function()
	return ToEnumShortString(get_current_stage_or_play_mode())
end

-- 1 for 1st stage, 2 for 2nd stage, etc.
local get_current_stage_number = function()
	return GAMESTATE:GetCurrentStageIndex() + 1
end



local get_current_round_info = function()
	local info = {}

	if GAMESTATE:IsCourseMode() then
		local course = GAMESTATE:GetCurrentCourse()
		info.course_title = course:GetDisplayFullTitle()
		info.course_type = ToEnumShortString(course:GetCourseType()) 

		local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
		local trail_time = SecondsToMSSMsMs(TrailUtil.GetTotalSeconds(trail))
		local estimated_stage_count = course:GetEstimatedNumStages()
		local stage_or_stages = "Stages"
		if estimated_stage_count == 1 then
			stage_or_stages = "Stage"
		end
		info.length_info = estimated_stage_count .. " " .. stage_or_stages .. " / " .. trail_time
	else
		local song = GAMESTATE:GetCurrentSong()
		info.song_title = song:GetDisplayFullTitle()
		info.song_artist = song:GetDisplayArtist()
		info.length_info = SecondsToMSSMsMs(song:MusicLengthSeconds())
	end

	return info
end





local mode_uses_stage_number = function(short_name)
	local uses_stage_number = {
		["1st"] = true,
		["2nd"] = true,
		["3rd"] = true,
		["4th"] = true,
		["5th"] = true,
		["6th"] = true,
		Next = true,
	}
	return uses_stage_number[short_name]
end

-- **********************

local numeral = 1

local z = 0.5

local cx = SCREEN_WIDTH * 0.5
local cy = SCREEN_HEIGHT * -0.5

local main_initial_delay = 0.3
local main_staying_delay = 1.5
local main_delay_increment = 0.1
local main_transition_delay = 0.1

local schedule_delays = function(actor_parameters)

	local initial_delay = main_initial_delay
	for i, v in ipairs(actor_parameters) do
		v.transition_delay = main_transition_delay
		v.initial_delay = initial_delay
		initial_delay = initial_delay + main_delay_increment
	end

	local staying_delay = main_staying_delay
	for i = #actor_parameters, 1, -1 do
		actor_parameters[i].staying_delay = staying_delay
		staying_delay = staying_delay + (2 * main_delay_increment)
	end

	return actor_parameters
end

local determine_actors = function ()
	local zoom_for_rendered_actors = 0.5

	local short_name = "1st" -- get_current_short_name()
	local stage_number = 1 -- get_current_short_name()
	local round_info = get_current_round_info()

	local backdrop_x1 = SCREEN_WIDTH * -0.5
	local backdrop_x0 = backdrop_x1 - SCREEN_WIDTH
	local backdrop_y = cy
	local backdrop_actor_parameters = {
		actor = Def.ActorFrame {
			Def.Quad {
				InitCommand = cmd(zoomto, SCREEN_WIDTH, SCREEN_HEIGHT * 0.8; diffuse, color("#000000"); diffusealpha, 0.5);
			}
		},
		x0 = backdrop_x0,
		y0 = backdrop_y,
		x1 = backdrop_x1,
		y1 = backdrop_y,
		zoom = 1
	}

	local title_line_text = round_info.course_title
	if title_line_text == nil then title_line_text = round_info.song_title end

	local course_type_or_song_artist_text = round_info.course_type
	if course_type_or_song_artist_text == nil then course_type_or_song_artist_text = round_info.song_artist end

	local length_info_text = round_info.length_info


	local title_line_text_actor = Def.ActorFrame {
		LoadFont("Common Normal") .. {
			Text = title_line_text;
			InitCommand = cmd(horizalign, right; vertalign, top; diffuse, statsColor);
		}
	}

	local course_type_or_song_artist_actor = Def.ActorFrame {
		LoadFont("Common Normal") .. {
			Text = course_type_or_song_artist_text;
			InitCommand = cmd(horizalign, right; vertalign, top; diffuse, statsColor);
		}
	}

	local length_info_actor = Def.ActorFrame {
		LoadFont("Common Normal") .. {
			Text = length_info_text;
			InitCommand = cmd(horizalign, right; vertalign, top; diffuse, statsColor);
		}
	}



	local info_actor_parameters = {
		{ actor = title_line_text_actor },
		{ actor = course_type_or_song_artist_actor },
		{ actor = length_info_actor },
	}

	local info_actor_y_offset = 0
	local info_actor_y_offset_increment = SCREEN_HEIGHT * 0.05

	for i, v in ipairs(info_actor_parameters) do
		v.x0 = -SCREEN_WIDTH
		v.x1 = 0
		v.y0 = info_actor_y_offset
		v.y1 = info_actor_y_offset
		v.zoom = 1

		info_actor_y_offset = info_actor_y_offset + info_actor_y_offset_increment
	end

	info_actor_parameters[3].zoom = 0.75

	--local title_actor = LoadFont("Common Normal") .. {
	--	Text = round_info.course_title ~= nil and round_info.course_title or round_info.
	--}

	if mode_uses_stage_number(short_name) then
		if stage_number >= 10 then
			-- TODO: Figure out making multiple digits work
			return nil
		else

			local padding = 0.1 -- Value for most numerals
			if stage_number == 1 then
				padding = 0.11 -- Value for 1
			end
			local numeral_x1 = SCREEN_WIDTH * (-0.2188 - padding)
			local numeral_x0 = numeral_x1 - SCREEN_WIDTH
			local numeral_y = cy
			local word_x1 = SCREEN_WIDTH * (-0.6996 + padding)
			local word_x0 = word_x1 + SCREEN_WIDTH
			local word_y = cy

			local qq_x1 = SCREEN_WIDTH * -.515
			local qq_x0 = qq_x1 - SCREEN_WIDTH
			local qq_y = cy + (SCREEN_HEIGHT * 0.20)

			local actor_parameters = {
				backdrop_actor_parameters,
				{
					actor = LoadActor("numeral " .. stage_number),
					x0 = numeral_x0,
					y0 = numeral_y,
					x1 = numeral_x1,
					y1 = numeral_y,
					zoom = zoom_for_rendered_actors,
				},
				{
					actor = LoadActor("word stage"),
					x0 = word_x0,
					y0 = word_y,
					x1 = word_x1,
					y1 = word_y,
					zoom = zoom_for_rendered_actors,
				},
			}

			local dx = SCREEN_WIDTH * -0.51
			local dy = SCREEN_HEIGHT * -0.28

			for i, v in ipairs(info_actor_parameters) do
				v.x0 = v.x0 + dx
				v.x1 = v.x1 + dx
				v.y0 = v.y0 + dy
				v.y1 = v.y1 + dy
				actor_parameters[#actor_parameters + 1] = v
			end

			return actor_parameters
		end
	else
		-- TODO: Implement non-numeral modes
		return {}
	end

end






local t = Def.ActorFrame {}
local tx = Def.ActorFrame { InitCommand=cmd(Center); }
t[#t+1] = tx

local scheduled_actor_parameters = schedule_delays(determine_actors())

for i, v in ipairs(scheduled_actor_parameters) do
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

