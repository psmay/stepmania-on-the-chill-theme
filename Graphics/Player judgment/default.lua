local c;
local judgmentActorsHolder;
local player = Var "Player";
local function ShowProtiming()
  if GAMESTATE:IsDemonstration() then
    return false
  else
    return GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(player));
  end
end;
local bShowProtiming = ShowProtiming();
local ProtimingWidth = 240;
local function MakeAverage( t )
	local sum = 0;
	for i=1,#t do
		sum = sum + t[i];
	end
	return sum / #t
end

local tTotalJudgments = {};

local TapNoteScoreTable = Sqib.from({
  { name = "W1", frame = 0 },
  { name = "W2", frame = 1 },
  { name = "W3", frame = 2 },
  { name = "W4", frame = 3 },
  { name = "W5", frame = 4 },
  { name = "Miss", frame = 5 },
})

for _,v in TapNoteScoreTable:iterate() do
  v.tns_name = "TapNoteScore_" .. v.name
  v.actor_name = "Judgment_" .. v.name
  v.color = GameColor.Judgment["JudgmentLine_" .. v.name]
end

local JudgeCmds = TapNoteScoreTable
  :pairs_to_hash(function(v)
    return v.tns_name, THEME:GetMetric("Judgment", "Judgment" .. v.name .. "Command") end
    )

local ProtimingCmds = TapNoteScoreTable
  :pairs_to_hash(
    function(v) return v.tns_name, THEME:GetMetric("Protiming", "Protiming" .. v.name .. "Command") end
    )

local AverageCmds = {
	Pulse = THEME:GetMetric( "Protiming", "AveragePulseCommand" );
};
local TextCmds = {
	Pulse = THEME:GetMetric( "Protiming", "TextPulseCommand" );
};

local TNSFrames = TapNoteScoreTable
  :pairs_to_hash(function(v) return v.tns_name, v.frame end)

local t = Def.ActorFrame {};

local judgment_actors_frame =
  Def.ActorFrame {
    Name="JudgmentActorsHolder",
    InitCommand=function(self)
      self
        :zoom(0.15)
        :y(-8)
    end
  }

