/// @description Create block
if place_empty(x, y){
	with (instance_create_layer(x, y, "lay_instances", obj_block)){
		if (other.sticky) {
			sticky = true;
		}
	}
}
