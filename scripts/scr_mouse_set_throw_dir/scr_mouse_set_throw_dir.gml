/// @function  scr_mouse_set_throw_dir(strength, mass, playerX, playerY, mouseX, mouseY, dirX, has_gun)
/// @description  Set the direction for a thrown object
/// @param strength int | strength of player
/// @param mass int | mass of item thrown
/// @param playerX int | player's x coordinate
/// @param playerY int | player's y coordinate
/// @param mouseX int | mouse's x coordinate
/// @param mouseY int | mouse's y coordinate
/// @param has_gun bool | whether the player has equipped a gun item or not
// Returns: vspeed and hspeed of throw object

//Arguments
var strength = argument0
var mass = argument1
var playerX = argument2
var playerY = argument3
var mouseX = argument4
var mouseY = argument5
var dirX = argument6
var has_gun = argument7

//Definitions
var dirY

//Direction
if mouseY > playerY{
	dirY = 1
}
else{
	dirY = -1
}

//Find line of throw
var max_slope = 20
var min_slope = 1/max_slope
var slope = abs((playerY - mouseY) / (mouseX - playerX))
						
if slope > max_slope{
	slope = max_slope
}
						
if slope < min_slope{
	slope = min_slope
}
						
//Normalize the slope from -1 to 1
vspeed = ((strength*5 / mass) + logn(max_slope, slope) * (strength*5 / mass)) * dirY
hspeed = (2*(strength*5 / mass) - abs(vspeed)) * dirX 

//If the player does not have a gun equipped, improve their aiming
if not has_gun{
	//Add to the vspeed to make it pass through the point 2 big blocks away (with gravity) instead of immediately
	var angle = darctan(slope) //Find the angle of fire from the slope (0 = horizontal)
	var x_distance = 64*dcos(angle)//Find the horizontal component of the line to a circle with radius = 64 pixels

	//Add on extra vspeed to compensate for x_distance
	var gravity_incr = 0.4
	vspeed -= (x_distance / max(abs(hspeed), 3)) * (gravity_incr / 2)
}
