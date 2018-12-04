/// @function scr_hang_with_platforms()
/// @description Move the player with the platform if they are hanging onto the edge
/// @return none

with instance_place(x + climb_dir, y + obj_platform.move_speed, obj_platform){
	//Vertical
	if is_vertical{
		other.y += vspeed
	}
		
	//Horizontal
	if not is_vertical{
		other.x += hspeed
	}
}
