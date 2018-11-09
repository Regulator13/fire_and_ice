/// @description Make the player fall

if not climbing{
	hspeed = -climb_dir
	gravity_incr = 0.4
	clinging = false
	//make the player fall for a bit
	active = false
	if alarm[1] < 0{
		alarm[1] = 5
	}
}