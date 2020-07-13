ModeIconColors = {
	Normal		= color("#FFEE00"), -- yellow
	Rave		= color("#db93ff"), -- violet
	Nonstop		= color("#5ca9ff"), -- blue
	Oni			= color("#00f1e2"), -- cyan
	Endless		= color("#b4c3d2"), -- steel
}

--	0	Red
--	30	Orange
--	60	Yellow
--	120	Green
--	180	Cyan
--	240 Blue
--	270 Purple
--	300	Magenta
--	330 Red with some Blue
TintHue = 240 -- Default scheme would use 48 here

-- TODO: Come up with better color names. These are terrible.

ColorSchemeColors = {
	VeryShallow	= HSV(TintHue - 18,		1,		1),
	OffMain		= HSV(TintHue - 1, 		1,	 	.94),
	Main		= HSV(TintHue,			1,		1),
	Deep		= HSV(TintHue + 2,		1,		1),
	VeryDeep	= HSV(TintHue + 17,		1,		1),

	Header		= HSV(TintHue - 3,		1,		.35),

	Indicator	= HSV(TintHue - 30,		1,		1),

	FullyOn		= HSV(0,				0,		1),
	FullyOff	= HSV(0,				0,		0),
	Extra		= HSV(0,				1,		1),
}

ColorSchemeColors.GameOver = ColorSchemeColors.Indicator

ColorSchemeColors.DeepSemiAlpha = Alpha(ColorSchemeColors.Deep, 0.5)
ColorSchemeColors.HeaderNoAlpha = Alpha(ColorSchemeColors.Header, 0.0)
