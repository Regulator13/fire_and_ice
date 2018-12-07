/// @description Freeze and explode

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

//destroy
if (hp < 0){
	instance_destroy();
}

//keep hp in bounds
if (hp > hp_max){
	hp = hp_max;
}

//freeze_buffer
if (will_freeze) {
    //freeze buffer
    if freeze_buffer < 0{
		if Holder == noone{
	        frozen = true;
	        active = true;
	        hp = hp_normal+1;
	        will_freeze = false;
	        freeze_buffer = freeze_buffer_max;
		}
		
		//Player still holding block, reset buffer
		else{
			will_freeze = false
			freeze_buffer = freeze_buffer_max
		}
    }
		
    else freeze_buffer -= 1;
}

//explode
if (ignite) {
    //freeze buffer
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

//set image
image_index = hp;

///Sticky Blocks
if (sticky) {
		if global.Menu.animations_on = true{
		if image_index <= 1{
			image_index += 1
		}
		if image_index >= 5{
			image_index -= 1
		}
	}
    fric = 4; //increase friction because its "sticky"
    
    //if not being held, stick
    if !(instance_exists(Holder)) {
        if(!place_free(x+hspeed, y)) {
			//stick right against block
            while(!place_free(x+hspeed, y)) {
		        hspeed = scr_reduce(hspeed);
		        if hspeed = 0 break;
		    }
			
            vspeed = 0;
            active = false; //ignore physics
            stuck = true; //keep solid
			
			//If less than half of the block is touching, unstick
			if scr_num_pixels_touching_sides() <= sprite_height / 2{
				stuck = false
				active = true
			}
        }
    }
}

/// explosions
with(instance_place(x, y, obj_explosion)) {   
    other.hp -= damage;
}

event_inherited();
