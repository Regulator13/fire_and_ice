/// @function scr_attempt_climbing()
/// @description Check to see if the player can hang or climb, if they can, do so
/// @return none

//Make sure the player isn't on or near the ground
if place_free(x, y + 16) and place_free(x, y + 32){
	//Make sure the player isn't using a jetpack
	if not (has_jetpack and right_action_is_pressed){
		//Make sure the player is below the block and wouldn't be able to grab the ledge on the next step
		if y > other.y - HANGING_TOL - y_diff and (y + vspeed < other.y - HANGING_TOL - y_diff or y + vspeed > other.y + HANGING_TOL - y_diff){
			//Stick to the block with a pick
			if scr_has_climbing_pick(){
				scr_cling_to_wall()
			}
			
			//if the player is near the top allow them to hang onto the ledge
			if y + y_diff < other.y + HANGING_TOL{
				//Automatically turn to face the wall
				if other.x > x dir = 1
				else dir = -1
				//Must add block width when facing negative direction and subtract player width in the positive direction
				if place_free(other.x - min(dir*other.sprite_width, 0) - max(dir*sprite_width, 0) + dir * 4, other.y - sprite_height)
				or instance_position(other.x - min(dir*other.sprite_width, 0) + dir * 4, other.y - sprite_height/2, par_physics) != noone{
					scr_enter_hanging()
				}
			}
		}
	}
}
