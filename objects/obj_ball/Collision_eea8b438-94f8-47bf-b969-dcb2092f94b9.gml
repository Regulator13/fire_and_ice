/// @description Change distance

//fireball makes platforms go further, iceball makes platforms stop
if (other.hp > 0 and attack > 0) or (other.hp < other.hp_max and attack < 0){
	other.hp -= sign(attack)
	other.image_index += sign(attack)
}

instance_destroy()
