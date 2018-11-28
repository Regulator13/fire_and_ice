/*
/ Description: updates name of the client on the menu
/ Script Call: scr_update_name(playerIndex, name)
/ Parameters : playerIndex - connectId of the client
/              name - new name for the player
/ Return     : void
*/

with (global.Menu) ds_list_replace(names, argument0, argument1);
