/*scr_sendkey()
* Send a key "event" to the server
* arg0 = key
* arg1 = down=0, up=1
*/
var key = argument0;
var updown = argument1;
//start
    {
    // Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
    buffer_seek(buff, buffer_seek_start, 0);

    //write msgId -1 - disconnect, 0 - game, 1 - connect
    buffer_write(buff, buffer_s8, 0 );
    // Write the command, the key and the UP/DOWN state into the buffer
    buffer_write(buff, buffer_u8, KEY_CMD );
    buffer_write(buff, buffer_s16, key );
    buffer_write(buff, buffer_u8, updown );

    // Send this to the server
    network_send_udp(client,ip,port,buff,buffer_tell(buff));
    }
