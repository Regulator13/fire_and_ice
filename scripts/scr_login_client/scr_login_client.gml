/*scr_connect_client
* called upon a connect or disconnect of a client
* argument0 - msgId
*/

//start
    {
    // get the buffer the data resides in
    var buff = ds_map_find_value(async_load, "buffer");
    
    // get the IP that the socket comes from
    var ip = ds_map_find_value(async_load, "ip");
    
    // look up the client object
    var inst = ds_map_find_value(Clients, ip);
    
    // Set the client "name"
    inst.name = buffer_read(buff, buffer_string);
    
    // update name in lobby
    var playerIndex = inst.connectID;
    scr_update_name(playerIndex, inst.name);
    
    // client message, confirm login
    ds_map_replace(clientMessages, ip, SERVER_LOGIN);  
    }

