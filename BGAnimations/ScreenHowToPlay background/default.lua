return Def.ActorFrame {
	InitCommand=cmd(hide_if,hideFancyElements;);
	Def.Quad {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH,SCREEN_HEIGHT);
		OnCommand=cmd(diffuse,color("#000000"));
	};	
	-- These actors implement a parallax cloud effect
	LoadActor("vertical-clouds-1") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH);
		OnCommand=cmd(texcoordvelocity,0.0,0.10;diffusecolor,color("#0000ff");diffusealpha,0.5);
	};
	LoadActor("vertical-clouds-2") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH);
		OnCommand=cmd(texcoordvelocity,0.0,0.02;diffusecolor,color("#4444ff");diffusealpha,0.4);
	};
	LoadActor("vertical-clouds-3") .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH);
		OnCommand=cmd(texcoordvelocity,0.0,0.03;diffusecolor,color("#8888ff");diffusealpha,0.3);
	};
};
