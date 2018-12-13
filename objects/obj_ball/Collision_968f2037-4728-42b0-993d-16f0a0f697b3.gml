/// @description Attack
//Don't effect corpses other people are holding
if other.Holder == noone{
	//If a fireball hits an ignited corpse, explode it instantly
	if attack > 0 and other.ignite{
		other.ignite_buffer = 0
	}
	else{
		//If the block is sitting on a platform, trigger the platform instead
		var Inst_platform = instance_place(x, y + 1, obj_platform)
		if instance_exists(Inst_platform){
			Inst_platform.hp -= sign(attack)
		}
		//Otherwise burn or freeze the block
		else other.hp -= attack
	}
}

if (instance_exists(Source)) {
    other.mooch_proof = Source.Team.Team;
}

instance_destroy();
