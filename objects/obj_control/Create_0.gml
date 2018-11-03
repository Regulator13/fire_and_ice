/// @description  initialize self

if (global.online && !global.haveserver) instance_destroy();

//Set rate of water
water_height = 0;
water_buffer = true;

//globals
global.players = 0;

//player total
global.player_total = 5;

//score
global.score_win = 100;
global.score_object = 10; //points for a coin
//artifact
global.score_life = 100; //score required to get a heart
global.score_level = 5;
global.score_first = 25;

//global.cooperative_mode
//artifact
global.cooperative_mode = false;

// small buffer to allow server to catch up
check_win_buffer = 60;

//whether animations are on or off
animations_on = true

