/// @description Destroy particles

if part_system_exists(ps_rain){
	part_system_destroy(ps_rain)
	part_emitter_destroy_all(ps_rain)
}

//Destroy all obj_balls to delete any particles that remain.
instance_destroy(obj_ball)
