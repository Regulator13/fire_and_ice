/// @function scr_use_gun()
/// @description Set the stats for a fireball/iceball fired from a gun
/// @return none

//if carrying a gun give the ball special stats
for (var i=0; i<ds_list_size(other.Equipped_objects); i++){
	if other.Equipped_objects[| i].object_index == obj_gun{
		//make the attack equal to the gun's damage
		attack *= other.Equipped_objects[| i].dmg
		//Make the bullet not fall
		gravity_incr = 0
		//Tell the player they have a gun
		other.has_gun = true
		break
	}
}