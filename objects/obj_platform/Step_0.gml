/// @description Movement

var grid_size = 32

//If the platform is frozen, stop it
if hp == hp_max{
	hspeed = 0
	vspeed = 0
}

//If in a moving state
if hp < hp_max{
	///Vertical
	if is_vertical{
		//calculate bounds of movement
		var upper_bound = start_y - (hp_max - hp) * grid_size * 2
		var lower_bound = start_y
		
		//move
		if vspeed <= 0{
			vspeed = -move_speed
		}
	
		else{
			vspeed = move_speed
		}
		
		//turn around
		if y <= upper_bound{
			vspeed = move_speed
		}
		if y >= lower_bound{
			vspeed = -move_speed
		}
	}
	
	///Horizontal
	else{
		//calculate bounds of movement
		var upper_bound = start_x + (hp_max - hp) * grid_size
		var lower_bound = start_x - (hp_max - hp) * grid_size
		
		//move
		if hspeed >= 0{
			hspeed = move_speed
		}
	
		else{
			hspeed = -move_speed
		}
		
		//turn around
		if x >= upper_bound{
			hspeed = -move_speed
		}
		if x <= lower_bound{
			hspeed = move_speed
		}
	}
}
	