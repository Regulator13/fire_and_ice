/// @description  Create server and initialise map
global.counter = 0;
image_blend = c_red;
global.have_server = true;

//counters
global.serverEntitySprites = 0;
global.player_total = 0;


// create our server. Server creation may fail if there is already a server running. If it does fail, delete eveything and kill this instance
var alignment = 1;
broadcast_buffer = buffer_create(32, buffer_fixed, alignment);
gameBuffer = buffer_create(32, buffer_grow, alignment);//buffer_create(16384, buffer_fixed, alignment);
Clients = ds_map_create();
iplist = ds_list_create();
portlist = ds_list_create();
sequenceOuts = ds_list_create();
sequenceOutQueues = ds_list_create();

// clientMessages - messages to the client, connection, login, game
clientMessages = ds_map_create();
// clientBuffer - buffer for small client messages
confirmBuffer = buffer_create(24, buffer_fixed, alignment);

// Try and create the actual server
server = network_create_server(global.ServerType, 6510, 32 );
if( server<0 ){    
    // If theres already a server running, shut down and delete.
    instance_destroy();
}

// Setup a timer so we can broadcast the server IP out to local clients looking...
alarm[0]=60;

//create menu
alarm[1] = 1;

// NOW DONE INDIVIDUALLY
/*
//realiabilty, ordering, and congestion avoidance for UDP
sequenceOut = 0; // stores latest packet sequence that the server has sent out
sequenceOutMax = SEQUENCE_MAX; //65,535 is the max for buffer_u16
sequenceOutQueue = ds_map_create();
*/

//startBuffer - small buffer to allow first client to connect
startBuffer = 30;
sendBuffer = 0;

// serverDebug - whether or not to draw server debug information
serverDebug = false;

/* */
/// player colours
// List of random player colours....
ColourArray[0] = c_white;
ColourArray[1] = c_red;
ColourArray[2] = c_blue;
ColourArray[3] = c_yellow;
ColourArray[4] = c_green;
ColourArray[5] = c_purple;
ColourArray[6] = c_aqua;
ColourArray[7] = c_maroon;
ColourArray[8] = c_orange;
ColourArray[9] = c_teal;
ColourArray[10] = c_olive;
ColourArray[11] = c_ltgray;
ColourArray[12] = c_dkgray;
ColourArray[13] = c_navy;
ColourArray[14] = $ff8080;
ColourArray[15] = $80ff80;
colourindex = 0;


/* */
/*  */
