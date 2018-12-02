/// @description Freeze and explode
event_inherited();


//Countdown particle
if not global.online{
	if (freeze_buffer < freeze_buffer_max and freeze_buffer >= 1*20) {
		switch (freeze_buffer) {
			case 3 * 20 - 1:
				part_particles_create(obj_particle.ps_countdown, x, y - 16, obj_particle.prt_countdown3, 1)
				break;
			
			case 2 * 20:
				part_particles_create(obj_particle.ps_countdown, x, y - 16, obj_particle.prt_countdown2, 1)
				break;
				
			case 1 * 20:
				part_particles_create(obj_particle.ps_countdown, x, y - 16, obj_particle.prt_countdown1, 1)
				break;
		}
	}
}

else{
	if (freeze_buffer < freeze_buffer_max and freeze_buffer >= 1*20) {
	    switch (freeze_buffer) {
	        case 3*20-1:
	            with (instance_create_layer(x, y-16, "lay_instances", obj_countdown)) image_index = 0;
	            break;
	        case 2*20:
	            with (instance_create_layer(x, y-16, "lay_instances", obj_countdown)) image_index = 1;
	            break;
	        case 1*20:
	            with (instance_create_layer(x, y-16, "lay_instances", obj_countdown)) image_index = 2;
	            break;
	    }
	}
}

//keep hp in bounds
if (hp < 0){
	hp = 0;
}

if (hp > hp_max){
	hp = hp_max;
}

//freeze_buffer
if (will_freeze) {
	//once timer is out
    if (freeze_buffer < 0*30) {
		if Holder == noone{
	        frozen = true;
	        active = true;
	        hp = hp_normal+1;
	        will_freeze = false;
	        freeze_buffer = freeze_buffer_max;
		}
		
		//Reset buffer if holding something
		else{
			will_freeze = false
			freeze_buffer = freeze_buffer_max
		}
    }
	
	else freeze_buffer -= 1;
}

//explode
if (ignite){
	//once timer is out
    if (freeze_buffer < 0*30){
		if Holder == noone{
	        if global.online{
				instance_create_layer(x+sprite_width/2, y+sprite_height/2, "lay_instances", obj_explosion);
			}
			else{
				part_particles_create(obj_particle.ps_explosion, x + 8, y + 8, obj_particle.prt_explosion, 1)
				//Create explosion and deal damage to all those in rectangle
				Collided = scr_collision_rectangle_list(x - (32 - sprite_width/2), y - (32 - sprite_height/2), x + (32 - sprite_width/2), y + (32 - sprite_height/2), par_block, false, true)
		        if !ds_list_empty(Collided){
					for (var i=0; i<ds_list_size(Collided); i++){
						Collided[| i].hp -= 10 //explosion damage
						if Collided[| i].object_index == obj_water_spawn instance_destroy(Collided[| i])
						else if Collided[| i].object_index == obj_recharge_station instance_destroy(Collided[| i])
					}
				}
				ds_list_destroy(Collided)
			}
		
	        instance_destroy();
		}
		else{
			ignite = false
			freeze_buffer = freeze_buffer_max
		}
    }
	else freeze_buffer -= 1;
}

//freeze
if (hp > hp_normal) {
    active = false;
    frozen = true;
}

else {
    if (frozen) {
        active = true;
        freeze_buffer = freeze_buffer_max;
        will_freeze = false;
    }
	
	frozen = false;
}

//If frozen player's cannot pass through them
if frozen{
	can_pass_through = false
}
else{
	can_pass_through = true
}

image_index = hp;
