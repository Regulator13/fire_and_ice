/// @function scr_attempt_climbing()
/// @description Check to see if the player can hang or climb, if they can, do so
/// @return none

//Make sure the player isn't on or near the ground
if place_free(x, y + 16) and place_free(x, y + 32){
	//Make sure the player isn't using a jetpack
	if not (has_jetpack and right_action_is_pressed){
		//Make sure the player isn't just touching the block with their feet
		if y > other.y{
			//Stick to the block with a pick
			if scr_has_climbing_pick(){
				scr_cling_to_wall()
			}
		}
						
		//if the player is near the top allow them to hang onto the ledge
		if (other.y > y + y_diff - hanging_tol) and (other.y < y + y_diff + hanging_tol){
			if place_free(x + dir * 4, y - hanging_tol - sprite_height){
				scr_enter_hanging()
			}
		}	
	}
}
