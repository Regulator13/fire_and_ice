/// @description Drop all local players
var amount = ds_map_size(local_players);
var key = ds_map_find_first(local_players);
    
// iterate through each local player
for (i = 0; i < amount; i++;) {
    // get the local player
    var Local = local_players[? key];
        
    // drop player
    show_debug_message(" + " +string(Local.connectID));
    scr_joinLobby(Local);
	
    // destroy player object
    instance_destroy(Local);
        
    // get the next key
    key = ds_map_find_next(local_players, key);
}
    
// clear map
ds_map_clear(local_players);
