/// @description  freeze buffer particle
if (freezeBuffer < freezeBufferMax && freezeBuffer >= 1*30) {
    switch (freezeBuffer) {
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

/// freezing and exploding

//hp
if (hp < 0) hp = 0;//instance_destroy();
if (hp > hp_max) hp = hp_max;

//freezeBuffer
if (willFreeze) {
    //freeze buffer
    if (freezeBuffer < 0*30) {
		if holder == noone{
	        frozen = true;
	        active = true;
	        hp = hp_normal+1;
	        willFreeze = false;
	        freezeBuffer = freezeBufferMax;
		}
		
		//Reset buffer if holding something
		else{
			willFreeze = false
			freezeBuffer = freezeBufferMax
		}
    }
	else freezeBuffer -= 1;
}

//explode
if (ignite) {
    //freeze buffer
    if (freezeBuffer < 0*30) {
        instance_create_layer(x+sprite_width/2, y+sprite_height/2, "lay_instances", obj_explosion);
        instance_destroy();
        }
    else freezeBuffer -= 1;
    }

//freeze
if (hp > hp_normal) {
    active = false;
    frozen = true;
    }
else {
    if (frozen) {
        //unfreeze
        active = true;
        freezeBuffer = freezeBufferMax;
        willFreeze = false;
        }
    frozen = false;
    }

//set image
image_index = hp;

//inherited
event_inherited();

