/// @description Turn laser on
laser_flicker_num = laser_flicker_num_max

//Glitch back on
alarm[3] = irandom_range(2,4)

//reset gitch timer
alarm_set(1,irandom_range(120,180))
