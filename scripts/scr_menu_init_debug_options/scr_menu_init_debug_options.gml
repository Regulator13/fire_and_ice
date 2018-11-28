/// @description scr_menu_init_debug_options()
/*
/ Description: initiate the options menu
/ Parameters : none
/ Return     : void
*/

// set state
state = STATE_DEBUGOPTIONS;

//display variables
var b = 3//amount of buttons in the list
var cx = room_width/2//x center of the room
var hb = 32*(b+1)//height buffer from the bottom of the room
var by = 0//y buffer between buttons, incremented each button
var s = 48//spacing between the buttons

//create buttons
scr_create_button(cx, room_height-hb+s*by++, "delOptions", "delete options", true)
scr_create_button(cx, room_height-hb+s*by++, "delMissions", "delete paths", true)
scr_create_button(cx, room_height-hb+s*by++, "back", "options", false)

//reset selected
selected = b-1