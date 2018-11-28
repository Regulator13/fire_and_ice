/*
/ Description: writes the score data into a buffer
/ Script Call: scr_write_score()
/ Parameters : none
/ Return     : void
*/

// set input

// write lobby data into new buffer
    //store server buffer in local variable because it will be called alot
    var buff = gameBuffer;
    
    //reset buffer to start - Networking ALWAYS reads from the START of the buffer
    buffer_seek(buff, buffer_seek_start, 0);
    
    //write msgId, SERVER_PLAY because client has already logged on
    buffer_write(buff, buffer_s8, SERVER_PLAY);
    
    //write packet sequence
    buffer_write(buff, buffer_u8, 0);//sequenceOut); Written in send buffer
    
    //state
    buffer_write(buff, buffer_u8, STATE_SCORE);
    
    // message
    var message;
    if (global.continue_game) message = "continue!";
    else message = "restart!";
    
    buffer_write(buff, buffer_string, message); // message
    buffer_write(buff, buffer_string, string(random_get_seed())); // seed
    buffer_write(buff, buffer_string, string(global.water_delay)); // water delay
    
    //total number of teams
    buffer_write(buff, buffer_u8, global.Menu.team_max); //buffer_u8 MAX: 255
    
    // delocalize the write buffer
    buffer = buff;
    // send team information in order
    with(global.Menu) {
        buff = other.buffer;
        // iterate through each team
        for (var i = 0; i < team_max; i++){
            var Team = ds_map_find_value(game_teams, i);
            if !(is_undefined(Team)) {
                buffer_write(buff, buffer_bool, true); // team exists
                
                // amount of players
                var size = ds_list_size(Team.players);
                buffer_write(buff, buffer_u8, size); // amount of players
                
                buffer_write(buff, buffer_string, Team.nickname); // team name
                buffer_write(buff, buffer_string, string(round(Team.tScore))); // team score
                buffer_write(buff, buffer_string, string(round(Team.LVL))); // team top level
                buffer_write(buff, buffer_string, string(round(Team.tLives))); // team lives
                
                // players
                for (cp = 0; cp < size; cp++) {
                    //player
                    var player = ds_list_find_value(Team.players, cp); 
                    
                    buffer_write(buff, buffer_s16, player.sprite_index); // player character
                    
                    var characterExists = instance_exists(player.gameCharacter); // check if player alive
                    buffer_write(buff, buffer_bool, characterExists); // character exists
                    if (characterExists) {
                        buffer_write(buff, buffer_u8, player.gameCharacter.hp); // player hp
                        buffer_write(buff, buffer_u8, player.gameCharacter.energy); // player energy
                        }
                    }
                }
            else buffer_write(buff, buffer_bool, false); // team does not exists
            }
        other.buffer = buff;
        }
    buff = buffer;
