/// @description Change to debug options menu
state = STATE_DEBUGOPTIONS;

//save options
scr_saveOptions();
 
//REMOVE? THis piece of code is used many times, can we create a script for it?
//clear buttons
for (var i = 0; i < ds_list_size(buttons); i++) {
    with(ds_list_find_value(buttons, i)){
		instance_destroy();
	}
}
ds_list_clear(buttons);

//reset selected
selected = 0;

///Debug options menu
//delete options button
var button = instance_create_layer(room_width/2, room_height-128, "lay_instances",obj_button);
button.image_index = 9;
button.action = "delOptions";
button.title = "delete options";
button.sprite_index = spr_buttonLong;
ds_list_add(buttons, button);

//delete paths button
var button = instance_create_layer(room_width/2, room_height-80, "lay_instances", obj_button);
button.image_index = 8;
button.action = "delMissions";
button.title = "delete paths"
button.sprite_index = spr_buttonLong;
ds_list_add(buttons, button);

//options button
var button = instance_create_layer(room_width/2, room_height-32, "lay_instances", obj_button);
button.image_index = 4;
button.action = "optionsDebug";
button.title = "options";
ds_list_add(buttons, button);

/*
var button = instance_create(room_width/2-32, 128, obj_button);
with(button) {
    action = "value";
    title = "Deactivate Instance Outside of View";
    ds_list_add(values, "All", "All but Bombs and Walls", "None");
    value = ds_list_find_index(values, other.deactivateOutside);
    }
ds_list_add(buttons, button);
//yallVehicleCircles
var button = instance_create_layer(room_width/2-32, 128+32, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Draw Command Vehicle Circles";
    ds_list_add(values, "On", "Off");
    value = ds_list_find_index(values, other.yallVehicleCircles);
    }
ds_list_add(buttons, button);
//supplyPackValue
var button = instance_create_layer(room_width/2-32, 128+32*2, "lay_instances", obj_button);
with(button) {
    action = "value";
    title = "Supply Pack Value";
    ds_list_add(values, 25, 50, 75);
    value = ds_list_find_index(values, other.supplyPackValue);
    }
ds_list_add(buttons, button);
*/
