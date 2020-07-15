
local t = Def.ActorFrame {
	Def.ActorFrame {
		InitCommand = function(self)
			self:zoom(0.666667)
		end,
		LoadActor(Smotc.get_rendered_text_path("word go")) .. {
			InitCommand=function(self)
				self:y(-50)
			end
		}
	}
}

return t
