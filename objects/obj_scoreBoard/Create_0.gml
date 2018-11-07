/// @description Shrink water delay
if (global.online and !global.have_server){
	instance_destroy();
}

else {
	if (global.continue_game) {
		if global.water_delay > 300{
			global.water_delay -= 100;
		}
	    else global.water_rate += .02
	}
}
