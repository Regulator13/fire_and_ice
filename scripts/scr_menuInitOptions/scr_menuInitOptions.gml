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
var button = instance_create(room_width/2, 128, obj_button);
    with(button) {
        action = "value";
        title = "Game Mode";
        ds_list_add(values, "Normal");
        value = ds_list_find_index(values, other.gameMode);
        }
    ds_list_add(buttons, button);
    /*
    var button = instance_create(room_width/2, room_height-160, obj_button);
    button.image_index = 5;
    button.action = "addNickname";
    ds_list_add(buttons, button);
    var button = instance_create(room_width/2, room_height-128, obj_button);
    button.image_index = 6;
    button.action = "delNickname";
    ds_list_add(buttons, button);
    */
    var button = instance_create(room_width/2, room_height-32-48*2, obj_button);
    button.action = "controls";
    ds_list_add(buttons, button);
    var button = instance_create(room_width/2, room_height-80, obj_button);
    button.image_index = 7;
    button.action = "debugOptions";
    button.title = "debug";
    ds_list_add(buttons, button);
    var button = instance_create(room_width/2, room_height-32, obj_button);
    button.action = "mainOptions";
    button.title = "main";
    ds_list_add(buttons, button);
