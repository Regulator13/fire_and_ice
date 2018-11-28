/// @description Save path if in game
//game has been started
if !(global.gameStart) {
    //set length
    ds_map_replace(global.path, "length", ds_list_size(ds_map_find_value(global.path, "seeds")));
    
    //find high score
    highScore = 0;
	
    //iterate through teams
    for (var i = 0; i < team_max; i++){
        var Team = ds_map_find_value(game_teams, i);
        if !(is_undefined(Team)) {
            var newScore = Team.tScore;
            if (newScore > highScore) {
                highScore = newScore;
            }
        }
    }
	
    //set high score
    ds_map_replace(global.path, "score", highScore);
    
	//save ALL paths
    scr_save_path();
}
