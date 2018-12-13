/// @description Attack

//Turn frozen water back to water
if other.from_water and attack > 0{
	with other{
		with instance_create_layer(x - 8, y - 8, "lay_instances", obj_water_drop){
			//Avoid dripping animation
			image_index = image_number - 1
			gravity_incr = 0.4
			image_speed = 0
			animation_end = true
		}
		
		instance_destroy()
	}
}

//Do not freeze or burn blocks player's are holding
else if other.Holder == noone{
	//If a fireball hits an ignited block, explode it instantly
	if attack > 0 and other.ignite{
		other.ignite_buffer = 0
	}
	else other.hp -= attack;
	if (instance_exists(Source)) {
	    other.mooch_proof = Source.Team.Team;
	}
}

instance_destroy()
