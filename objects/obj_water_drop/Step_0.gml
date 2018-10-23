/// @description Falling; Destroy on collision with solid;
/// Damage player

if (active) {
	// Apply gravity (and jumping)
	if (vspeed < gravityMax) {
		//gravity increment
		vspeed += gravityI;
			
		//keep gravity in bounds
		if (vspeed > gravityMax) vspeed = gravityMax;
		}

	//Collision with solid
	if not place_free(x, y){
		instance_destroy()
	}

	//Collision with player
	with instance_place(x, y, obj_character){
		hp -= 10
		instance_destroy(other)
	}
}