/// @description raise water
if(water_buffer = false){
	water_height += global.water_rate;
	}

//check if all players died
if (check_win_buffer < 0) { //Networking
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
            check_win_buffer = 60;
            }
        }
    }
else check_win_buffer --;


