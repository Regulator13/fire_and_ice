/// @function scr_carry_object
/// @description Moves an object with obj_character
/// @return None


if instance_exists(Grab_object){
	Grab_object.x = x + hspeed
	if Grab_object.on_body{
		Grab_object.y = y + vspeed
	}
	
	else Grab_object.y = y - 9 + vspeed
}