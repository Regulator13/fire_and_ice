/// @description Restart
//restart game
var restartGame = true;

//unless player's still has lives
for (var i = 0; i < obj_menu.teamMax; i++){
    var Team = ds_map_find_value(obj_menu.gameTeams, i);
    if !(is_undefined(Team)) {
        if (Team.tLives > 0) {
            restartGame = false;
        }
    }
}

if (restartGame) game_restart();

//otherwise reset the player's scores
else {
    if (global.continueGame) scr_stateSwitch(STATE_SCORE, STATE_GAME);
        else {
            for (i = 0; i < global.player_total; i += 1) {
                global.playerScore[i] = 0;
            }
			
            scr_stateSwitch(STATE_SCORE, STATE_GAME);
        }
}
