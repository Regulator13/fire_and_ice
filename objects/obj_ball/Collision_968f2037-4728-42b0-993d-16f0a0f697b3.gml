/// @description Attack
//Don't effect corpses other people are holding
if other.Holder == noone{
	//If a fireball hits an ignited corpse, explode it instantly
	if attack > 0 and other.ignite{
		other.ignite_buffer = 0
	}
	else other.hp -= attack;
}

if (instance_exists(Source)) {
    other.mooch_proof = Source.Team.Team;
}

instance_destroy();
