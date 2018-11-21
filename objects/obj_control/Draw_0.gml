/// @description Draw water
if (!global.online) {
    draw_set_alpha(.5);
    draw_rectangle_color(obj_wall.sprite_width,room_height-obj_wall.sprite_height, room_width-obj_wall.sprite_width, room_height-obj_wall.sprite_height-water_height, c_aqua, c_aqua, c_navy, c_navy, false);
}

///Draw roof
draw_set_color(c_red)
draw_rectangle(x + 30, 0, room_width - 30, 3, false)
