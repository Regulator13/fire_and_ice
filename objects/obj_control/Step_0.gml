/// @description Raise water
if(water_buffer == false and global.Menu.water_on){
	water_height += global.water_rate;
}

//dynamically destroy raindrops at water level
if rain_active = true{
	if global.Menu.animations_on and global.Menu.water_on{
		part_type_life(prt_rain, (room_height - 32 - water_height) / prt_speed, (room_height - 32 - water_height) / prt_speed)
	}
}

//Check if all players died
if (check_win_buffer < 0) {
	//end the level
    if not (instance_exists(obj_character)) {
        if (global.win) {
            global.level += 1;
        }
		
        else {
            global.continue_game = false;
        }
		
        //go to the score screen
        if (gotoScore) {
            alarm[1] = 30;
            gotoScore = false;
            check_win_buffer = 60;
        }
    }
}

else check_win_buffer --;
