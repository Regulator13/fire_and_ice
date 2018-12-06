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

///Animations
ps_rain = noone

if global.Menu.animations_on and global.Menu.water_on{
	ps_rain = part_system_create()
}

///artifacts
//artifact
global.score_life = 100; //score required to get a heart

