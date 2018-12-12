/// @description Attack
//Don't effect corpses other people are holding
if other.Holder == noone{
	other.hp -= attack;
}

if (instance_exists(Source)) {
    other.mooch_proof = Source.Team.Team;
}

instance_destroy();
