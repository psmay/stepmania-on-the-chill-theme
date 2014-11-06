local t = Def.ActorFrame {};

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
	InitCommand=cmd(vertalign,top;zoomto,SCREEN_WIDTH+1,50;diffuse,color("#161616"));
}
t[#t+1] = LoadActor("_texture stripe") .. {
	Name="TextureStripe";
	InitCommand=cmd(x,-SCREEN_CENTER_X-8;y,-2;horizalign,left;vertalign,top;zoomto,320,50;customtexturerect,0,0,(320/2)/8,50/32);
	OnCommand=cmd(texcoordvelocity,2,0;skewx,-0.0575;diffuse,color("#000088");diffuserightedge,color("#00008800"));
};
t[#t+1] = LoadActor("Header") .. {
	InitCommand=cmd(y,1;vertalign,top;zoomtowidth,SCREEN_WIDTH+1;diffuse,color("#0000ff"));
	OnCommand=cmd(croptop,46/60);
};

t[#t+1] = LoadFont("Common Bold") .. {
	Name="HeaderShadow";
	Text=Screen.String("HeaderText");
	InitCommand=cmd(x,-SCREEN_CENTER_X+26;y,28;zoom,1;horizalign,left;maxwidth,200);
	OnCommand=cmd(visible,IsVisible();skewx,-0.125;diffuse,BoostColor(color("#0000ff77"),0.375););
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
};

t[#t+1] = Def.Quad {
	Name="Underline";
	InitCommand=cmd(x,-SCREEN_CENTER_X+24-4;y,36;horizalign,left);
	OnCommand=cmd(diffuse,color("#0000ff");shadowlength,2;shadowcolor,BoostColor(color("#0000ff77"),0.25);linear,0.25;zoomtowidth,192;fadeleft,8/192;faderight,0.5;
		visible,string.len( Screen.String("HeaderText") ) > 0 );
};

t[#t+1] = LoadFont("Common Bold") .. {
	Name="HeaderText";
	Text=Screen.String("HeaderText");
	InitCommand=cmd(x,-SCREEN_CENTER_X+24;y,26;zoom,1;horizalign,left;shadowlength,0;maxwidth,200);
	OnCommand=cmd(visible,IsVisible();skewx,-0.125;diffuse,color("#ffffff"););
	UpdateScreenHeaderMessageCommand=function(self,param)
		self:settext(param.Header);
	end;
};

t.BeginCommand=function(self)
	self:SetUpdateFunction( Update );
end

return t
