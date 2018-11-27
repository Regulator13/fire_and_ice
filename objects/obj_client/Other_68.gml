/// @description networking code
var eventid = ds_map_find_value(async_load, "id");
socketIn = eventid; // the socket id coming from the server
serverIP = ds_map_find_value(async_load, "ip");

//show_debug_message(string(eventid));
//is this message for our socket?
if(client == eventid) {
    // if in a state that needs a confirmation
    if (global.NetworkState == NETWORK_CONNECT or global.NetworkState == NETWORK_LOGIN) {
        // read buffer data
        var buffer = ds_map_find_value(async_load, "buffer");
        
        // find start since the connection is UDP and not sorted out for us
        buffer_seek(buffer, buffer_seek_start,0);
        
        // read msgId, confirmation message, or game message
        var msgId = buffer_read(buffer, buffer_s8);
        
        // set msgIDin for debug purposes
        msgIDin = msgId;
        
        // read sequence
        var sequence = buffer_read(buffer, buffer_u8);
        
        // if more recent message, check
        if (scr_sequence_more_recent(sequence, sequenceIn, SEQUENCE_MAX)) { //this package is newer and therefore requires an update, 65,535 is for buffer_u16
            // update sequenceIn
            sequenceIn = sequence;
            
            // update disconnect buffer
            alarm[0] = disconnectBuffer;
            
            // check if server is confirming a connection
            if (global.NetworkState == NETWORK_CONNECT and msgId == SERVER_CONNECT) {
                // connection confirmed! move to login state
                global.NetworkState = NETWORK_LOGIN;
                }
            // check if server is confirming a login
            if (global.NetworkState == NETWORK_LOGIN and msgId == SERVER_LOGIN) {
                // connection confirmed! move to login state
                global.NetworkState = NETWORK_PLAY;
                }
            // game check is handled later
            }
        }
    }
//show_debug_message(string("next"));

