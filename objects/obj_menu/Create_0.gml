/// @description Set variables
global.paused = false; //whether game is paused
state = STATE_MAIN; //current game state
state_queue = ds_stack_create()//holds states in order visited for universal back button
buttons = ds_list_create(); //holds menu buttons
selected = 0; //selected button
input_buffer = 0; //small buffer to slow down gamepad input
input_buffer_max = 4;
input_freeze = 0; //small amount of time inbetween menu switches
input_freezeMax = 4;
score_message = ""; //either restart or continue, used with space key
tagLine = "Now with#hang gliders!";
version = "2.15.0";
local_controls = ds_list_create(); //list holding which local players are in

///First menu
scr_menu_init_main();

///Set player variables
players = ds_list_create();
nicknames = ds_list_create();
classes = ds_list_create();
global.player_total = 0; //the total amount of current players
local_players = ds_map_create(); //hold all the local player input objects

///Lobby menu
class_options = ds_list_create(); //character list
ds_list_add(class_options, "grinch", "yeti", "santa", "nutcracker", "reindeer");
team_max = 10;
teams = ds_list_create(); //used for selecting
game_teams = ds_map_create();
names = ds_list_create();

///Online menu
readys = ds_list_create();

///Options menu

//load options
//open file
ini_open("options.ini");

//load data
section = "default";

//set gameMode
gameMode = ini_read_string(section, "gameMode", "Normal");

///Game options menu
section = "gameOptions"

//load game options
animations_on = ini_read_real(section, "animations_on", true);
water_on = ini_read_real(section, "water_on", true)
jetpack_on = ini_read_real(section, "jetpack_on", true)
difficulty = ini_read_real(section, "difficulty", 2)

//close file
ini_close(); 

///Paths menu

//paths
path_names = ds_list_create();
paths = ds_map_create();
path_selected = 0;

///Debug options menu

//load options
//open file
ini_open("options.ini");

//load data
section = string("debug");

deactivateOutside = ini_read_string(section, "deactivateOutside", "All");

//close file
ini_close(); 

///Game menu
global.gameStart = true; //if game just started 
global.path = noone; //name of current path (ds map in ds map paths)
global.Menu = id;
global.online = false;
global.have_server = false; // set in obj_server

///Server
// list to hold data for different menus, lobby
server_data = ds_list_create();

///Controls
controlSelected = 0; // selected controls in the controls menu DESCR?
controlsMax = 7; //the amount of controls DESCR?

//If player previously inputted controls, use those
if (file_exists("controls.ini")) {
    scr_load_controls();
}

//Otherwise use the default controls
else {
    scr_set_controls_default(0, CONTROLS_MOUSE);
    //second player's controls
    scr_set_controls_default(1, CONTROLS_KEYBOARD);
	scr_set_controls_default(2, CONTROLS_GP1);
	scr_set_controls_default(3, CONTROLS_GP2);
	scr_set_controls_default(4, CONTROLS_GP3);
	scr_set_controls_default(5, CONTROLS_GP4);
	scr_set_controls_default(6, CONTROLS_GP5);
    scr_save_controls();
}

///Tutorial
global.tutorial = false; //whether this is the first time, no prior paths

///Artifacts
/*
//nickNames
str = ini_read_string(section, "nicknames", "");
if (str != "") ds_list_read(nicknameIdeas, str);
else nicknameIdeas = nicknamesDefault;
*/
/*
//yallVehicleCircles - draw helpful circles around vehicles selection radius
yallVehicleCircles = ini_read_string(section, "yallVehicleCircles", "Off");
//supplyPackValue - draw helpful circles around vehicles selection radius
supplyPackValue = ini_read_real(section, "supplyPackValue", 25);
*/
