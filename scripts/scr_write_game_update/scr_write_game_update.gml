/*
/ Description: updates the buffer with client specific data
/ Script Call: scr_write_game_update(ip, index)
/ Parameters : ip - given, ip is already found to see if client is ready for game info
/              index - index of the client in the parallel arrays
/ Return     : void
*/

// set input
var ip = argument0;
var index = argument1;

// write lobby data into new buffer
    // store server buffer in local variable because it will be called alot
    var buff = gameBuffer;
    
    // get the player's instance, so we can send only relevant data
    var inst = ds_map_find_value(Clients, ip)
    var character = inst.gameCharacter; // get the player's character
    
    // fill in camera position
    buffer_seek(buff, buffer_seek_start, 3);
    if (instance_exists(character)) {
        buffer_write(buff, buffer_s16, character.x);
        buffer_write(buff, buffer_s16, character.y);
        }
    else {
        buffer_write(buff, buffer_s16, -1);
        buffer_write(buff, buffer_s16, -1);
        }
    buffer_seek(buff, buffer_seek_end, 0);
