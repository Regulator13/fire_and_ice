/// @description scr_join_lobby(client)
/// @param client
/*
/ Description: joins a client into the lobby
/ Parameters : client - id of the client's obj_network_player on the server
/ Return     : void
*/

with (global.Menu) {
    // set input
    var connectID = argument0.connectID;
    var name = argument0.name;
    show_debug_message(string(connectID));

    var index = ds_list_find_index(players, connectID)
    if (index >= 0) {
        ds_list_delete(players, index);
        ds_list_delete(teams, index);
        ds_list_delete(classes, index);
        ds_list_delete(names, index);
        ds_list_delete(local_controls, index); // local only
        ds_list_delete(readys, index);
        }
    else {
        ds_list_add(players, connectID);
        ds_list_add(teams, 0);
        ds_list_add(classes, ds_list_find_value(class_options, 0));
        ds_list_add(names, name);
        ds_list_add(local_controls, 0); // local only, set after joining
        ds_list_add(readys, false);
        }
    }
