/// @description  @description Raise Water
if(water_buffer = false)
{water_height += global.water_rate;
}

//check if all players died
if (checkWinBuffer < 0) {
    if not (instance_exists(obj_character)) {
        //end level
        if (global.win) {
            global.level += 1;
            }
        else {
            global.continueGame = false;
            }
        //goto score
        if (gotoScore) {
            alarm[1] = 30;
            gotoScore = false;
            checkWinBuffer = 60;
            }
        }
    }
else checkWinBuffer --;


