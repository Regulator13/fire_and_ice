/// @description end level

//add scores
//iterate through teams
for (var i = 0; i < obj_menu.teamMax; i++){
    var Team = ds_map_find_value(obj_menu.gameTeams, i);
    if !(is_undefined(Team)) {
        Team.tScore += Team.LVL*global.score_level;
        }
    }

//switch to score menu
scr_stateSwitch(STATE_GAME, STATE_SCORE);

