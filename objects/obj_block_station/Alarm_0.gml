/// @description Create block
with (instance_create_layer(x, y, "lay_instances", obj_block)){
	if (other.sticky) {
		sticky = true;
	}
}
