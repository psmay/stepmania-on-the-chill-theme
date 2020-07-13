
local t = Def.ActorFrame{
	InitCommand=cmd(zoom, 0.3; diffuse, ColorSchemeColors.GameOver)
}

local WORD_GAME = THEME:GetPathG("_StepTech display", "text/fulloutline word game")
local WORD_OVER = THEME:GetPathG("_StepTech display", "text/fulloutline word over")

t[#t+1] = LoadActor(WORD_GAME) .. {
	InitCommand=cmd(horizalign,left; x,-810; y,0)
}
t[#t+1] = LoadActor(WORD_OVER) .. {
	InitCommand=cmd(horizalign,right; x,810; y,0)
}

return t
