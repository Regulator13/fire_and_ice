/// @description Destroy particles

if part_system_exists(ps_rain){
	part_system_destroy(ps_rain)
	part_emitter_destroy_all(ps_rain)
}