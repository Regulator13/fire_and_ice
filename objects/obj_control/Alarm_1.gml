/// @description end level

//add scores
//iterate through teams
for (var i = 0; i < obj_menu.teamMax; i++){
    var team = ds_map_find_value(obj_menu.gameTeams, i);
    if !(is_undefined(team)) {
        team.tScore += team.LVL*global.scoreLVL;
        }
    }

scr_stateSwitch(STATE_GAME, STATE_SCORE);

