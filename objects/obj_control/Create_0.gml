/// @description Initialize self
//Destroy if no server
if (global.online and not global.have_server) instance_destroy();

//Set rate of water
water_height = 0;
water_buffer = true;
rain_active = false

//Players
global.players = 0;
global.player_total = 5;

///Score
global.score_win = 100; //points for completing the level
global.score_object = 10; //points for a coin
global.score_level = 5; //points per level
global.score_first = 25; //points for completing level first

//small buffer to allow server to catch up
check_win_buffer = 60;

//TODO Move this variable to a button
//whether animations are on or off
animations_on = true

///artifacts
//artifact
global.score_life = 100; //score required to get a heart

