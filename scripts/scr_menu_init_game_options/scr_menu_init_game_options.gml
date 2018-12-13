/// @description scr_menu_init_game_options()
/*
/ Description: initiate the options menu
/ Parameters : none
/ Return     : void
*/

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
    value = other.animations_on
}
ds_list_add(buttons, button);

var button = instance_create_layer(c1x, cy+by*c1y++, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Water";
    ds_list_add(values, "Off", "On");
    value = other.water_on
}
ds_list_add(buttons, button);

var button = instance_create_layer(c1x, cy+by*c1y++, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Jetpack";
    ds_list_add(values, "Off", "On");
    value = other.jetpack_on
}
ds_list_add(buttons, button);

var button = instance_create_layer(c1x, cy+by*c1y++, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Locked Door";
    ds_list_add(values, "Off", "On");
    value = other.locked_door_on
}
ds_list_add(buttons, button);


//Second column
var button = instance_create_layer(c2x, cy+by*c2y++, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Difficulty";
    ds_list_add(values, "Beginner", "Easy", "Normal", "Hard", "Expert");
    value = other.difficulty
}
ds_list_add(buttons, button);

var button = instance_create_layer(c2x, cy+by*c2y++, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Rain Delay";
    ds_list_add(values, "300", "400", "600", "800", "1000", "1200", "1400", "1600", "1800", "2000");
    value = other.starting_water_delay
}
ds_list_add(buttons, button);

var button = instance_create_layer(c2x, cy+by*c2y++, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Rain Rate";
    ds_list_add(values, "0.10", "0.12", "0.14", "0.16", "0.18", "0.20", "0.22", "0.24", "0.26", "0.28", "0.30");
    value = other.starting_water_rate
}
ds_list_add(buttons, button);

/*
// secound column of input
for (c2y = 0; c2y < 4; c2y++) {
    var button = instance_create_layer(c2x, cy+by*c2y, "lay_instances", obj_control_button);
    button.key = c2y+c2;
    button.title = scr_get_input_name(global.controls[controlSelected, c2y+c2], button.key, controller);
    ds_list_add(buttons, button);
    }
break;
*/

scr_create_button(room_width/2, room_height-32-48*0, "back", "options", false)
