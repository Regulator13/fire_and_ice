/// @function scr_enter_hanging()
/// @description Enter the player into the hanging state when near a ledge
/// @return none

y = other.y - y_diff
hspeed = 0
vspeed = 0
climb_dir = dir
gravity_incr = 0
can_change_dir = true //The player can change directions after hanging on an edge
active = false
hanging = true
