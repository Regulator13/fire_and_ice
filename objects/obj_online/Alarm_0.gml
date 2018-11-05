/// @description  Start game - connect to a remote server
var i = iServerName;
global.ServerName = i.text;

// destroy broadcast server
network_destroy(broadcast_server);
broadcast_server = -1;

show_debug_message("#######################################");
show_debug_message("Next room");
show_debug_message("#######################################");
    // switch menu to the lobby
    scr_stateSwitch(STATE_ONLINE, STATE_LOBBY);
    // create  client
    instance_create_layer(0, 0, "lay_instances", obj_client);
    // client takes care of all networking now
    instance_destroy();

