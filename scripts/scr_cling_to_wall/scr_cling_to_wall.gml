/// @function scr_cling_to_wall()
/// @description Makes the player cling to a wall or block
/// @return none

//give them 1 second to decide to climb or not
hspeed = 0
vspeed = 0
gravity_incr = 0
clinging = true
active = false
climb_dir = dir
if alarm[2] <= 0{
	alarm[2] = 30
}
