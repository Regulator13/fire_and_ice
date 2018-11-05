/// @description change to main from options
state = STATE_MAIN;

//save options
scr_saveOptions();
    
//clear buttons
for (var i = 0; i < ds_list_size(buttons); i++) {
    with(ds_list_find_value(buttons, i)) instance_destroy();
    }
ds_list_clear(buttons);

//reset selected
selected = 0;

///main menu
hb = 64;
var button = instance_create_layer(room_width/2, 176+hb, "lay_instances", obj_button);
button.image_index = 0;
button.action = "lobby";
ds_list_add(buttons, button);
var button = instance_create_layer(room_width/2, 176+48+hb, "lay_instances", obj_button);
button.image_index = 4;
button.action = "online";
ds_list_add(buttons, button);
var button = instance_create_layer(room_width/2, 176+48*2+hb, "lay_instances", obj_button);
button.image_index = 4;
button.action = "options";
ds_list_add(buttons, button);
var button = instance_create_layer(room_width/2, room_height-64, "lay_instances", obj_button);
button.image_index = 1;
button.action = "quit";
ds_list_add(buttons, button);

