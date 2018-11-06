/// @description  spectate
if (global.online) {
	//move camera up
	if (keyboard_check_pressed(vk_up)) vspeed = -1;
	
	//move camera dow
	else if (keyboard_check_pressed(vk_down)) vspeed = 1;
	
	//stand still
	else vspeed = 0;
}
