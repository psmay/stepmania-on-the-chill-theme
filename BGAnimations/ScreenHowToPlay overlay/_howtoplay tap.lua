return Def.ActorFrame {
	LoadActor(THEME:GetPathB("_frame","3x3"),"rounded black",380,80);
	Def.Quad {
		Name="Underline";
		InitCommand=cmd(y,-12);
		OnCommand=cmd(diffuse,ColorSchemeColors.Deep;shadowlength,1;zoomtowidth,192;fadeleft,0.25;faderight,0.25);
	};
	LoadFont("Common Bold") .. {
		Text=ScreenString("Information");
		InitCommand=cmd(y,-26);
		OnCommand=cmd(skewx,-0.125;diffuse,ColorSchemeColors.Deep;shadowlength,2;shadowcolor,BoostColor(ColorSchemeColors.DeepSemiAlpha,0.25))
	};
	LoadFont("Common Normal") .. {
		Text=ScreenString("Tap");
		InitCommand=cmd(y,18;wrapwidthpixels,480;vertspacing,-12;shadowlength,1);
		OnCommand=cmd(zoom,0.875);
	};
};
