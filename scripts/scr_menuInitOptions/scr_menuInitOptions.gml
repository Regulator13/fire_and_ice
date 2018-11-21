/// @description scr_menuInitOptions()
/*
/ Description: initiate the options menu
/ Parameters : none
/ Return     : void
*/

//reset selected
selected = 0;
var button = instance_create_layer(room_width/2, 128, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Game Mode";
    ds_list_add(values, "Normal");
    value = ds_list_find_index(values, other.gameMode);
    }
ds_list_add(buttons, button);
	
//display variables
var b = 4//amount of buttons in the list
var cx = room_width/2//x center of the room
var hb = 32*(b+1)+16//height buffer from the bottom of the room
var by = 0//y buffer between buttons, incremented each button
var s = 48//spacing between the buttons

scr_create_button(cx, room_height-hb+s*by++, STATE_CONTROLS, "controls", false)
scr_create_button(cx, room_height-hb+s*by++, STATE_DEBUGOPTIONS, "debug", false)
scr_create_button(cx, room_height-hb+s*by++, STATE_GAME_OPTIONS, "game options", true)
scr_create_button(cx, room_height-hb+s*by++, "back", "main", false)
