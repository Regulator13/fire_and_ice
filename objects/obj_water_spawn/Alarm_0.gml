/// @description Create water droplet; Reset alarm

instance_create_layer(x + 8, y + 8, "Instances", obj_water_drop)

alarm_set(0,drop_delay)