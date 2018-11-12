/// @description Freeze and explode

//Countdown particle
if (freeze_buffer < freeze_buffer_max and freeze_buffer >= 1*30) {
    switch (freeze_buffer) {
        case 3*30-1:
            with (instance_create_layer(x+8, y-16, "lay_instances", prt_countdown)) image_index = 0;
            break;
			
        case 2*30:
            with (instance_create_layer(x+8, y-16, "lay_instances", prt_countdown)) image_index = 1;
            break;
			
        case 1*30:
            with (instance_create_layer(x+8, y-16, "lay_instances", prt_countdown)) image_index = 2;
            break;
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
    if (freeze_buffer < 0*30) {
        instance_create_layer(x+sprite_width/2, y+sprite_height/2, "lay_instances", obj_explosion);
        instance_destroy();
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
	//REMOVE? Couldn't the sprite be set upon creation in obj_blockStation?
    sprite_index = spr_blockSticky;
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
			if scr_check_num_pixels_touching() <= sprite_height / 2{
				stuck = false
				active = true
			}
        }
    }
}

else{
	fric = .4 + hp_normal-hp;
}

/// explosions
with(instance_place(x, y, obj_explosion)) {   
    other.hp -= damage;
}

event_inherited();
