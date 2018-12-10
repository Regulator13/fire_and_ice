/// @description Collisions
//die
if(hp <= 0){
	with instance_create_layer(x, y, "lay_instances", obj_corpse)
	instance_destroy();
}

///Collisions
//fireball
with(instance_place(x, y, obj_ball)) {   
    other.hp -= abs(attack);
    instance_destroy();
}

with(instance_place(x, y, obj_explosion)) {   
    other.hp -= damage;
}

//die if no block below
if (place_free(x, y+1)) {
    hp = -1;
}
