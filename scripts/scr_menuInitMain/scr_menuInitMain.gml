/// @description change to main
state = STATE_MAIN;

//reset selected
selected = 0;

//display variables
var hb = 176+64//height buffer for the header bar
var yb = 0//y buffer incremented by one after each button
var s = 48//spacing between buttons

//create buttons
scr_create_button(room_width/2, hb+s*yb++, STATE_LOBBY, "play", true)
scr_create_button(room_width/2, hb+s*yb++, STATE_ONLINE, "online", true)
scr_create_button(room_width/2, hb+s*yb++, STATE_OPTIONS, "options", true)
scr_create_button(room_width/2, room_height-64, "quit", "quit", true)
