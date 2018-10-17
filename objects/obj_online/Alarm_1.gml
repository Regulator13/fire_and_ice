/// @description  Start game - local client+server
var i = iServerName;
global.ServerName = i.text;

// create server
global.Server = instance_create(0,0,obj_server);

// check if succesful
if(global.haveserver == false ) {
    show_debug_message("Cant create server");
    }
else {
    // tell client to connect to itself
    global.connectip = "127.0.0.1";
    
    // stop broadcasting
    // destroy broadcast server
    network_destroy(broadcast_server);
    broadcast_server = -1;
    show_debug_message("#######################################");
    show_debug_message("Start game");
    show_debug_message("#######################################");
    
    // switch menu to the lobby
    scr_stateSwitch(STATE_ONLINE, STATE_LOBBY);
    
    // create client
    instance_create(0, 0, obj_client);
    // client takes care of all networking now
    instance_destroy();
    }

