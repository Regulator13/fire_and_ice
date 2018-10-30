/// @function  scr_mouse_set_throw_dir(strength, mass, playerX, playerY, mouseX, mouseY, dirX)
/// @description  Set the direction for a thrown object
/// @param strength int | strength of player
/// @param mass int | mass of item thrown
/// @param playerX int | player's x coordinate
/// @param playerY int | player's y coordinate
/// @param mouseX int | mouse's x coordinate
/// @param mouseY int | mouse's y coordinate
// Returns: vspeed and hspeed of throw object

//Arguments
var strength = argument0
var mass = argument1
var playerX = argument2
var playerY = argument3
var mouseX = argument4
var mouseY = argument5
var dirX = argument6

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
vspeed = ((strength / mass) + logn(max_slope, slope) * (strength / mass)) * dirY
hspeed = (2*(strength / mass) - abs(vspeed)) * dirX 