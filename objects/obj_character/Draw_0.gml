/// @description Draw self if not online
if (view_current == 0) if !(global.online) draw_self();

//Draw keyboard aim reticule if not online
if view_current == 0{
	if !global.online{
		if input_method == CONTROLS_KEYBOARD{
			draw_set_color(c_red)
			var x_off = dsin(aim_direction) * dir
			var y_off = -dcos(aim_direction)
			draw_line(x + sprite_width/2 + x_off*8, y + sprite_height/2 + y_off*8, x + sprite_width/2 + x_off*16, y + sprite_width/2 + y_off*16)
		}
	}
}
