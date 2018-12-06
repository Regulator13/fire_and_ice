/// @function scr_throw_using_keyboard(strength, mass, aim_direction, dirX, has_gun)
/// @description Throw a fireball, iceball, or object, using the keyboard
/// @description  Set the direction for a thrown object
/// @param strength int | strength of player
/// @param mass int | mass of item thrown
/// @param aim_direction int | the direction the player is aiming 0 = up; 180 = down
/// @param dirX int | the direction the player is facing
/// @param has_gun bool | whether the player has equipped a gun item or not
/// @return

///Initializations
var strength = argument0
var mass = argument1
var aim_direction = argument2
var dirX = argument3
var has_gun = argument4

//Find line of throw
var angle //angle of the throw
var dirY //whether the vspeed is positive or negative

//Set the angle of throw
if aim_direction <= 90{
	angle = aim_direction
	dirY = -1
}
else{
	angle = -(180 - aim_direction)
	dirY = 1
}

//Normalize the slope
vspeed = (dcos(angle) * (strength*4 / mass)*2) * dirY
hspeed = (2*(strength*4 / mass) - abs(vspeed)) * dirX

//If the player does not have a gun equipped, improve their aiming
if not has_gun{
	//Add to the vspeed to make it pass through the point 2 big blocks away (with gravity) instead of immediately
	var x_distance = max(64*dcos(abs(angle-90)), 1)//Find the horizontal component of the line to a circle with radius = 64 pixels

	//Add on extra vspeed to compensate for x_distance
	var gravity_incr = 0.4
	vspeed -= (x_distance / max(abs(hspeed), 3)) * (gravity_incr / 2)
}
