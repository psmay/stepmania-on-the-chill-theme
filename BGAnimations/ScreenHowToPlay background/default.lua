
local base_cloud_speed = 0.010;

return Def.ActorFrame {
	InitCommand=cmd(hide_if,hideFancyElements;);
	Def.Quad {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT);
		OnCommand=cmd(diffuse,color("#000044"));
	};
	-- These actors implement a parallax cloud effect
	LoadActor("backdrop-clouds") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH);
		OnCommand=cmd(texcoordvelocity,0.0,base_cloud_speed*1);
	};
	LoadActor("sparse-clouds-1") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH);
		OnCommand=cmd(texcoordvelocity,0.0,base_cloud_speed*2);
	};
	LoadActor("sparse-clouds-2") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH);
		OnCommand=cmd(texcoordvelocity,0.0,base_cloud_speed*3);
	};
	LoadActor("sparse-clouds-3") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH);
		OnCommand=cmd(texcoordvelocity,0.0,base_cloud_speed*4);
	};
};