///game networking code
    var eventid = ds_map_find_value(async_load, "id");
    
    //is this message for our socket?
    if(client == eventid) {
        if (global.NetworkState = NETWORK_PLAY) {
            //read all data....
            var buff = ds_map_find_value(async_load, "buffer");
            
            //find start since the connection is UDP and not sorted out for us
            buffer_seek(buff, buffer_seek_start, 0);
            
            //read msgId, needed so server can ignore it's own commands
            var msgId = buffer_read(buff, buffer_s8);
            // update debug
            msgIDin = msgId;
            
            if (msgId == SERVER_PLAY) { //server message, low priority
                //read sequence
                var sequence = buffer_read(buff, buffer_u8);
                if (scr_sequence_more_recent(sequence, sequenceIn, SEQUENCE_MAX)) { //this package is newer and therefore requires an update, 65,535 is for buffer_u16
                    //update sequenceIn
                    sequenceIn = sequence;
                    
                    // update disconnect buffer
                    alarm[0] = disconnectBuffer;
                    
                    //get state
                    var state = buffer_read(buff, buffer_u8);
                    switch(state) {
                        case STATE_LOBBY: // lobby
                            // lobby updates
                            
                            // get the amount of players
                            var players = buffer_read(buff,buffer_u8);
                            // temporarily hold server data, local because it will be called a lot of times
                            server_data = ds_list_create();
                            // read the data
                            for(var i=0;i<players;i++){
                                ds_list_add(server_data, buffer_read(buff,buffer_u8));       // team
                                ds_list_add(server_data, buffer_read(buff,buffer_bool));     // ready
                                ds_list_add(server_data, buffer_read(buff,buffer_string));   // name
                                ds_list_add(server_data, buffer_read(buff,buffer_string));   // character
                                }
                            // copy loaded data to menu
                            ds_list_copy(global.Menu.server_data, server_data);
                            // delete temporary list
                            ds_list_destroy(server_data);
                            break;
                        case STATE_PATHS: // paths menu
                            // path updates
                            if (global.Menu.state == STATE_PATHS) {
                                // get the amount of paths
                                var paths = buffer_read(buff, buffer_u8);
                                
                                // temporarily hold server data, local because it will be called a lot of times
                                server_data = ds_list_create();
                                ds_list_add(server_data, buffer_read(buff,buffer_u8));   // selected path
                                // read the data
                                for(var i = 0; i < paths; i++){
                                    ds_list_add(server_data, buffer_read(buff,buffer_string));   // name
                                    ds_list_add(server_data, buffer_read(buff,buffer_string));   // score
                                    ds_list_add(server_data, buffer_read(buff,buffer_string));   // length
                                    }
                                // copy loaded data to menu
                                ds_list_copy(global.Menu.server_data, server_data);
                                // delete temporary list
                                ds_list_destroy(server_data);
                                }
                            else {
                                // switch to path menu
                                with (global.Menu) event_user(1);
                                }
                            break;
                        case STATE_GAME:
                            // game updates
                            if (global.Menu.state == STATE_GAME and room == rm_level) {
                                // hold space for specific camera x and y
                                var cameraX = buffer_read(buff, buffer_s16);
                                var cameraY = buffer_read(buff, buffer_s16);
                                if (cameraX != -1 and cameraY != -1) {
                                    obj_camera.x = cameraX;
                                    obj_camera.y = cameraY;
                                    }
                                
                                // send water height
                                water_height = buffer_read(buff, buffer_u16);
                                
                                // get the amount of teams
                                var teams = buffer_read(buff, buffer_u8);
                                
                                // temporarily hold server data, local because it will be called a lot of times
                                server_data = ds_list_create();
                                
                                ds_list_add(server_data, teams); // add the amount of teams
                                
                                // read the team data
                                for(var i = 0; i < teams; i++){
                                    var  exists = buffer_read(buff, buffer_bool); // whether the team exists
                                    ds_list_add(server_data, exists); // add whether the teams exists
                                    
                                    if (exists) {
                                        var players = buffer_read(buff, buffer_u8); // amount of players on team
                                        ds_list_add(server_data, players); // add amount of players for the team
                                        
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team name
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team score
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team level
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team lives
                                        
                                        for (cp = 0; cp < players; cp++) {
                                            ds_list_add(server_data, buffer_read(buff, buffer_s16)); // get player sprite
                                            
                                            var characterExists = buffer_read(buff, buffer_bool); // check if player alive
                                            ds_list_add(server_data, characterExists);   // if character is alive
                                            if (characterExists) {
                                                ds_list_add(server_data, buffer_read(buff, buffer_u8));   // hp
                                                ds_list_add(server_data, buffer_read(buff, buffer_u8));   // energy
                                                }
                                            }
                                        }
                                    }
                                
                                // copy loaded data to menu
                                ds_list_copy(global.Menu.server_data, server_data);
                                
                                //for (i = 0; i < ds_list_size(server_data); i++) show_debug_message(string(ds_list_find_value(server_data, i)));
                                
                                // delete temporary list
                                ds_list_destroy(server_data);
                                
                                // gather sprite information
                                
                                // add all basic sprites to send into a list
                                ds_list_clear(basicSprites);
                                ds_list_clear(basicImages);
                                ds_list_clear(basicXs);
                                ds_list_clear(basicYs);
                                
                                // add all characters to send into a list
                                ds_list_clear(characterSprites);
                                ds_list_clear(characterImages);
                                ds_list_clear(characterXs);
                                ds_list_clear(characterYs);
                                ds_list_clear(characterHPs);
                                ds_list_clear(characterEnergys);
                                ds_list_clear(characterNames);
                                
                                // send sprite information
                                var basicSpritesSize = buffer_read(buff, buffer_u16); //buffer_u16 MAX: ?
                                var characterSpritesSize = buffer_read(buff, buffer_u8); //buffer_u8 MAX: 255
                                
                                // send all basic sprites
                                for (i = 0; i < basicSpritesSize; i++) {
                                    ds_list_add(basicSprites, buffer_read(buff, buffer_s16));   // sprite
                                    ds_list_add(basicImages, buffer_read(buff, buffer_s8));     // image index
                                    ds_list_add(basicXs, buffer_read(buff, buffer_s16));        // X
                                    ds_list_add(basicYs, buffer_read(buff, buffer_s16));        // Y
                                    }
                                
                                // send all character sprites
                                for (i = 0; i < characterSpritesSize; i++) {
                                    ds_list_add(characterSprites, buffer_read(buff, buffer_s16));   // sprite
                                    ds_list_add(characterImages, buffer_read(buff, buffer_s8));     // image index
                                    ds_list_add(characterXs, buffer_read(buff, buffer_s16));        // X
                                    ds_list_add(characterYs, buffer_read(buff, buffer_s16));        // Y
                                    ds_list_add(characterHPs, buffer_read(buff, buffer_u8));        // hp
                                    ds_list_add(characterEnergys, buffer_read(buff, buffer_u8));    // energy
                                    ds_list_add(characterNames, buffer_read(buff, buffer_string));  // name
                                    }
                                
                                /*
                                show_debug_message("size" + string(basicSpritesSize) + " " + string(characterSpritesSize));
                                for (i = 0; i < ds_list_size(basicSprites); i++) {
                                    show_debug_message("sprite:" + string(ds_list_find_value(basicSprites, i)));
                                    show_debug_message("image:" + string(ds_list_find_value(basicImages, i)));
                                    show_debug_message("x    : " + string(ds_list_find_value(basicXs, i)));
                                    show_debug_message("y    : " + string(ds_list_find_value(basicYs, i)));
                                    }
                                for (i = 0; i < ds_list_size(characterSprites); i++) {
                                    show_debug_message("sprite:" + string(ds_list_find_value(characterSprites, i)));
                                    show_debug_message("image:" + string(ds_list_find_value(characterImages, i)));
                                    show_debug_message("x    : " + string(ds_list_find_value(characterXs, i)));
                                    show_debug_message("y    : " + string(ds_list_find_value(characterYs, i)));
                                    }
                                */
                                }
                            else if (global.Menu.state == STATE_PATHS) {
                                // switch to game menu
                                with (global.Menu) event_user(2);
                                }
                            else if (global.Menu.state == STATE_SCORE) {
                                // switch to game menu
                                scr_state_switch(STATE_SCORE, STATE_GAME);
                                }
                            break;
                        case STATE_SCORE: // score screen
                            // score screen updates
                            if (global.Menu.state = STATE_SCORE) {
                                // temporarily hold server data, local because it will be called a lot of times
                                server_data = ds_list_create();
                                
                                ds_list_add(server_data, buffer_read(buff, buffer_string)); // add the message
                                ds_list_add(server_data, buffer_read(buff, buffer_string)); // add the seed
                                ds_list_add(server_data, buffer_read(buff, buffer_string)); // add the water delay
                                
                                // get the amount of teams
                                var teams = buffer_read(buff, buffer_u8);
                                
                                ds_list_add(server_data, teams); // add the amount of teams
                                
                                // read the team data
                                for(var i = 0; i < teams; i++){
                                    var  exists = buffer_read(buff, buffer_bool); // whether the team exists
                                    ds_list_add(server_data, exists); // add whether the teams exists
                                    
                                    if (exists) {
                                        var players = buffer_read(buff, buffer_u8); // amount of players on team
                                        ds_list_add(server_data, players); // add amount of players for the team
                                        
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team name
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team score
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team level
                                        ds_list_add(server_data, buffer_read(buff, buffer_string)); // get team lives
                                        
                                        for (cp = 0; cp < players; cp++) {
                                            ds_list_add(server_data, buffer_read(buff, buffer_s16)); // get player sprite
                                            
                                            var characterExists = buffer_read(buff, buffer_bool); // check if player alive
                                            ds_list_add(server_data, characterExists);   // if character is alive
                                            if (characterExists) {
                                                ds_list_add(server_data, buffer_read(buff, buffer_u8));   // hp
                                                ds_list_add(server_data, buffer_read(buff, buffer_u8));   // energy
                                                }
                                            }
                                        }
                                    }
                                
                                // copy loaded data to menu
                                ds_list_copy(global.Menu.server_data, server_data);
                                
                                // delete temporary list
                                ds_list_destroy(server_data);
                                }
                            else {
                                scr_state_switch(STATE_GAME, STATE_SCORE);
                                }
                            break;
                        }
                    }
                }
            }
        }

/* */
/*  */
