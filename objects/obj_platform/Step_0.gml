/// @description Movement

var grid_size = 32

//If the platform is frozen, stop it
if hp == hp_max{
	hspeed = 0
	vspeed = 0
}

if hp < hp_max{
	
	//Calculate bounds of movement
	//Vertical
	if is_vertical{
		var upper_bound = start_y - (hp_max - hp) * grid_size * 2
		var lower_bound = start_y
	}
	
	//Horizontal
	else{
		var upper_bound = start_x + (hp_max - hp) * grid_size
		var lower_bound = start_x - (hp_max - hp) * grid_size
	}
	
	//Move
	//Vertical
	if is_vertical{
		if vspeed <= 0{
			vspeed = -move_speed
		}
	
		else{
			vspeed = move_speed
		}
	}

	//Horizontal
	else{
		if hspeed >= 0{
			hspeed = move_speed
		}
	
		else{
			hspeed = -move_speed
		}
	}

	//Turn around
	//Vertical
	if is_vertical{
		if y <= upper_bound{
			vspeed = move_speed
		}
	
		if y >= lower_bound{
			vspeed = -move_speed
		}
	}
		
	//Horizontal
	else{
		if x >= upper_bound{
			hspeed = -move_speed
		}
		
		if x <= lower_bound{
			hspeed = move_speed
		}
	}
}
		
	