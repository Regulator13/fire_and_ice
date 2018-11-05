/// @description menu variables

// paused - whether game is paused
global.paused = false;

// state - current game state
state = STATE_MAIN;

//buttons - holds menu buttons
buttons = ds_list_create();

//selected - selected button
selected = 0;

//input_buffer - small buffer to slow down gamepad input
input_buffer = 0;
//input_buffer_max
input_buffer_max = 4;
//inputFreeze - small amount of time inbetween menu switches
inputFreeze = 0;
// inputFreezeMax
inputFreezeMax = 4;

// score message, either restart or continue, used with space key
scoreMessage = "";

//tagLine
tagLine = "Now with#exploding corpses!";
//version
version = "1.04.4";

///first menu
scr_menuInitMain();

///set player variables
players = ds_list_create();
nicknames = ds_list_create();
classes = ds_list_create();
// localControls - list holding which local players are in
localControls = ds_list_create();

// player_total - the total amount of current players
global.player_total = 0;

// localPlayers - hold all the local player input objects
localPlayers = ds_map_create();

///lobby menu
classOptions = ds_list_create(); //character list
ds_list_add(classOptions, "grinch", "yeti", "santa", "nutcracker", "reindeer");
teamMax = 10;
teams = ds_list_create();//used for selecting
gameTeams = ds_map_create();

names = ds_list_create();

// online
readys = ds_list_create();

///options menu

//load options
//open file
ini_open("options.ini");

//load data
section = string("default");
var str;

//gameMode
gameMode = ini_read_string(section, "gameMode", "Normal");

//nickNames
/*
str = ini_read_string(section, "nicknames", "");
if (str != "") ds_list_read(nicknameIdeas, str);
else nicknameIdeas = nicknamesDefault;
*/


//destroy default lists

//close file
ini_close(); 

/* */
///paths menu

//paths
pathNames = ds_list_create();
paths = ds_map_create();

pathSelected = 0;

/* */
///debug options menu

//load options
//open file
ini_open("options.ini");

//load data
section = string("debug");

//deactivateOutside
deactivateOutside = ini_read_string(section, "deactivateOutside", "All");
//yallVehicleCircles - draw helpful circles around vehicles selection radius
yallVehicleCircles = ini_read_string(section, "yallVehicleCircles", "Off");
//supplyPackValue - draw helpful circles around vehicles selection radius
supplyPackValue = ini_read_real(section, "supplyPackValue", 25);

//destroy default lists

//close file
ini_close(); 

/* */
/// game menu

//gameStart - if game just started
global.gameStart = true;

//path - name of current path
global.path = noone; //ds_map in ds_map paths

/* */
///globals
global.Menu = id;
global.online = false;
global.haveserver = false; // set in obj_server

/* */
/// server
// list to hold data for different menus, lobby
serverData = ds_list_create();

/* */
/// load controls

// controlSelected - selected controls in the controls menu
controlSelected = 0;
// controlsMax - the amount of controls
controlsMax = 2;

// check if file exists
if (file_exists("controls.ini")) {
    // load previous controls
    scr_loadControls();
    }
else {
    // load defaults
    scr_setControlsDefault(0, CONTROLS_MOUSE);
    // local 2
    scr_setControlsDefault(1, CONTROLS_KEYBOARD);
    
    // save controls
    scr_saveControls();
    }

/* */
///tutorial

// tutorial - whether this is the first time, no prior paths
global.tutorial = false;

/* */
/*  */
