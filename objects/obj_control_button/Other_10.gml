/// @description Press button

//create input box
var button = instance_create_layer(room_width/2, room_height/2, "lay_instances", obj_input_control);
button.control = key;
button.controller = global.controls[global.Menu.controlSelected, KEY_TYPE];
button.player = global.Menu.controlSelected;
button.Source = self;
