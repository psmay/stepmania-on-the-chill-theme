return Def.ActorFrame {	
	LoadActor(THEME:GetPathG("_MusicWheelItem","SectionCollapsed NormalPart")) .. {
		InitCommand=cmd(diffusealpha,0.5);
	};
	-- Add a frame
	LoadActor(THEME:GetPathG("MusicWheelItem","Course ColorPart")) .. {
		InitCommand=cmd(diffusealpha,0.5);
	};
};
