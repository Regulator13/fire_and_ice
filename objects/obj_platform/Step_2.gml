/// @description Movement

var grid_size = 32

//If the platform is frozen, stop it
if hp == hp_max{
	hspeed = 0
	vspeed = 0
}
if active{
	//If in a moving state
	if hp < hp_max{
		///Vertical
		if is_vertical{
			//calculate bounds of movement
			var upper_bound = start_y - (hp_max - hp) * grid_size * 2
			var lower_bound = start_y
		
			//move
			vspeed = dir * move_speed
		
			//turn around
			if alarm[1] <= 0{
				if y + vspeed < upper_bound{
					dir = 1
					//Don't stop if the bounds have just been changed
					if y == upper_bound{
						vspeed = 0
						alarm[0] = turn_around_delay
						active = false
					}
				}
				
				if y + vspeed > lower_bound{
					dir = -1
					//Don't stop if the bounds have just been changed
					if y == lower_bound{
						vspeed = 0
						alarm[0] = turn_around_delay
						active = false
					}
				}
			}
		}
	
		///Horizontal
		else{
			//calculate bounds of movement
			var upper_bound = start_x + (hp_max - hp) * grid_size
			var lower_bound = start_x - (hp_max - hp) * grid_size
		
			//move
			hspeed = dir * move_speed
			
			//turn around
			if alarm[1] <= 0{
				if x + hspeed > upper_bound{
					dir = -1
					//Don't stop if the bounds have just been changed
					if x == upper_bound{
						hspeed = 0
						alarm[0] = turn_around_delay
						active = false
					}
				}
				
				if x + hspeed < lower_bound{
					dir = 1
					//Don't stop if the bounds have just been changed
					if x == lower_bound{
						hspeed = 0
						alarm[0] = turn_around_delay
						active = false
					}
				}
			}
		}
		
		///Turn around at obstacles
		with instance_place(x + hspeed, y + vspeed, par_physics){
			if frozen or stuck{
				other.hspeed = 0
				other.vspeed = 0
				other.dir *= -1
			}
		}
		
		//Turn around at blocks
		with instance_place(x + hspeed, y + vspeed, obj_blockBig){
			other.hspeed = 0
			other.vspeed = 0
			other.dir *= -1
		}
		
		///Push characters out of the way to avoid getting stuck
		with(instance_place(x + hspeed, y, obj_character)){
			x += scr_contactx(other.hspeed);
		}
	}
}
