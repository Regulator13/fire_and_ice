/// @description  draw messages

// set up
draw_set_alpha(1);

// draw rectangle
var cx = room_width/2
var b = 32;
var bh = 90;

draw_set_color(c_dkgray);
draw_rectangle(b, b, cx*2-b, bh+b, false);
draw_set_color(c_gray);
draw_rectangle(b, b, cx*2-b, bh+b, true);

// set up
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_buttons);
draw_set_color(c_white);

// draw message
draw_text(cx, b+bh/2, string_hash_to_newline(messages[| currentMessage]));

