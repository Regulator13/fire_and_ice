/// @description  return to main

// go offline
global.online = false;

// destroy broadcast
network_destroy(broadcast_server);

// clear buttons
with (global.Menu) {
    for (var i = 0; i < ds_list_size(buttons); i++) {
        with(ds_list_find_value(buttons, i)) instance_destroy();
        }
    ds_list_clear(buttons);
    }
// destory word boxes
instance_destroy(directIP);
instance_destroy(iServerName);

// destroy ds_lists
ds_list_destroy(serverlist);
ds_list_destroy(servernames);

// destroy self
instance_destroy();

