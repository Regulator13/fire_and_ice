/// @description Freeze block

instance_destroy(other)

//If it's an ice ball, freeze the block
if other.attack < 0{
	with instance_create_layer(x, y, "lay_instances", obj_block){
		hp = 4
		from_water = true
	}
	
	instance_destroy()
}

//Fire balls evaporate water
else{
	instance_destroy()
}
