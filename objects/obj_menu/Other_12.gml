/// @description Attempt to set path
if (!global.online or (global.online and global.have_server)) {
    //set path
    global.path = ds_map_find_value(paths, ds_list_find_value(path_names, path_selected));
}
/*
// debug
for (i = 0; i < ds_list_size(global.path[? "seeds"]); i++;) {
    show_debug_message(string(ds_list_find_value(global.path[? "seeds"], i)));
    }
*/

///change to game menu
state = STATE_GAME;

//clear buttons
for (var i = 0; i < ds_list_size(buttons); i++) {
    with(ds_list_find_value(buttons, i)){
		instance_destroy();
	}
}
ds_list_clear(buttons);

///Create players
if (!global.online) {
    //set variables
    var amount = ds_map_size(local_players);
    var key = ds_map_find_first(local_players);
    
    // iterate through each local player
    for (i = 0; i < amount; i++;) {
        // get the local player
        var Local = local_players[? key];
		
        // setup up player object
        Local.player_id = ds_list_find_index(players, Local.connectID);
        Local.input = 1; //ds_list_find_value(players, connectID);
        Local.Team = ds_list_find_value(teams, Local.player_id); //temporary
        Local.character = ds_list_find_value(classes, Local.player_id);
        Local.sprite_index = scr_getSprite(Local.character);
		
        //Team
        var Team = ds_map_find_value(gameTeams, Local.Team);
        if (is_undefined(Team)) {
            Team = instance_create_layer(0, 0, "lay_instances", obj_team)
            Team.Team = Local.Team;
            Team.nickname = "Team " + string(Team.Team);
            ds_map_add(gameTeams, Local.Team, Team);
        }
		
        //add player to team
        ds_list_add(Team.players, Local);
        Local.Team = Team;
		
        // get the next key
        key = ds_map_find_next(local_players, key);
    }
}
///DESCR?
else if (global.have_server) {
    room_goto(rm_level);
    with(obj_server) {
        var count = ds_list_size(iplist);
        for(i = 0; i < count; i++){   
            //get the ip
            var ip = ds_list_find_value(iplist,i);
            //get the player instance so that we can check if it is ready
            player = ds_map_find_value(Clients, ip);
            
            // setup up player object
            player.player_id = ds_list_find_index(other.players, player.connectID);
            player.input = -1; //ds_list_find_value(players, connectID);
            player.Team = ds_list_find_value(other.teams, player.player_id); //temporary
            player.character = ds_list_find_value(other.classes, player.player_id);
            player.sprite_index = scr_getSprite(player.character);
			
            //team
            var Team = ds_map_find_value(other.gameTeams, player.Team);
            if (is_undefined(Team)) {
                Team = instance_create_layer(0, 0, "lay_instances", obj_team)
                Team.Team = player.Team;
                Team.nickname = "Team " + string(Team.Team);
                ds_map_add(other.gameTeams, player.Team, Team);
            }
			
            //add player to Team
            with (Team) ds_list_add(players, other.player);
            player.Team = Team;
        }
    }
} 

//goto room
room_goto(rm_level);

networkPlayer = noone; //networkPlayer object, if online
