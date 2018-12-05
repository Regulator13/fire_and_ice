/// @description Freeze water spawn

//Freeze unfrozen spawner
if not other.frozen{
	if attack < 0{
		with other{
			frozen = true
			image_index = 1
		}
	}
}

//Unfreeze frozen spawner
if other.frozen{
	if attack > 0{
		with other{
			frozen = false
			image_index = 0
		}
	}
}

instance_destroy()