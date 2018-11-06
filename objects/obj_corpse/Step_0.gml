/// @description Freeze and explode
event_inherited();


//Countdown particle
if (freeze_buffer < freeze_buffer_max && freeze_buffer >= 1*30) {
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

image_index = hp;
