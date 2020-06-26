local ars_stepmania_perspective_zoom = 0.5262;
local on_the_chill_zoom = 0.405;
local base_duration = 0.25;

local t = Def.ActorFrame{
	-- The application of queuecommand below appears to fix an issue wherein
	-- the main menu wouldn't respond to input until the animation had
	-- finished. queuecommand apparently runs its commands in a thread
	-- and/or context asynchronous to this one, eliminating the wait.
	LoadActor("ars-stepmania-perspective")..{
		InitCommand=cmd(x,-35;y,-10,zoom,ars_stepmania_perspective_zoom);
		AsyncOnCommand=cmd(zoom,ars_stepmania_perspective_zoom*1.4;smooth,base_duration;zoom,ars_stepmania_perspective_zoom);
		OnCommand=cmd(queuecommand,"AsyncOn");
	};
	Def.ActorFrame {
		InitCommand=cmd(zoom,on_the_chill_zoom;x,109;y,51);
		-- The idea here is to fade in a whited-out version of the "on the
		-- chill" text, plant the regular-colored version behind it, and
		-- then fade the whited-out version back out. I get the distinct
		-- feeling that there is some way I couldn't find to white out an
		-- image in the script instead of having the two versions on disk.
		-- glow almost works, but alpha adjustments don't seem to have any
		-- effect on a glowing actor. If you know of a better way, I'm
		-- listening. -- psmay
		LoadActor("on-the-chill-c")..{
			AsyncOnCommand=cmd(diffusealpha,0;sleep,4*base_duration;diffusealpha,1);
			OnCommand=cmd(queuecommand,"AsyncOn");
		};
		LoadActor("on-the-chill-w")..{
			AsyncOnCommand=cmd(diffusealpha,0;sleep,2*base_duration;smooth,0.5;diffusealpha,1;smooth,2*base_duration;diffusealpha,0);
			OnCommand=cmd(queuecommand,"AsyncOn");
		};
	};
};

return t;
