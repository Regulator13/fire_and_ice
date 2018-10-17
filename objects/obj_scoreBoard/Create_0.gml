/// @description shrink water delay
if (global.online && !global.haveserver) instance_destroy();
else {
if (global.continueGame) {
    global.waterDelay -= 200;
    if (global.waterDelay < 0) global.water_rate += .05;
    }
    }

