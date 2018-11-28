/// @description  Server network control

//find buffer
var buff = ds_map_find_value(async_load, "buffer");
//find start since the connection is UDP and not sorted out for us
buffer_seek(buff, buffer_seek_start, 0);

//read message id
var msgId = buffer_read(buff, buffer_s8);

switch (msgId) {
    case CLIENT_CONNECT:
        // client connecting
        scr_connect_client();
        break;
    case CLIENT_LOGIN:
        // client logging in
        scr_login_client();
        break;
    case CLIENT_PLAY:
        //all other sockets are connected client sockets, and we have recieved commands from them.
        scr_server_received_data();
        break;
    }

