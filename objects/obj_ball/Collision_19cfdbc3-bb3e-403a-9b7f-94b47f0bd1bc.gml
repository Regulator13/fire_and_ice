/// @description Attack

if other.from_water{
	with other{
		instance_create_layer(x, y, "Compatibility_Instances_Depth_0", obj_water_drop)
		instance_destroy()
	}
}

else{
	other.hp -= attack;
	if (instance_exists(source)) {
	    other.moochProof = source.team.team;
	}
}

instance_destroy()
