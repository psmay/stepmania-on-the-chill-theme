
local t = Def.ActorFrame {
	Def.ActorFrame {
		InitCommand = function(self)
			self:zoom(0.333333)
		end,
		LoadActor(Smotc.get_rendered_text_path("word ready")) .. {
			InitCommand=function(self)
				self:y(-50)
			end
		}
	}
}

return t
