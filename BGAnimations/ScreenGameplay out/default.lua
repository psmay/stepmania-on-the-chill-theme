local raveChildren

local initialBottomCrop = 1
local initialBottomFade = 1
local enterTransitionWait = 0.5
local enterTransitionDuration = 0.5
local enteredBottomCrop = 0
local enteredBottomFade = 0
local exitTransitionWait = 1.75
local exitTransitionDuration = 0.25
local exitedAlpha = 0

local messageTextInit = cmd(Center;cropbottom,initialBottomCrop;fadebottom,initialBottomFade;);
local messageTextOn = cmd(sleep,enterTransitionWait;linear,enterTransitionDuration;cropbottom,enteredBottomCrop;fadebottom,enteredBottomFade;sleep,exitTransitionWait;linear,exitTransitionDuration;diffusealpha,exitedAlpha);


local bg = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,0"));
		OnCommand=cmd(linear,1;diffusealpha,1);
	};

	Def.ActorFrame{
		Name="RaveMessages";
		InitCommand=function(self)
			raveChildren = self:GetChildren()
			self:visible(GAMESTATE:GetPlayMode() == 'PlayMode_Rave')

			raveChildren.P1Win:visible(false)
			raveChildren.P2Win:visible(false)
			raveChildren.Draw:visible(false)
		end;
		OffCommand=function(self)
			local p1Win = GAMESTATE:IsWinner(PLAYER_1)
			local p2Win = GAMESTATE:IsWinner(PLAYER_2)

			if GAMESTATE:IsWinner(PLAYER_1) then
				raveChildren.P1Win:visible(true)
			elseif GAMESTATE:IsWinner(PLAYER_2) then
				raveChildren.P2Win:visible(true)
			else
				raveChildren.Draw:visible(true)
			end
		end;

		LoadActor(THEME:GetPathG("_rave result","P1"))..{
			Name="P1Win";
			InitCommand=messageTextInit;
			OnCommand=messageTextOn;
		};
		LoadActor(THEME:GetPathG("_rave result","P2"))..{
			Name="P2Win";
			InitCommand=messageTextInit;
			OnCommand=messageTextOn;
		};
		LoadActor(THEME:GetPathG("_rave result","draw"))..{
			Name="Draw";
			InitCommand=messageTextInit;
			OnCommand=messageTextOn;
		};
	};

	Def.ActorFrame{
		InitCommand=function(self)
			self:visible(GAMESTATE:GetPlayMode() ~= 'PlayMode_Rave')
		end;
		
		LoadActor("cleared")..{
			InitCommand=messageTextInit;
			OnCommand=messageTextOn;
		};
	};
};

return bg
