/// @description Create block
if (sticky) {
	with (instance_create_layer(x, y, "lay_instances", obj_block)){
		sticky = true;
	}
}

else instance_create_layer(x, y, "lay_instances", obj_block);
