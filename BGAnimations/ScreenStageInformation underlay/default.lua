


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

if stageOrMode == "Stage_Event" then
	stage_num_actor = LoadActor("intro event mode")
elseif stageOrMode == "Stage_1st" then
	stage_num_actor = LoadActor("intro stage 1")
end

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
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	--OnCommand=cmd(stoptweening;zoom,1.25;decelerate,3;zoom,1);
	stage_num_actor .. {
		--OnCommand=cmd(diffusealpha,0;linear,0.25;diffusealpha,1;sleep,1.75;linear,0.5;zoomy,0;zoomx,2;diffusealpha,0);
	};
};

local statsColor = Color("Outline")

t[#t+1] = Def.ActorFrame {
  --InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+96);
  InitCommand=cmd(vertalign,bottom;x,SCREEN_RIGHT-32;y,SCREEN_BOTTOM-32);
  OnCommand=cmd(diffusealpha,0;linear,0.5;diffusealpha,1;sleep,1.5;linear,0.5;diffusealpha,0);
	LoadFont("Common Normal") .. {
		Text=GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetDisplayFullTitle();
		InitCommand=cmd(horizalign,right;strokecolor,statsColor;y,-20);
	};
	LoadFont("Common Normal") .. {
		Text=GAMESTATE:IsCourseMode() and ToEnumShortString( GAMESTATE:GetCurrentCourse():GetCourseType() ) or GAMESTATE:GetCurrentSong():GetDisplayArtist();
		InitCommand=cmd(horizalign,right;strokecolor,statsColor;zoom,0.75);
	};
	LoadFont("Common Normal") .. {
		InitCommand=cmd(horizalign,right;strokecolor,statsColor;diffuse,ColorSchemeColors.VeryShallow;diffusebottomedge,ColorSchemeColors.VeryDeep;zoom,0.75;y,20);
		BeginCommand=function(self)
			local text = "";
			local SongOrCourse;
			if GAMESTATE:IsCourseMode() then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber());
				SongOrCourse = GAMESTATE:GetCurrentCourse();
				local estimatedNumStages = SongOrCourse:GetEstimatedNumStages();
				local trailTime = SecondsToMSSMsMs( TrailUtil.GetTotalSeconds(trail) );
				local stageOrStages = "Stages";
				if estimatedNumStages == 1 then
					stageOrStages = "Stage";
				end
				text = estimatedNumStages .. " " .. stageOrStages .. " / " .. trailTime;
			else
				SongOrCourse = GAMESTATE:GetCurrentSong();
				text = SecondsToMSSMsMs( SongOrCourse:MusicLengthSeconds() );
			end;
			self:settext(text);
		end;
	};
};


return t
