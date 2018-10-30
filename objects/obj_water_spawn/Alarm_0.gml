/// @description Create water droplet; Reset alarm

if not frozen{
	instance_create_layer(x, y, "Instances", obj_water_drop)
}

alarm_set(0,drop_delay)