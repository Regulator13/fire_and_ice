/// @description change to controls menu
state = STATE_ONLINE;

//clear buttons
for (var i = 0; i < ds_list_size(buttons); i++) {
    with(ds_list_find_value(buttons, i)) instance_destroy();
    }
ds_list_clear(buttons);

//reset selected
selected = 2; // start on host button

// temporarily freeze input
input_freeze = input_freezeMax;

// set room width and height manually, in case of changing from game
var rw = 1152;
var rh = 768;

// setup online menu
    // back
    var button = instance_create_layer(96, rh-32, "lay_instances", obj_button);
    button.action = "backMainOnline";
    button.title = "back";
    ds_list_add(buttons, button);
    // join
    var button = instance_create_layer(96+32+200+154+64*2, rh - 32, "lay_instances", obj_button);
    button.action = "directConnect";
    button.title = "join";
    ds_list_add(buttons, button);
    // host
    var button = instance_create_layer(rw - 96, rh - 32, "lay_instances", obj_button);
    button.action = "createServer";
    button.title = "host";
    ds_list_add(buttons, button);
    
    // create online object to handle everything
    instance_create_layer(0, 0, "lay_instances", obj_online);
