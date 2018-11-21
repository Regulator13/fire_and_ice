/// @function scr_throw_using_keyboard(strength, mass, aim_direction, dirX)
/// @description Throw a fireball, iceball, or object, using the keyboard
/// @description  Set the direction for a thrown object
/// @param strength int | strength of player
/// @param mass int | mass of item thrown
/// @param aim_direction int | the direction the player is aiming 0 = up; 180 = down
/// @param dirX int | the direction the player is facing
/// @return

///Initializations
var strength = argument0
var mass = argument1
var aim_direction = argument2
var dirX = argument3

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
vspeed = (dcos(angle) * (strength*5 / mass)*2) * dirY
hspeed = (2*(strength*5 / mass) - abs(vspeed)) * dirX
