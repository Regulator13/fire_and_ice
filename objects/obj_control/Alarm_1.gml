/// @description End level
///Add scores
//iterate through teams
for (var i=0; i<obj_menu.team_max; i++){
    var Team = ds_map_find_value(obj_menu.game_teams, i);
	
    if !(is_undefined(Team)) {
        Team.tScore += Team.LVL*global.score_level;
    }
}

//switch to score menu
scr_state_switch(STATE_GAME, STATE_SCORE);
