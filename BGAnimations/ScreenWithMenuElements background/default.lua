local t = Def.ActorFrame {};

local halftone_arrow_size = SCREEN_HEIGHT * 1.2;
local base_cloud_speed = 0.010;

t[#t+1] = Def.ActorFrame {
  FOV=90;
  InitCommand=cmd(Center);
	Def.Quad {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT);
		OnCommand=cmd(diffuse,color("#000000"));
	};
	Def.ActorFrame {
		InitCommand=cmd(hide_if,hideFancyElements;);

		-- These actors implement a parallax cloud effect
		LoadActor("backdrop-clouds") .. {
			InitCommand=cmd(x,SCREEN_CENTER_X;y,0;zoomtoheight,SCREEN_HEIGHT);
			OnCommand=cmd(texcoordvelocity,base_cloud_speed*1,0.0,diffuse,color("#0000ff"));
		};
		LoadActor("sparse-clouds-1") .. {
			InitCommand=cmd(x,SCREEN_CENTER_X;y,0;zoomtoheight,SCREEN_HEIGHT);
			OnCommand=cmd(texcoordvelocity,base_cloud_speed*2,0.0,diffuse,color("#0000ff"));
		};
		LoadActor("sparse-clouds-2") .. {
			InitCommand=cmd(x,SCREEN_CENTER_X;y,0;zoomtoheight,SCREEN_HEIGHT);
			OnCommand=cmd(texcoordvelocity,base_cloud_speed*3,0.0);
		};
		LoadActor("sparse-clouds-3") .. {
			InitCommand=cmd(x,SCREEN_CENTER_X;y,0;zoomtoheight,SCREEN_HEIGHT);
			OnCommand=cmd(texcoordvelocity,base_cloud_speed*4,0.0);
		};
	};
	Def.ActorFrame {
		LoadActor("halftone-arrow") .. {
			InitCommand=cmd(zoomto,halftone_arrow_size,halftone_arrow_size);
			OnCommand=cmd(diffusealpha,0.0;smooth,0.5;diffusealpha,0.1);
		};
	};
	LoadActor("_particleLoader") .. {
		InitCommand=cmd(x,-SCREEN_CENTER_X;y,-SCREEN_CENTER_Y;hide_if,hideFancyElements;);
	};
};

return t;
