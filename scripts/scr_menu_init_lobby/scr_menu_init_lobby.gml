/// @description scr_menu_init_lobby(previous)
/// @param previous
/*
* Description:  change to lobby from online
* Parameters:   previous - the previous menu for the back button
* Returns:      void
*/


// set input
var previous = argument0;

// reset selected
selected = 0;

//if local game, give option to play right away
if not global.online scr_create_button(room_width-96, room_height-32, STATE_PATHS, "ready", false)

//back
scr_create_button(96, room_height-32, "back", "back", false)
