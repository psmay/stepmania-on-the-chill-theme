local curGameName = GAMESTATE:GetCurrentGame():GetName();

local t = LoadFont("Game metadata") .. {
	BeginCommand=function(self)
		self:settextf( Screen.String("CurrentGametype"), curGameName );
	end;
};
return t;