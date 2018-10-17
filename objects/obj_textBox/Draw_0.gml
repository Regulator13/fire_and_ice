/// @description  Draw the text box and "caption"
draw_self();

draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(fnt_command);
draw_set_halign(fa_left);
draw_text( x+5,y, string_hash_to_newline(text));

draw_set_color(c_white);
draw_text( x,y-28, string_hash_to_newline(title));


