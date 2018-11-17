/// @description Collisions
//die
if(hp <= 0){
	instance_create_layer(x, y, "lay_instances", obj_corpse);
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
