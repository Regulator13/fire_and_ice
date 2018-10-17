/// @description  drop all local players
    var amount = ds_map_size(localPlayers);
    var key = ds_map_find_first(localPlayers);
    
    // iterate through each local player
    for (i = 0; i < amount; i++;) {
        // get the local player
        var Local = localPlayers[? key];
        
        // drop player
        show_debug_message(" + " +string(Local.connectID));
        scr_joinLobby(Local);
        // destroy player object
        instance_destroy(Local);
        
        // get the next key
        key = ds_map_find_next(localPlayers, key);
        }
    
    // clear map
    ds_map_clear(localPlayers);

