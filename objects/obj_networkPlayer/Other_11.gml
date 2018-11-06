/// @description  drop player if ping is not keeping him alive

//also delete the socket from our global list of connected clients
with (obj_server) {
    // delete refrence in clients list
    ds_map_delete(Clients, other.ip);
    ds_map_delete(clientMessages, other.ip);
    
    // find index in parallel arrays using client ip
    var index = ds_list_find_index(iplist, other.ip);
    ds_list_delete(iplist, index);
    ds_list_delete(portlist, index);
    
    // delete sequences
    ds_list_delete(sequenceOuts, index);
    ds_map_destroy(sequenceOutQueues[| index]);
    ds_list_delete(sequenceOutQueues, index);
    }

// check if in lobby
var state = global.Menu.state;
if (state == STATE_LOBBY) {
    // leave the client into the lobby
    with (global.Menu) scr_joinLobby(other);
    }

if (state == STATE_GAME) {
    // delete character
    if (instance_exists(gameCharacter))
        instance_destroy(gameCharacter);
    }
    
if (state == STATE_GAME || state == STATE_SCORE) {
    // remove from team
    var index = ds_list_find_index(Team.players, self);
    ds_list_delete(Team.players, index);
    // delete team if last player
    if (ds_list_empty(Team.players)) {
        ds_map_delete(global.Menu.gameTeams, Team);
        instance_destroy(Team);
        }
    }

// destory self
instance_destroy();

