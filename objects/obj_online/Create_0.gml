/// @description  setup to connect online
global.Server = -1; // -1 client does not have server
global.connectip = "127.0.0.1";
global.InitObject = id;
global.have_server = false;
global.ServerType = network_socket_udp;

serverlist = ds_list_create();
servernames = ds_list_create();

// Create a server and listen on our broadcast port....
broadcast_server = network_create_server(network_socket_udp, 6511, 100);
// set up menu
directIP = instance_create_layer(154+32+64, room_height-32, "lay_instances", obj_text_box);
iServerName = instance_create_layer(room_width-(200+154+32+64), room_height-32, "lay_instances", obj_text_box);
iServerName.title = "Player Name";
iServerName.text = "Newbius";

// try to load player name
scr_load_player();

// set menu to treat game as online
global.online = true;

