/// @function scr_climb()
/// @description climbs a ledge
/// @return none

hanging = false
x += climb_dir * 4
y -= sprite_height - y_diff
//apply gravity again after it was lost
gravity_incr = 0.4
active = true
//Stop the player from continuing a previous jump when they climb
jump_is_pressed = false
