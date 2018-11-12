/// @description Destroy particles

if animations_on = true{
	part_system_destroy(ps_rain)
	part_emitter_destroy_all(ps_rain)
}