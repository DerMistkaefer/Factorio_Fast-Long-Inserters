FLI = {}
FLI.modName = "FastLongInserters"
FLI.guiPath = "__"..FLI.modName.."__/graphics/gui/"


data:extend({
	{type = "font", name = "FLI_font", from = "default", border = false, size = 20},
	{type = "font", name = "FLI_font_io_number", from = "default", border = false, size = 45},
	{type = "font", name = "FLI_font_bold", from = "default-bold", border = false, size = 20},
	{type = "font", name = "FLI_Titel_font", from = "default-bold", border = false, size = 38},
	
	{type = "sprite", name = "FLI_sprite_button_top", filename = "__core__/graphics/arrows/hint-orange-arrow-up.png", width = 62, height = 37},
	{type = "sprite", name = "FLI_sprite_button_down", filename = "__core__/graphics/arrows/hint-orange-arrow-down.png", width = 71, height = 35},
})

local default_gui =  data.raw["gui-style"].default

default_gui.FLI_base_style = {
	type="frame_style",
	parent="frame",
	top_padding = 150,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	graphical_set = { type = "none" }
}

default_gui.FLI_frame_style = {
	type="frame_style",
	parent="frame",
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 10
}

default_gui.FLI_vertical_flow_style = {
	type="vertical_flow_style",
	top_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	right_padding = 0,
	
	horizontal_spacing = 2,
	vertical_spacing = 2,
	resize_row_to_width = true,
	resize_to_row_height = false,
	max_on_row = 1,
	
	graphical_set = { type = "none" }
}

default_gui.FLI__horizontal_flow_style = {
	type="horizontal_flow_style",
	top_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	right_padding = 0,

	horizontal_spacing = 2,
	vertical_spacing = 2,
	resize_row_to_width = true,
	resize_to_row_height = false,
	max_on_row = 1,

	graphical_set = { type = "none" }
}

default_gui.FLI_label_style ={
	type="label_style",
	parent="label",
	font="FLI_font_bold",
	align = "left",
	default_font_color={r=1, g=1, b=1},
	hovered_font_color={r=1, g=1, b=1},
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0
}

default_gui.FLI_button_style = {
	type="button_style",
	parent="button",
	font="FLI_font_bold",
	align = "center",
	default_font_color={r=1, g=1, b=1},
	hovered_font_color={r=1, g=1, b=1},
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	left_click_sound = {{filename = "__core__/sound/gui-click.ogg", volume = 1}}
}

--------------------------------------------------------------------------------------

default_gui.FLI_label_IO_Button_Titel_style = {type="label_style", parent="FLI_label_style", font="FLI_Titel_font"}
default_gui.FLI_button_IO_Button_style = {type="button_style", parent="FLI_button_style", width = 44, height = 24}
default_gui.FLI_label_IO_Number_style = {type="label_style", parent="FLI_label_style", font="FLI_font_io_number"}


