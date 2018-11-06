/// @description restart
var restartGame = true; //restart game if no players left
//iterate through teams
for (var i = 0; i < obj_menu.teamMax; i++){
    var Team = ds_map_find_value(obj_menu.gameTeams, i);
    if !(is_undefined(Team)) {
        if (Team.tLives > 0) {
            restartGame = false;
            }
        }
    }
if (restartGame) game_restart();
else {
    if (global.continueGame) scr_stateSwitch(STATE_SCORE, STATE_GAME);
        else {
            //global.water_delay += 200;
            //if (global.water_rate < .1) global.water_rate += .05
            for (i = 0; i < global.player_total; i += 1) {
                global.playerScore[i] = 0;
                }
            scr_stateSwitch(STATE_SCORE, STATE_GAME);
            }
    }

