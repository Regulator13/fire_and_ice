/// @description  @description Blow Up

//Blow up block
if (hp <= 0){
    hp = 0;
	
    // Apply gravity (and jumping)
    if (vspeed < gravity_max){
        vspeed += gravity_incr;

        if (vspeed > gravity_max) vspeed = gravity_max;
	}

    //collide with solid objects
    while(!place_free(x+hspeed, y)){
        hspeed = scr_reduce(hspeed);
        if hspeed = 0 break;
    }
	
    while(!place_free(x+hspeed,y+vspeed)){
        vspeed = scr_reduce(vspeed);
        if vspeed = 0 break;
    }
}

//Keep in bounds
if (hp > hp_max){
	hp = hp_max;
}

//Set image
image_index = hp;


///Collisions
with (instance_place(x, y, obj_explosion)){
    other.hp -= damage;
    }

