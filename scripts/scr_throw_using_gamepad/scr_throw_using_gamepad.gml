/// @function  scr_throw_using_gamepad(strength, mass, gamepad_aimx, gamepad_aimy)
/// @description  Set the direction for a thrown object
/// @param strength int | strength of player
/// @param mass int | mass of item thrown
/// @param gamepad_aimx int | x value of aiming joystick
/// @param gamepad_aimy int | y value of aiming joystick
// Returns: vspeed and hspeed of throw object

//Arguments
var strength = argument0
var mass = argument1
var aim_x = argument2
var aim_y = argument3

//Definitions
var dirY = sign(aim_y)
var dirX = sign(aim_x)

//Find line of throw
var max_slope = 20
var min_slope = 1/max_slope
var slope = abs(aim_y) / abs(aim_x)
						
if slope > max_slope{
	slope = max_slope
}
						
if slope < min_slope{
	slope = min_slope
}
						
//Normalize the slope from -1 to 1
vspeed = ((strength*5 / mass) + logn(max_slope, slope) * (strength*5 / mass)) * dirY
hspeed = (2*(strength*5 / mass) - abs(vspeed)) * dirX 