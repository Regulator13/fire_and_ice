/*
/ Description: writes the lobby data into a buffer
/ Script Call: scr_write_lobby()
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
    buffer_write(buff, buffer_u8, STATE_LOBBY);
    
    //total number of players
    buffer_write(buff, buffer_u8, ds_list_size(global.Menu.players)); //buffer_u8 MAX: 255
    
    //send player information in order
    with(global.Menu) {
        for (var i = 0; i < ds_list_size(players); i ++) {
            buffer_write(buff, buffer_u8, ds_list_find_value(teams, i)); // team
            buffer_write(buff, buffer_bool, ds_list_find_value(readys, i)); // ready
            buffer_write(buff, buffer_string, ds_list_find_value(names, i)); // name
            buffer_write(buff, buffer_string, ds_list_find_value(classes, i)); // character
            }
        }
