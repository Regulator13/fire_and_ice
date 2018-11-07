/*
/ Description: writes the game data into a buffer
/ Script Call: scr_writeGame()
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
    buffer_write(buff, buffer_u8, STATE_GAME);
    
    // hold space for specific camera x and y
    buffer_write(buff, buffer_s16, 0);
    buffer_write(buff, buffer_s16, 0);
    
    // send water height
    if (instance_exists(obj_control)) buffer_write(buff, buffer_u16, obj_control.water_height);
    else buffer_write(buff, buffer_u16, 0);
    
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
    
    // gather sprite information
    
    // add all basic sprites to send into a list
    basicSprites = ds_list_create();
    basicImages = ds_list_create();
    basicXs = ds_list_create();
    basicYs = ds_list_create();
    
    // iterate through all the basic objects to send over
    with (srv_basic) {
        ds_list_add(other.basicSprites, sprite_index);
        ds_list_add(other.basicImages, image_index);
        ds_list_add(other.basicXs, x);
        ds_list_add(other.basicYs, y);
        }
    
    // add all characters to send into a list
    characterSprites = ds_list_create();
    characterImages = ds_list_create();
    characterXs = ds_list_create();
    characterYs = ds_list_create();
    characterHPs = ds_list_create();
    characterEnergys = ds_list_create();
    characterNames = ds_list_create();
    
    // iterate through all the characters to send over
    with (obj_character) {
        ds_list_add(other.characterSprites, sprite_index);
        ds_list_add(other.characterImages, image_index);
        ds_list_add(other.characterXs, x);
        ds_list_add(other.characterYs, y);
        ds_list_add(other.characterHPs, hp);
        ds_list_add(other.characterEnergys, energy);
        ds_list_add(other.characterNames, player_name);
        }
    
    // add all the lasers to send into a list
    lasers = ds_list_create();
    
    // iterate through all the shpaes to send over
    with (obj_laser) {
        ds_list_add(other.lasers, x, y, laserX);
        }
    
    // send sprite information
    buffer_write(buff, buffer_u16, ds_list_size(basicSprites)); //buffer_u16 MAX: ?
    buffer_write(buff, buffer_u8, ds_list_size(characterSprites)); //buffer_u8 MAX: 255
    buffer_write(buff, buffer_u8, ds_list_size(lasers)); //buffer_u8 MAX: 255
    
    // send all basic sprites
    for (i = 0; i < ds_list_size(basicSprites); i++) {
        buffer_write(buff, buffer_s16, ds_list_find_value(basicSprites, i)); // sprite
        buffer_write(buff, buffer_s8, ds_list_find_value(basicImages, i)); // image index
        buffer_write(buff, buffer_s16, ds_list_find_value(basicXs, i)); // X
        buffer_write(buff, buffer_s16, ds_list_find_value(basicYs, i)); // Y
        }
    
    // send all character sprites
    for (i = 0; i < ds_list_size(characterSprites); i++) {
        buffer_write(buff, buffer_s16, ds_list_find_value(characterSprites, i)); // sprite
        buffer_write(buff, buffer_s8, ds_list_find_value(characterImages, i)); // image index
        buffer_write(buff, buffer_s16, ds_list_find_value(characterXs, i)); // X
        buffer_write(buff, buffer_s16, ds_list_find_value(characterYs, i)); // Y
        buffer_write(buff, buffer_u8, ds_list_find_value(characterHPs, i)); // hp
        buffer_write(buff, buffer_u8, ds_list_find_value(characterEnergys, i)); // energy
        buffer_write(buff, buffer_string, ds_list_find_value(characterNames, i)); // name
        }
    
    // send all basic sprites
    for (i = 0; i < ds_list_size(lasers); i+=3) {
        buffer_write(buff, buffer_s16, ds_list_find_value(lasers, i));   // x
        buffer_write(buff, buffer_s16, ds_list_find_value(lasers, i+1)); // y
        buffer_write(buff, buffer_s16, ds_list_find_value(lasers, i+2)); // laserX
        }
    
    // delete the lists
    ds_list_destroy(basicSprites);
    ds_list_destroy(basicImages);
    ds_list_destroy(basicXs);
    ds_list_destroy(basicYs);
    
    ds_list_destroy(characterSprites);
    ds_list_destroy(characterImages);
    ds_list_destroy(characterXs);
    ds_list_destroy(characterYs);
    ds_list_destroy(characterHPs);
    ds_list_destroy(characterEnergys);
    ds_list_destroy(characterNames);
    
    ds_list_destroy(lasers);
