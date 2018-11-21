/// @description scr_menuInitGameOptions()
/*
/ Description: initiate the options menu
/ Parameters : none
/ Return     : void
*/

// set state
state = STATE_GAME_OPTIONS;

//reset selected
selected = 0;

/* //SLIDER BUTTON
var button = instance_create_layer(room_width/2, 128, "lay_instances", obj_button);
	with(button) {
        action = "value";
        title = "Game Mode";
        ds_list_add(values, "Normal");
        value = ds_list_find_index(values, other.gameMode);
        }
    ds_list_add(buttons, button);
	*/
	
// setup columns
var c1x = room_width/4;
var c2x = c1x*3;
var cy = 200;
var c1y = 0;
var c2y = 0;
var by = 64;

// first column of input
var button = instance_create_layer(c1x, cy+by*c1y++, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Animations";
    ds_list_add(values, "Off", "On");
    value = ds_list_find_index(values, other.animations_on);
}
ds_list_add(buttons, button);

/*
// secound column of input
for (c2y = 0; c2y < 4; c2y++) {
    var button = instance_create_layer(c2x, cy+by*c2y, "lay_instances", obj_controlButton);
    button.key = c2y+c2;
    button.title = scr_getInputName(global.controls[controlSelected, c2y+c2], button.key, controller);
    ds_list_add(buttons, button);
    }
break;
*/

scr_create_button(room_width/2, room_height-32-48*0, "optionsGameOptions", "options")
