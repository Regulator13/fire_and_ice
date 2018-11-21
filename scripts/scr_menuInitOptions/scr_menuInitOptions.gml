/// @description scr_menuInitOptions()
/*
/ Description: initiate the options menu
/ Parameters : none
/ Return     : void
*/

// set state
state = STATE_OPTIONS;

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
    /*
    var button = instance_create_layer(room_width/2, room_height-160, "lay_instances", obj_button);
    button.image_index = 5;
    button.action = "addNickname";
    ds_list_add(buttons, button);
    var button = instance_create_layer(room_width/2, room_height-128, "lay_instances", obj_button);
    button.image_index = 6;
    button.action = "delNickname";
    ds_list_add(buttons, button);
    */
    var button = instance_create_layer(room_width/2, room_height-32-48*3, "lay_instances", obj_button);
    button.action = "controls";
    ds_list_add(buttons, button);
	
    var button = instance_create_layer(room_width/2, room_height-32-48*2, "lay_instances", obj_button);
    button.image_index = 7;
    button.action = "debugOptions";
    button.title = "debug";
    ds_list_add(buttons, button);
	
	var button = instance_create_layer(room_width/2, room_height-32-48*1, "lay_instances", obj_button);
    button.action = "gameOptionsOptions";
    button.title = "game opts";
    ds_list_add(buttons, button);
	
    var button = instance_create_layer(room_width/2, room_height-32-48*0, "lay_instances", obj_button);
    button.action = "mainOptions";
    button.title = "main";
    ds_list_add(buttons, button);
