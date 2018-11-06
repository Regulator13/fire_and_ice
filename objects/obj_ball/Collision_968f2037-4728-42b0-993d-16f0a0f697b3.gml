/// @description Attack
other.hp -= attack;

if (instance_exists(Source)) {
    other.mooch_proof = Source.Team.Team;
}

instance_destroy();
