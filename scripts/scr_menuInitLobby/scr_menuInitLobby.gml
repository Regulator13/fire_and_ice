/// @description scr_menuInitLobby(previous)
/// @param previous
/*
* Description:  change to lobby from online
* Parameters:   previous - the previous menu for the back button
* Returns:      void
*/


// set input
var previous = argument0;

// set state
state = STATE_LOBBY;

// reset selected
selected = 0;

//if local game, give option to play right away
if not global.online scr_create_button(room_width-96, room_height-32, "ready", "ready")

// back
var button = instance_create_layer(96, room_height-32, "lay_instances", obj_button);
if (previous == STATE_ONLINE) 
    button.action = "backOnlineLobby";
else
    button.action = "backMainLobby";
button.title = "back";
ds_list_add(buttons, button);
