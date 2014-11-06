
local t = Def.ActorFrame {
	Def.ActorFrame {
		InitCommand=cmd(Center);
		OnCommand=cmd(sleep,1);
		LoadActor("credits-screen") .. {
			InitCommand=cmd(zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT);
		};
	};
};

return t;
