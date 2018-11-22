/// @function scr_change_keyboard_aim(aim_direction)
/// @description Move the aiming reticule for the player
/// @param int | Direction the player is aiming 0 = up; 180 = down
/// @return none

var aim_direction = argument0

if aim_direction < 180{
	return aim_direction + 6
}

else{
	return 0
}
