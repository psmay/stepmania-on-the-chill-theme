
local font_name = "Angular Sans";

local start_delay_increment=0.2;
local get_start = function (step)
	return step * start_delay_increment;
end
local transition_duration=0.4

local t = Def.ActorFrame {
	Def.ActorFrame {
		InitCommand=cmd(Center);

		LoadFont(font_name) .. {
			Text=string.lower("Game Software and Original Theme");
			InitCommand=cmd(strokecolor,Color("Outline");y,SCREEN_HEIGHT*-0.438;rotationx,90;sleep,get_start(0);smooth,transition_duration;rotationx,0);
		};
		LoadActor("sm-arrow-logo") .. {
			InitCommand=cmd(zoom,0.49;x,SCREEN_WIDTH*-0.247;y,SCREEN_HEIGHT*-0.262;rotationx,90;sleep,get_start(1);smooth,transition_duration;rotationx,0);
		};
		LoadActor("ssc-logo") .. {
			InitCommand=cmd(zoom,0.49;x,SCREEN_WIDTH*0.168;y,SCREEN_HEIGHT*-0.262;rotationx,90;sleep,get_start(2);smooth,transition_duration;rotationx,0);
		};
		LoadFont(font_name) .. {
			Text="http://stepmania.com/";
			InitCommand=cmd(strokecolor,Color("Outline");zoom,1.2;y,SCREEN_HEIGHT*-0.084;rotationx,90;sleep,get_start(3);smooth,transition_duration;rotationx,0);
		};

		LoadFont(font_name) .. {
			Text=string.lower("New Theme Design and Artwork");
			InitCommand=cmd(strokecolor,Color("Outline");y,SCREEN_HEIGHT*0.045;rotationx,90;sleep,get_start(4);smooth,transition_duration;rotationx,0);
		};
		LoadActor("rhythm-hfgk-logo") .. {
			InitCommand=cmd(zoom,0.587;x,SCREEN_WIDTH*0;y,SCREEN_HEIGHT*0.168;rotationx,90;sleep,get_start(5);smooth,transition_duration;rotationx,0);
		};
		LoadFont(font_name) .. {
			Text="http://rhythm.hfgk.us/";
			InitCommand=cmd(strokecolor,Color("Outline");zoom,1.2;y,SCREEN_HEIGHT*0.294;rotationx,90;sleep,get_start(6);smooth,transition_duration;rotationx,0);
		};
	};
};

return t;
