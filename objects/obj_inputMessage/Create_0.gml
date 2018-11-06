/// @description input

// set in creation:
// prompt - message to display
prompt = "";
// actions - actions to enact after key press
actions = ds_list_create();
// actionTitles - title for each action
actionTitles = ds_list_create();
// actionSel - current action selected
actionSel = 0;
// Source - who created it
Source = noone;

// input_buffer - small buffer to slow down gamepad input
input_buffer = 0;
// input_buffer_max
input_buffer_max = 4;

// pause game
global.paused = true;

show_debug_message("obj_inputMessage Created");

