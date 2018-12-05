/// @description Turn around
event_inherited();

//if a player is nearby shoot
for(var i=0; i<instance_number(obj_character); i++) {
    with (instance_find(obj_character,i)){
		if (abs(y - other.y) < 100){
			with other{
				if can_attack{
					//Delay the next attack
					can_attack = false
					alarm[0] = attack_delay
					//Create a bullet 1/4 of the time
					if !irandom(3){
						switch dir{
							default:
						
							//Shoot left
							case -1:
								with instance_create_layer(x + sprite_width/2, y, "lay_instances", obj_laser_beam){
									hspeed = other.dir*10
								}
							
								break
						
							//Shoot right
							case 1:
								with instance_create_layer(x + sprite_width/2, y, "lay_instances", obj_laser_beam){
									hspeed = other.dir*10
								}
							
								break
						}
					}		
				}
			}
		}
	}
}
