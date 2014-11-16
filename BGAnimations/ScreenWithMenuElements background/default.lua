
local halftone_arrow_size = SCREEN_HEIGHT * 1.2;
local base_cloud_speed = 0.010;

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
  FOV=90;
  InitCommand=cmd(Center);
	Def.Quad {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT);
		OnCommand=cmd(diffuse,color("#000044"));
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
--[[ 	LoadActor("_particles") .. {
		InitCommand=cmd(x,-SCREEN_CENTER_X;y,-SCREEN_CENTER_Y);
	}; --]]
--[[ 	LoadActor("_pattern") .. {
		InitCommand=cmd(z,32;x,4;y,4;;rotationy,-12.25;rotationz,-30;rotationx,-20;zoomto,SCREEN_WIDTH*2,SCREEN_HEIGHT*2;customtexturerect,0,0,SCREEN_WIDTH*4/256,SCREEN_HEIGHT*4/256);
		OnCommand=cmd(texcoordvelocity,0.125,0.5;diffuse,Color("Black");diffusealpha,0.5);
	}; --]]
	--[[ LoadActor("_grid") .. {
		InitCommand=cmd(customtexturerect,0,0,(SCREEN_WIDTH+1)/4,SCREEN_HEIGHT/4;SetTextureFiltering,true);
		OnCommand=cmd(zoomto,SCREEN_WIDTH+1,SCREEN_HEIGHT;diffuse,Color("Black");diffuseshift;effecttiming,(1/8)*2,0,(7/8)*2,0;effectclock,'beatnooffset';
		effectcolor2,Color("White");effectcolor1,Color("Black");fadebottom,0.25;fadetop,0.25;croptop,48/480;cropbottom,48/480;blend,Blend.Add;
		diffusealpha,0.155);
	}; --]]		
};

return t;
