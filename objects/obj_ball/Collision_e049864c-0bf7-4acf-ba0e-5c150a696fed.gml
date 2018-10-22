/// @description Freeze water spawn

//Freeze unfrozen spawner
if not other.frozen{
	if attack < 0{
		with other{
			frozen = true
			sprite_index = spr_frozen_water_source
		}
	}
}

//Unfreeze frozen spawner
if other.frozen{
	if attack > 0{
		with other{
			frozen = false
			sprite_index = spr_water_spawn
		}
	}
}

instance_destroy()