TapNoteScoreTable
  :map(function(v)
    return LoadActor("Text " .. v.name) .. {
      Name = v.actor_name,
      InitCommand = function(self)
        self
          :diffuse(v.color)
          :pause()
          :visible(false)
      end,
      OnCommand = THEME:GetMetric("Judgment", "JudgmentOnCommand"),
      ResetCommand = function(self)
        self
          :finishtweening()
          :stopeffect()
          :visible(false)
      end
    }
  end)
  :copy_into_array(judgment_actors_frame, #judgment_actors_frame + 1)


t[#t+1] = Def.ActorFrame {
  Def.ActorFrame {
    -- This double wrapping seems to be necessary to prevents the judgment commands from changing the absolute zoom of
    -- the actors.
    Name="JudgmentActorsHolderHolder",
    judgment_actors_frame
  };
	LoadFont("Combo Numbers") .. {
		Name="ProtimingDisplay";
		Text="";
		InitCommand=cmd(visible,false);
		OnCommand=THEME:GetMetric("Protiming","ProtimingOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	LoadFont("Common Normal") .. {
		Name="ProtimingAverage";
		Text="";
		InitCommand=cmd(visible,false);
		OnCommand=THEME:GetMetric("Protiming","AverageOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	LoadFont("Common Normal") .. {
		Name="TextDisplay";
		Text=THEME:GetString("Protiming","MS");
		InitCommand=cmd(visible,false);
		OnCommand=THEME:GetMetric("Protiming","TextOnCommand");
		ResetCommand=cmd(finishtweening;stopeffect;visible,false);
	};
	Def.Quad {
		Name="ProtimingGraphBG";
		InitCommand=cmd(visible,false;y,32;zoomto,ProtimingWidth,16);
		ResetCommand=cmd(finishtweening;diffusealpha,0.8;visible,false);
		OnCommand=cmd(diffuse,Color("Black");diffusetopedge,color("0.1,0.1,0.1,1");diffusealpha,0.8;shadowlength,2;);
	};
	Def.Quad {
		Name="ProtimingGraphWindowW3";
		InitCommand=cmd(visible,false;y,32;zoomto,ProtimingWidth-4,16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,GameColor.Judgment["JudgmentLine_W3"];);
	};
	Def.Quad {
		Name="ProtimingGraphWindowW2";
		InitCommand=cmd(visible,false;y,32;zoomto,scale(PREFSMAN:GetPreference("TimingWindowSecondsW2"),0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,ProtimingWidth-4),16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,GameColor.Judgment["JudgmentLine_W2"];);
	};
	Def.Quad {
		Name="ProtimingGraphWindowW1";
		InitCommand=cmd(visible,false;y,32;zoomto,scale(PREFSMAN:GetPreference("TimingWindowSecondsW1"),0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),0,ProtimingWidth-4),16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,GameColor.Judgment["JudgmentLine_W1"];);
	};
	Def.Quad {
		Name="ProtimingGraphUnderlay";
		InitCommand=cmd(visible,false;y,32;zoomto,ProtimingWidth-4,16-4);
		ResetCommand=cmd(finishtweening;diffusealpha,0.25;visible,false);
		OnCommand=cmd(diffuse,Color("Black");diffusealpha,0.25);
	};
	Def.Quad {
		Name="ProtimingGraphFill";
		InitCommand=cmd(visible,false;y,32;zoomto,0,16-4;horizalign,left;);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,Color("Red"););
	};
	Def.Quad {
		Name="ProtimingGraphAverage";
		InitCommand=cmd(visible,false;y,32;zoomto,2,7;);
		ResetCommand=cmd(finishtweening;diffusealpha,0.85;visible,false);
		OnCommand=cmd(diffuse,ColorSchemeColors.VeryShallow;diffusealpha,0.85);
	};
	Def.Quad {
		Name="ProtimingGraphCenter";
		InitCommand=cmd(visible,false;y,32;zoomto,2,16-4;);
		ResetCommand=cmd(finishtweening;diffusealpha,1;visible,false);
		OnCommand=cmd(diffuse,Color("White");diffusealpha,1);
	};
	InitCommand = function(self)
		c = self:GetChildren()
    local judgment_actors = c.JudgmentActorsHolderHolder:GetChildren().JudgmentActorsHolder:GetChildren()
    for _, v in TapNoteScoreTable:iterate() do
      v.actor = judgment_actors[v.actor_name]
    end
	end;

	JudgmentMessageCommand=function(self, param)
        -- Fix Player Combo animating when player successfully avoids a mine.
        local msgParam = param;
        MESSAGEMAN:Broadcast("TestJudgment",msgParam);
        --
		if param.Player ~= player then return end;
		if param.HoldNoteScore then return end;
		
		local fTapNoteOffset = param.TapNoteOffset;
		if param.HoldNoteScore then
			fTapNoteOffset = 1;
		else
			fTapNoteOffset = param.TapNoteOffset; 
		end
		
		if param.TapNoteScore == 'TapNoteScore_Miss' then
			fTapNoteOffset = 1;
			bUseNegative = true;
		else
-- 			fTapNoteOffset = fTapNoteOffset;
			bUseNegative = false;
		end;
		
		if fTapNoteOffset ~= 1 then
			-- we're safe, you can push the values
			tTotalJudgments[#tTotalJudgments+1] = math.abs(fTapNoteOffset);
--~ 			tTotalJudgments[#tTotalJudgments+1] = bUseNegative and fTapNoteOffset or math.abs( fTapNoteOffset );
		end
		
		self:playcommand("Reset");

		c.JudgmentActorsHolderHolder:visible( not bShowProtiming );
    for _, v in TapNoteScoreTable:iterate() do
      local actor = v.actor
      if v.tns_name == param.TapNoteScore then
        actor:visible(true)
      else
        actor:visible(false)
      end
    end
    JudgeCmds[param.TapNoteScore](c.JudgmentActorsHolderHolder)
		
		c.ProtimingDisplay:visible( bShowProtiming );
		c.ProtimingDisplay:settextf("%i",fTapNoteOffset * 1000);
		ProtimingCmds[param.TapNoteScore](c.ProtimingDisplay);
		
		c.ProtimingAverage:visible( bShowProtiming );
		c.ProtimingAverage:settextf("%.2f%%",clamp(100 - MakeAverage( tTotalJudgments ) * 1000 ,0,100));
		AverageCmds['Pulse'](c.ProtimingAverage);
		
		c.TextDisplay:visible( bShowProtiming );
		TextCmds['Pulse'](c.TextDisplay);
		
		c.ProtimingGraphBG:visible( bShowProtiming );
		c.ProtimingGraphUnderlay:visible( bShowProtiming );
		c.ProtimingGraphWindowW3:visible( bShowProtiming );
		c.ProtimingGraphWindowW2:visible( bShowProtiming );
		c.ProtimingGraphWindowW1:visible( bShowProtiming );
		c.ProtimingGraphFill:visible( bShowProtiming );
		c.ProtimingGraphFill:finishtweening();
		c.ProtimingGraphFill:decelerate(1/60);
-- 		c.ProtimingGraphFill:zoomtowidth( clamp(fTapNoteOffset * 188,-188/2,188/2) );
		c.ProtimingGraphFill:zoomtowidth( clamp(
				scale(
				fTapNoteOffset,
				0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),
				0,(ProtimingWidth-4)/2),
			-(ProtimingWidth-4)/2,(ProtimingWidth-4)/2)
		);
		c.ProtimingGraphAverage:visible( bShowProtiming );
		c.ProtimingGraphAverage:zoomtowidth( clamp(
				scale(
				MakeAverage( tTotalJudgments ),
				0,PREFSMAN:GetPreference("TimingWindowSecondsW3"),
				0,ProtimingWidth-4),
			0,ProtimingWidth-4)
		);
-- 		c.ProtimingGraphAverage:zoomtowidth( clamp(MakeAverage( tTotalJudgments ) * 1880,0,188) );
		c.ProtimingGraphCenter:visible( bShowProtiming );
		(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphBG);
		(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphUnderlay);
		(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphWindowW3);
		(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphWindowW2);
		(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphWindowW1);
		(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphFill);
		(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphAverage);
		(cmd(sleep,2;linear,0.5;diffusealpha,0))(c.ProtimingGraphCenter);
	end;

};


return t;
