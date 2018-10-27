/// @description shrink water delay
if (global.online && !global.haveserver) instance_destroy();

else {
	if (global.continueGame) {
		if global.waterDelay > 300{
			global.waterDelay -= 100;
		}
	    else global.water_rate += .02
	    }
	}

