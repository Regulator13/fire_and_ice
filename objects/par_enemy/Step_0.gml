/// @description Die

if(hp <= 0){
	instance_create_layer(x,y, "lay_instances", obj_corpse);
	instance_destroy();
}


