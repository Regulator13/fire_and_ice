/// @description change to main
state = STATE_MAIN;

//reset selected
selected = 0;

// first menu
hb = 64;
var button = instance_create_layer(room_width/2, 176+hb, "lay_instances", obj_button);
button.action = "lobby";
button.title = "play";
ds_list_add(buttons, button);
var button = instance_create_layer(room_width/2, 176+48+hb, "lay_instances", obj_button);
button.image_index = 4;
button.action = "online";
ds_list_add(buttons, button);
//var button = instance_create_layer(room_width/2, 176+48*2+hb, "lay_instances", obj_button);
//button.action = "controls";
//ds_list_add(buttons, button);
var button = instance_create_layer(room_width/2, 176+48*2+hb, "lay_instances", obj_button);
button.image_index = 4;
button.action = "options";
ds_list_add(buttons, button);
var button = instance_create_layer(room_width/2, room_height-64, "lay_instances", obj_button);
button.image_index = 1;
button.action = "quit";
ds_list_add(buttons, button);
