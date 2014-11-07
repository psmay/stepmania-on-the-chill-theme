local ars_stepmania_perspective_zoom = 0.5262;
local on_the_chill_zoom = 0.405;

local t = Def.ActorFrame{
	LoadActor("ars-stepmania-perspective")..{
		InitCommand=cmd(zoom,ars_stepmania_perspective_zoom;x,-35;y,-10);
		OnCommand=cmd(zoom,ars_stepmania_perspective_zoom*1.4;smooth,0.25;zoom,ars_stepmania_perspective_zoom);
	};
	Def.ActorFrame {
		InitCommand=cmd(zoom,on_the_chill_zoom;x,109;y,51);
		-- The idea here is to fade in a whited-out version of the "on the
		-- chill" text, plant the regular-colored version behind it, and
		-- then fade the whited-out version back out. The result should
		-- appear to be a variation on glowshift. However, I wasn't able to
		-- get it working with glowshift. I also get the distinct feeling
		-- that there is some way I couldn't find to white out an image in
		-- the script instead of having the two versions on disk. I simply
		-- ran out of time to look for it. -- psmay
		LoadActor("on-the-chill-c")..{
			OnCommand=cmd(diffusealpha,0;sleep,1.0;diffusealpha,1);
			OffCommand=cmd(stopeffect);
		};
		LoadActor("on-the-chill-w")..{
			OnCommand=cmd(diffusealpha,0;sleep,0.5;smooth,0.5;diffusealpha,1;smooth,0.5;diffusealpha,0);
			OffCommand=cmd(stopeffect);
		};
	};
};

return t;
