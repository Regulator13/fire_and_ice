/// @description Attack

//Turn frozen water back to water
if other.from_water and attack > 0{
	with other{
		instance_create_layer(x, y, "lay_instances", obj_water_drop)
		instance_destroy()
	}
}

else{
	other.hp -= attack;
	if (instance_exists(Source)) {
	    other.mooch_proof = Source.Team.Team;
	}
}

instance_destroy()
