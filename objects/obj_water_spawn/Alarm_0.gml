/// @description Create water droplet

if not frozen{
	instance_create_layer(x, y, "lay_instances", obj_water_drop)
}

//reset alarm
alarm_set(0,drop_delay)
