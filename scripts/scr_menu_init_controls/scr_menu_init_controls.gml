/// @description change to controls menu

// setup controls menu

// add buttons
var button = instance_create_layer(room_width/2, room_height-32-48*2, "lay_instances", obj_button);
button.action = "valueAction";
button.valueAction = "changeControlsPlayer";
button.title = "Player:";
for (var i = 0; i < global.Menu.controlsMax; i++;)
    ds_list_add(button.values, "Player " + string(i+1));
button.value = controlSelected;
ds_list_add(buttons, button);

scr_create_button(room_width/2, room_height-32-48*1, "delControls", "reset", false)
scr_create_button(room_width/2, room_height-32, "back", "options", false)

// device
var button = instance_create_layer(room_width/2, 32, "lay_instances", obj_button);
button.action = "valueAction";
button.valueAction = "changeControlsController";
button.title = "Device:";
ds_list_add(button.values, "Joystick 1", "Joystick 2", "Joystick 3", "Joystick 4", "Joystick 5", "Keyboard", "Keyboard+Mouse");
button.value = global.controls[controlSelected, KEY_TYPE];
ds_list_add(buttons, button);

// setup columns
var c1x = room_width/4;
var c2x = c1x*3;
var cy = 200;
var c1y = 0;
var c2y = 0;
var by = 64;

var controller = global.controls[controlSelected, KEY_TYPE]
switch (controller) {
    case CONTROLS_KEYBOARD:
        var c1 = 4;
        var c2 = 4;
        // first column of input
        for (c1y = 0; c1y < c1; c1y++) {
            var button = instance_create_layer(c1x, cy+by*c1y, "lay_instances", obj_control_button);
            button.key = c1y;
            button.title = scr_get_input_name(global.controls[controlSelected, c1y], button.key, controller);
            ds_list_add(buttons, button);
            }
        // secound column of input
        for (c2y = 0; c2y < 4; c2y++) {
            var button = instance_create_layer(c2x, cy+by*c2y, "lay_instances", obj_control_button);
            button.key = c2y+c2;
            button.title = scr_get_input_name(global.controls[controlSelected, c2y+c2], button.key, controller);
            ds_list_add(buttons, button);
            }
        break;
    case CONTROLS_MOUSE:
        var c1 = 2;
        var c2 = 4;
        // first column of input
        for (c1y = 0; c1y < c1; c1y++) {
            var button = instance_create_layer(c1x, cy+by*c1y, "lay_instances", obj_control_button);
            button.key = c1y;
            button.title = scr_get_input_name(global.controls[controlSelected, c1y], button.key, controller);
            ds_list_add(buttons, button);
            }
        // secound column of input
        for (c2y = 0; c2y < 4; c2y++) {
            var button = instance_create_layer(c2x, cy+by*c2y, "lay_instances", obj_control_button);
            button.key = c2y+c2;
            button.title = scr_get_input_name(global.controls[controlSelected, c2y+c2], button.key, controller);
            ds_list_add(buttons, button);
            }
        break;
    default:
        var c1 = 4;
        var c2 = 4;
        // first column of input
        for (c1y = 0; c1y < c1; c1y++) {
            var button = instance_create_layer(c1x, cy+by*c1y, "lay_instances", obj_control_button);
            button.key = c1y;
            button.title = scr_get_input_name(global.controls[controlSelected, c1y], button.key, controller);
            ds_list_add(buttons, button);
            }
        // secound column of input
        for (c2y = 0; c2y < 4; c2y++) {
            var button = instance_create_layer(c2x, cy+by*c2y, "lay_instances", obj_control_button);
            button.key = c2y+c2;
            button.title = scr_get_input_name(global.controls[controlSelected, c2y+c2], button.key, controller);
            ds_list_add(buttons, button);
            }
        break;
    }


