/// @description  Turn around
event_inherited();
//Turn around
if(!place_free(x+1,y) or place_free(x+sprite_width+1,y+1))
{hspeed = -hspeed;
}
else if(!place_free(x-1,y) or place_free(x-sprite_width-1,y+1))
{hspeed = -hspeed;
}

//die if no block below
if (place_free(x, y+1)) {
    //die
    hp = -1;
    }

///collisions

//fire
with(instance_place(x, y, obj_ball)) {   
    other.hp -= abs(attack);
    instance_destroy();
    }

with(instance_place(x, y, obj_explosion)) {   
    other.hp -= damage;
    }

