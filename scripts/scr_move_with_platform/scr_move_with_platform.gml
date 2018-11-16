/// @function scr_move_with_platforms()
/// @description Move the executing object with the platform beneath it
/// @return none

with instance_place(x, y + obj_platform.move_speed + 1, obj_platform){
	//Vertical
	if is_vertical{
		other.y += vspeed
		
		//If stuck in platform move up
		while place_meeting(x, y + vspeed, other){
			other.y -= 1
		}
		
		//If moving slowly, contact the platform (downward)
		if other.vspeed < 3{
			while !place_meeting(x, y + vspeed - 1, other){
				other.y += 1
			}
		}
	}
	
	//Horizontal
	if not is_vertical{
		other.x += hspeed
	}
}