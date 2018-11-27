/// @description Draw input
draw_self();

//setup drawing
draw_set_halign(fa_center);
draw_set_font(fnt_command);
draw_set_color(c_white);

draw_text(x, y-16, string_hash_to_newline(input));

//reset
draw_set_halign(fa_left);
