/// @description  initialize self

if (global.online && !global.haveserver) instance_destroy();

//Set rate of water
water_height = 0;
water_buffer = true;

//globals
global.players = 0;

//player total
global.playerTotal = 5;

//score
global.scoreWin = 100;
global.scoreObject = 10;
global.scoreLife = 100; //score required to get a heart
//global.scoreY = room_height-/100; //not used
global.scoreLVL = 5;
global.scoreFirst = 25;

//global.cooperativeMode
global.cooperativeMode = false;

// small buffer to allow server to catch up
checkWinBuffer = 60;

//whether animations are on or off
animations_on = true

