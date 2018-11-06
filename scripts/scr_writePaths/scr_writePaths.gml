/*
/ Description: writes the path data into a buffer
/ Script Call: scr_writePaths()
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
    buffer_write(buff, buffer_u8, STATE_PATHS);
    
    // total number of paths
    buffer_write(buff, buffer_u8, ds_list_size(global.Menu.path_names)); //buffer_u8 MAX: 255
    
    // selected path
    buffer_write(buff, buffer_u8, global.Menu.path_selected); //buffer_u8 MAX: 255
    
    // delocalize buffer
    buffer = buff;
    //send player information in order
    with(global.Menu) {
        var pathAmount = ds_list_size(path_names); // bring loop out of loop
        for (var i = 0; i < pathAmount; i ++) {
            buffer_write(other.buffer, buffer_string, ds_list_find_value(path_names, i)); // name
            path = ds_map_find_value(paths, name);
            buffer_write(other.buffer, buffer_string, string(round(ds_map_find_value(path, "score")))); // score
            buffer_write(other.buffer, buffer_string, string(ds_map_find_value(path, "length"))); // length
            }
        }
    // relocalize buffer
    buff = buffer;
