/// @description change to controls menu

//reset selected
selected = 2; // start on host button

// temporarily freeze input
input_freeze = input_freezeMax;

// set room width and height manually, in case of changing from game
var rw = 1152;
var rh = 768;

// setup online menu
scr_create_button(96, rh-32, "back", "back", false)//back
scr_create_button(96+32+200+154+64*2, rh - 32, "directConnect", "direct", false)//direct connect
scr_create_button(rw - 96, rh - 32, "createServer", "host", false)//host
    
// create online object to handle everything
instance_create_layer(0, 0, "lay_instances", obj_online);
