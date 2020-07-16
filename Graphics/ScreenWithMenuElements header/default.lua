local t = Def.ActorFrame {};

local headerFont = "Common Normal";

local function Update(self)
	local c = self:GetChildren();
	local bps = GAMESTATE:GetSongBPS() or 1
	c.TextureStripe:texcoordvelocity(bps/3,0);
end

local function IsVisible()
	local r = Screen.String("HeaderText");
	return string.len(r) > 0 and true or false
end

t[#t+1] = Def.Quad {
	InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+1,50;diffuse,ColorSchemeColors.Main);
}
t[#t+1] = LoadActor("_texture stripe") .. {
	Name="TextureStripe";
	InitCommand=cmd(x,-SCREEN_CENTER_X-8;y,-2;horizalign,left;vertalign,top;zoomto,320,50;customtexturerect,0,0,(320/2)/8,50/32);
	OnCommand=cmd(texcoordvelocity,2,0;skewx,-0.0575;diffuse,ColorSchemeColors.Header;diffuserightedge,ColorSchemeColors.HeaderNoAlpha);
};
t[#t+1] = LoadActor("Header") .. {
	InitCommand=cmd(y,1;vertalign,top;zoomtowidth,SCREEN_WIDTH+1;diffuse,color("#808080"));
	OnCommand=cmd(croptop,46/60);
};

t[#t+1] = LoadFont(headerFont) .. {
	Name="HeaderShadow";
	Text=Screen.String("HeaderText");
	InitCommand=cmd(x,-SCREEN_CENTER_X+26;y,28;zoom,1;horizalign,left;maxwidth,200);
	OnCommand=cmd(visible,IsVisible();diffuse,BoostColor(ColorSchemeColors.Deep,0.375););
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
};

t[#t+1] = Def.Quad {
	Name="Underline";
	InitCommand=cmd(x,-SCREEN_CENTER_X+24-4;y,36;horizalign,left);
	OnCommand=cmd(stoptweening;diffuse,ColorSchemeColors.Deep;shadowlength,2;shadowcolor,BoostColor(ColorSchemeColors.DeepSemiAlpha,0.25);linear,0.25;zoomtowidth,192;fadeleft,8/192;faderight,0.5;
		visible,IsVisible());
};

t[#t+1] = LoadFont(headerFont) .. {
	Name="HeaderText";
	Text=Screen.String("HeaderText");
	InitCommand=cmd(x,-SCREEN_CENTER_X+24;y,26;zoom,1;horizalign,left;shadowlength,0;maxwidth,200);
	OnCommand=cmd(visible,IsVisible();diffuse,color("#ffffff"););
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
};

t.BeginCommand=function(self)
	self:SetUpdateFunction( Update );
end

return t
