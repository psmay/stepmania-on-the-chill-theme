
-- Possibilities from GameState.cpp
-- Stage_Demo - Demo or Jukebox mode
-- Stage_Event - Event mode
-- Stage_Oni - Oni mode
-- Stage_Nonstop - Nonstop mode
-- Stage_Endless - Endless mode
-- Stage_Extra1 - First extra stage
-- Stage_Extra2 - Second extra stage
-- Stage_Final - Last non-extra stage
-- Stage_1st - Stage 1
-- Stage_2nd - Stage 2
-- Stage_3rd - Stage 3
-- Stage_4th - Stage 4
-- Stage_5th - Stage 5
-- Stage_6th - Stage 6
-- Stage_Next - Stage 7 or later

function is_numbered_stage(stageName)
	local numbered_stages= {
		Stage_1st = true,
		Stage_2nd = true,
		Stage_3rd = true,
		Stage_4th = true,
		Stage_5th = true,
		Stage_6th = true,
		Stage_Next = true,
	}
	return numbered_stages[stageName] ~= nil
end


local playMode = GAMESTATE:GetPlayMode()

local currentStage = GAMESTATE:GetCurrentStage()
local stageOrMode = currentStage

local stageNumber = GAMESTATE:GetCurrentStageIndex() + 1


if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
  stageOrMode = playMode;
end;

local name = ToEnumShortString(stageOrMode)

local t = Def.ActorFrame {};
t[#t+1] = Def.Quad {
	InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,Color("Black"));
};
if GAMESTATE:IsCourseMode() then
	t[#t+1] = LoadActor("CourseDisplay");
else
	t[#t+1] = Def.Sprite {
		InitCommand=cmd(Center;diffusealpha,0);
		BeginCommand=cmd(LoadFromCurrentSongBackground);
		OnCommand=function(self)
			self:scale_or_crop_background()
			self:sleep(0.5)
			self:linear(0.50)
			self:diffusealpha(1)
			self:sleep(3)
		end;
	};
end
local stage_num_actor = nil

stage_num_actor = LoadActor("intro")

if stage_num_actor == nil then
	stage_num_actor= Def.BitmapText{
		Font= "Common Normal",  Text= thified_curstage_index(false) .. " Stage",
		InitCommand= function(self)
			self:zoom(1.5)
			self:strokecolor(Color.Black)
			self:diffuse(StageToColor(currentStage));
			self:diffusetopedge(ColorLightTone(StageToColor(currentStage)));
		end
	}
end



t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(
		x,SCREEN_CENTER_X;
		y,SCREEN_CENTER_Y;
		);
	stage_num_actor .. {
		--InitCommand=cmd(x,SCREEN_CENTER_X; y,SCREEN_CENTER_Y);
	};
};



return t
