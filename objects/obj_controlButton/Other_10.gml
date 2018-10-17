/// @description press button

// create input box
var button = instance_create(room_width/2, room_height/2, obj_inputControl);
button.control = key;
button.controller = global.controls[global.Menu.controlSelected, KEY_TYPE];
button.player = global.Menu.controlSelected;
button.Source = self;

