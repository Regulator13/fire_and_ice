/// @description Physics

//Start the image moving
if image_index = image_number - 2{
	animation_end = true
	gravity_incr = 0.4
	image_speed = 0
	image_index = 9
	vspeed = 2
}

if (active) {
	// Apply gravity (and jumping)
	if (vspeed < gravity_max) {
		//gravity increment
		vspeed += gravity_incr;
			
		//keep gravity in bounds
		if (vspeed > gravity_max) vspeed = gravity_max;
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

//Destroy when it hits water
if y > room_height - sprite_height - obj_control.water_height - 32{
	instance_destroy()
}