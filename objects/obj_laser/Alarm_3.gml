/// @description Flip laser state

if laser_flicker_num > 0{
	laser_on = not laser_on
	laser_flicker_num -= 1
	alarm[3] = irandom_range(2,4)
}
