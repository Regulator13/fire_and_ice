/// @description Draw self and laser
if !(global.online) {
    //draw laser
	if laser_on{
		draw_set_color(c_red);
		draw_line_width(x-8*dir+8, y+7, laserX, y+7, 2);
	}
	
    draw_self();
}

