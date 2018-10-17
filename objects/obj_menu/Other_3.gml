/// @description save path if in game
if !(global.gameStart) { //game has been started
    //set length
    ds_map_replace(global.path, "length", ds_list_size(ds_map_find_value(global.path, "seeds")));
    
    //find high score
    highScore = 0;
    //iterate through teams
    for (var i = 0; i < teamMax; i++){
        var team = ds_map_find_value(gameTeams, i);
        if !(is_undefined(team)) {
            var newScore = team.tScore;
            if (newScore > highScore) {
                highScore = newScore;
                }
            }
        }
    //set high score
    ds_map_replace(global.path, "score", highScore);
    
    scr_savePath(); //save ALL paths
    }

